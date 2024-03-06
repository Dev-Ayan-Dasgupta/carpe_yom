import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'check_box_state.dart';

class CheckBoxCubit extends Cubit<CheckBoxState> {
  CheckBoxCubit() : super(CheckBoxInitial());

  void checkBox() => emit(CheckedBoxState());

  void unchecked() => emit(UncheckedBoxState());
}
