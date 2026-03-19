import 'package:bloc_firebase_auth/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:bloc_firebase_auth/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> login(String email, String password) {
    return remoteDataSource.login(
      email,
      password,
    );
  }

  @override
  Future<void> logout() {
    return remoteDataSource.logout();
  }

  @override
  Future<void> register(String email, String password) {
    return remoteDataSource.register(
      email,
      password,
    );
  }
}
