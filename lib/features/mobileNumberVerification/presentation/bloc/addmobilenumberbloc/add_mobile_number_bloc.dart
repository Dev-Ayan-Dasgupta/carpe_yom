import 'dart:async';
import 'package:carpeyom/features/mobileNumberVerification/presentation/bloc/addmobilenumberbloc/add_mobile_number_event.dart';
import 'package:carpeyom/features/mobileNumberVerification/presentation/bloc/addmobilenumberbloc/add_mobile_number_state.dart';
import 'package:carpeyom/utils/helpers/input_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddMobileNumberBloc
    extends Bloc<AddMobileNumberEvent, AddMobileNumberState> {
  AddMobileNumberBloc() : super(AddMobileNumberIncompleteState()) {
    on<EnterMobileEvent>(mapEnterMobileEventToState);
  }

  static bool isIncomplete = true;
  static bool isError = false;
  static bool isSuccess = false;

  FutureOr<void> mapEnterMobileEventToState(
      EnterMobileEvent event, Emitter<AddMobileNumberState> emit) {
    onChanged(event.mobile);
    if (isIncomplete) {
      emit(AddMobileNumberIncompleteState());
    } else if (isError) {
      emit(AddMobileNumberErrorState());
    } else if (isSuccess) {
      emit(AddMobileNumberSuccessState());
    }
  }

  // validation for Mobile Number
  static void onChanged(String mobile) {
    if (mobile.isEmpty) {
      isSuccess = false;
      isError = false;
      isIncomplete = true;
    } else if (InputValidator.isPhoneValid("+971$mobile")) {
      isSuccess = true;
      isError = false;
      isIncomplete = false;
    } else {
      isSuccess = false;
      isError = true;
      isIncomplete = false;
    }
  }
}
