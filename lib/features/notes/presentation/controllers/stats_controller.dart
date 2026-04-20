// ignore_for_file: library_private_types_in_public_api

import 'package:desafio_target/features/notes/domain/models/note_model.dart';
import 'package:desafio_target/features/notes/domain/usecases/get_notes_usecase.dart';
import 'package:desafio_target/core/result/result.dart';
import 'package:mobx/mobx.dart';

part 'stats_controller.g.dart';

class StatsController = _StatsController with _$StatsController;

abstract class _StatsController with Store {
  final GetNotesUseCase _getNotes;

  _StatsController(this._getNotes);

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @observable
  int totalNotes = 0;

  @observable
  int totalChars = 0;

  @observable
  int totalLines = 0;

  @observable
  int totalEdits = 0;

  @observable
  int totalLetters = 0;

  @observable
  int totalDigits = 0;

  @observable
  ObservableMap<String, int> letterFrequency = ObservableMap();

  @observable
  ObservableMap<String, int> digitFrequency = ObservableMap();

  @action
  Future<void> load() async {
    isLoading = true;
    errorMessage = null;

    final result = await _getNotes();
    if (result is Failure<List<NoteModel>>) {
      errorMessage = result.error.message;
      isLoading = false;
      return;
    }

    final notes = (result as Success<List<NoteModel>>).data;
    _compute(notes);
    isLoading = false;
  }

  void _compute(List<NoteModel> notes) {
    totalNotes = notes.length;
    totalEdits = notes.fold(0, (sum, n) => sum + n.editCount);

    final allContent = notes.map((n) => n.content).join('\n');
    totalChars = allContent.replaceAll(' ', '').replaceAll('\n', '').length;
    totalLines = allContent.split('\n').where((l) => l.trim().isNotEmpty).length;

    final letters = <String, int>{};
    final digits = <String, int>{};

    for (final char in allContent.toLowerCase().split('')) {
      if (RegExp(r'[a-záàãâéêíóôõúüçñ]').hasMatch(char)) {
        letters[char] = (letters[char] ?? 0) + 1;
      } else if (RegExp(r'[0-9]').hasMatch(char)) {
        digits[char] = (digits[char] ?? 0) + 1;
      }
    }

    totalLetters = letters.values.fold(0, (a, b) => a + b);
    totalDigits = digits.values.fold(0, (a, b) => a + b);

    final sortedLetters = letters.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
    letterFrequency = ObservableMap.of(Map.fromEntries(sortedLetters.take(5)));

    final sortedDigits = digits.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
    digitFrequency = ObservableMap.of(Map.fromEntries(sortedDigits.take(5)));
  }
}
