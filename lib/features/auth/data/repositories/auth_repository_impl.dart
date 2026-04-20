import 'package:desafio_target/core/result/result.dart';
import 'package:desafio_target/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:desafio_target/features/auth/domain/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _datasource;

  const AuthRepositoryImpl(this._datasource);

  @override
  Future<Result<User>> signIn(String email, String password) => _datasource.signIn(email, password);

  @override
  Future<Result<User>> signInAnonymously() => _datasource.signInAnonymously();
}
