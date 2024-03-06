import 'dart:async';
import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'create_password_event.dart';

part 'create_password_state.dart';

class CreatePasswordBloc
    extends Bloc<CreatePasswordEvent, CreatePasswordState> {

  CreatePasswordBloc() : super(const CreatePasswordInitial()) {
    on<CreatePasswordEvent>((event, emit) {
      if (event is ShowHidePasswordEvent) {
        event.showPassword ?
        emit(const ShowHidePasswordState(isShown: false)) :
        emit(const ShowHidePasswordState(isShown: true));
      } else if (event is ShowHideConfirmedPasswordEvent) {
        event.showConfirmedPassword ?
        emit(const ShowHideConfirmedPasswordState(isShown: false)) :
        emit(const ShowHideConfirmedPasswordState(isShown: true));
      } else if (event is CheckPasswordCriteriaEvent) {
        _mapCheckPasswordCriteriaEventToState(event, emit);
      } else if (event is PasswordMatchEvent) {
        emit(PasswordMatchState());
      }
    });
  }

  void _mapCheckPasswordCriteriaEventToState(CheckPasswordCriteriaEvent event,
      Emitter<CreatePasswordState> emit) {
    if (event.password.length >= 8) {
      emit(const HasMin8State(hasMin8: true));
    } else {
      emit(const HasMin8State(hasMin8: false));
    }

    if (event.password.contains(RegExp(r'[0-9]'))) {
      emit(const HasNumericState(hasNumeric: true));
    } else {
      emit(const HasNumericState(hasNumeric: false));
    }

    if (event.password.contains(RegExp(r'[A-Z]')) &&
        event.password.contains(RegExp(r'[a-z]'))) {
      emit(const HasUpperLowerState(hasUpperLower: true));
    } else {
      emit(const HasUpperLowerState(hasUpperLower: false));
    }

    if (event.password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      emit(const HasSpecialState(hasSpecial: true));
    } else {
      emit(const HasSpecialState(hasSpecial: false));
    }
  }
}
