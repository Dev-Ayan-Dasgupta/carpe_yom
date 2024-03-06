import 'dart:async';
import 'dart:math';
import 'package:email_validator/email_validator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'lets_start_event.dart';
part 'lets_start_state.dart';

class LetsStartBloc extends Bloc<LetsStartEvent, LetsStartState> {
  LetsStartBloc() : super(const LetsStartInitial()) {
    on<EnterEmailEvent>(mapEnterEmailEventToState);
  }

  FutureOr<void> mapEnterEmailEventToState(
      EnterEmailEvent event, Emitter<LetsStartState> emit) {
    if (event.email.isEmpty) {
      emit(const LetsStartEmailState(isValid: false, isInit: true));
    } else if (EmailValidator.validate(event.email)) {
      emit(const LetsStartEmailState(isValid: true, isInit: false));
    } else {
      emit(const LetsStartEmailState(isValid: false, isInit: false));
    }
  }
}
