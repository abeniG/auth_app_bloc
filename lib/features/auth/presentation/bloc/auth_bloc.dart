import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_firebase_auth/features/auth/domain/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;
  AuthBloc(this.repository) : super(AuthInitial()) {
    on<LoginEvent>(loginEvent);
    on<LogoutEvent>(logoutEvent);
    on<RegisterEvent>(registerEvent);
  }

  FutureOr<void> loginEvent(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      await repository.login(event.email, event.password);
      emit(Authauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  FutureOr<void> logoutEvent(LogoutEvent event, Emitter<AuthState> emit) async {
    await repository.logout();
    emit(AuthUnauthenticated());
  }

  FutureOr<void> registerEvent(
      RegisterEvent event, Emitter<AuthState> emit) async {
    try {
      await repository.register(event.email, event.password);
      emit(Authauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
