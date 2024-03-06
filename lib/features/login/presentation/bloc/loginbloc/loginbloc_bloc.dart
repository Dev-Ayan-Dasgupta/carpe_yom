import 'dart:async';
import 'dart:math';
import 'package:email_validator/email_validator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'loginbloc_event.dart';
part 'loginbloc_state.dart';

class LoginblocBloc extends Bloc<LoginEvent, LoginState> {
  LoginblocBloc() : super(const LoginInitial()) {
    on<LoginEvent>(mapEnterEmailEventToState);
  }

  FutureOr<void> mapEnterEmailEventToState(
      LoginEvent event, Emitter<LoginState> emit) {
    if (event is EnterEmailEvent) {
      if (event.email.isEmpty) {
        emit(const LoginEmailState(isValid: false, isInit: true));
      } else if (EmailValidator.validate(event.email)) {
        emit(const LoginEmailState(isValid: true, isInit: false));
      } else {
        emit(const LoginEmailState(isValid: false, isInit: false));
      }
    } else if (event is EnterPasswordEvent) {
      mapEnterPasswordEventToState(event, emit);
    } else if (event is ShowHidePasswordEvent) {
      
    }
  }

  void mapEnterPasswordEventToState(
      EnterPasswordEvent event, Emitter<LoginState> emit) {
    if (event.password.length >= 8) {
      emit(const LoginPasswordState(isPasswordValid: true));
    } else {
      emit(const LoginPasswordState(isPasswordValid: false));
    }
  }
}
