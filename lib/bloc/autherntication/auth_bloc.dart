import 'package:apple_shop_flutter/bloc/autherntication/auth_event.dart';
import 'package:apple_shop_flutter/bloc/autherntication/auth_state.dart';
import 'package:apple_shop_flutter/data/repository/authentication_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthenticationRepository _repository;
  AuthBloc(this._repository) : super(AuthInitState()) {
    on<LoginRequestEvent>(
      (event, emit) async {
        emit(AuthLoadingState());
        var response =
            await _repository.loginRepository(event.username, event.password);
        emit(AuthResponseState(response));
      },
    );

    on<RegisterRequestEvent>(
      (event, emit) async {
        emit(AuthLoadingState());
        var response = await _repository.registerRepository(
          event.username,
          event.password,
          event.passwordConfirm,
        );

        emit(AuthResponseState(response));
      },
    );
  }
}
