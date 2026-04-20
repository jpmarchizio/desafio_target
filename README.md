# Target To-Do

Aplicativo de notas com sincronização em nuvem, desenvolvido como teste técnico para a Target Sistemas.

## Como rodar

### Pré-requisitos

- Flutter SDK `^3.11.5` ([guia de instalação](https://docs.flutter.dev/get-started/install))
- Android Studio / Xcode para emuladores, ou um dispositivo físico
- Conta Firebase (o projeto já vem configurado para `target-todo-jpmarchizio`, basta clonar)

### Passos

```bash
# 1. Instalar dependências
flutter pub get

# 2. Gerar os arquivos do MobX (*.g.dart)
dart run build_runner build --delete-conflicting-outputs
# ou, durante o desenvolvimento:
dart run build_runner watch --delete-conflicting-outputs

# 3. Rodar em um device/emulador conectado
flutter run
```

Se for usar um projeto Firebase próprio, rode `flutterfire configure` para gerar o `firebase_options.dart`.

---

## Features

### Autenticação
- **Login com e-mail e senha** ([login_page.dart](lib/features/auth/presentation/pages/login_page.dart))
- **Criar conta** ([signup_page.dart](lib/features/auth/presentation/pages/signup_page.dart)) — ao se cadastrar, notas criadas anonimamente (local) são migradas para a nuvem.
- **Recuperar senha** ([forgot_password_page.dart](lib/features/auth/presentation/pages/forgot_password_page.dart)) — envia e-mail de reset via Firebase Auth.
- **Modo anônimo** — o usuário pode usar o app sem se cadastrar; as notas ficam apenas no dispositivo (Hive).

### Notas
- **Listagem, criação, edição e exclusão** ([home_page.dart](lib/features/notes/presentation/pages/home_page.dart)).
- Cada nota guarda título opcional, conteúdo, data de criação e contador de edições.
- **Fonte dos dados é escolhida em tempo de execução**: se o usuário está logado, a nota vai para o Firestore; se é anônimo, vai para o Hive local.

### Estatísticas
- Tela dedicada ([stats_page.dart](lib/features/notes/presentation/pages/stats_page.dart)) com:
  - Cards de resumo (nº de notas, linhas, caracteres, edições).
  - Gráfico de pizza comparando letras vs números em todo o conteúdo.
  - Dois gráficos de barras — top 5 letras e top 5 números mais usados.

### Tema
- Toggle claro/escuro disponível na home, na tela de estatísticas e no login.
- A preferência é persistida via `SharedPreferences` e aplicada no boot do app.

---

## Tecnologias e por que foram escolhidas

Além do MobX (solicitado explicitamente no desafio):

### Arquitetura
- **Clean Architecture em camadas** (`data`/`domain`/`presentation`) — separa regras de negócio de detalhes de infraestrutura. Torna o código testável e permite trocar a fonte de dados (Firestore ↔ Hive) sem tocar no domínio.
- **`get_it`** — container de dependency injection simples, sem reflection e sem boilerplate. Facilita registrar singletons (ex: `FirebaseAuth`, repositórios) e factories (controllers, que devem ser instância nova por tela).
- **Sealed `Result<T>`** (`Success` / `Failure`) — evita `try/catch` espalhados na UI e padroniza o tratamento de erros entre camadas. Combinado com pattern matching do Dart 3, gera código legível e exaustivo.

### Navegação
- **`go_router`** — roteamento declarativo recomendado pelo time do Flutter, com suporte nativo a deep links e a `redirect` (usado para proteger rotas e redirecionar com base no estado de autenticação).

### Backend / Persistência
- **Firebase Auth** — solução pronta para autenticação (e-mail/senha, reset de senha), com boa integração com o restante do Firebase. Evita ter que manter um backend próprio para um teste.
- **Cloud Firestore** — banco NoSQL em tempo real para notas de usuários logados. Escala sem servidor próprio e tem SDK oficial maduro.
- **Hive** — storage local rápido e leve, sem SQL. Escolhido para o modo anônimo por ser síncrono e não exigir schema, o que simplifica muito quando o modelo de dados é pequeno.
- **`shared_preferences`** — padrão de fato para key-value simples (tema), nativo em cada plataforma.

### UI
- **`google_fonts`** (Plus Jakarta Sans + Inter) — carrega fontes sob demanda sem precisar versionar arquivos `.ttf`. Mantém a identidade visual com zero esforço de setup.
- **`fl_chart`** — biblioteca de gráficos 100% Flutter (sem WebView ou dependências nativas). Customização alta o bastante para o pie + bar charts da tela de estatísticas.

### Tratamento de erros
- **`ErrorHandler`** centralizado ([error_handler.dart](lib/core/error/error_handler.dart)) — converte exceções de baixo nível (`TimeoutException`, `SocketException`, `FirebaseException`) em `AppError` com mensagens amigáveis em PT-BR, para que a UI nunca precise interpretar exceções cruas.

---

## Estrutura de pastas

```
lib/
├── core/                # DI, rotas, tema, result, erros (infra compartilhada)
├── features/
│   ├── auth/            # login, signup, recuperação de senha
│   └── notes/           # CRUD de notas + estatísticas
│       ├── data/
│       ├── domain/
│       └── presentation/
└── shared/              # widgets e utilitários reutilizáveis
```

Cada feature segue o mesmo padrão: `data` (datasources + repositories concretos), `domain` (models, contratos e usecases) e `presentation` (controllers MobX + pages).
