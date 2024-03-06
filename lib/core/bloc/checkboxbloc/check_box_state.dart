part of 'check_box_cubit.dart';

@immutable
abstract class CheckBoxState {}

class CheckBoxInitial extends CheckBoxState {}

class CheckedBoxState extends CheckBoxState {}

class UncheckedBoxState extends CheckBoxState {}

