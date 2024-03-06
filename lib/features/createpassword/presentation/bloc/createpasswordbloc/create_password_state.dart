part of 'create_password_bloc.dart';

abstract class CreatePasswordState extends Equatable {
  const CreatePasswordState();

  @override
  List<Object> get props => [];
}

class CreatePasswordInitial extends CreatePasswordState {
  const CreatePasswordInitial();

  @override
  List<Object> get props => [];
}

class ShowHidePasswordState extends CreatePasswordState {
  final bool isShown;

  const ShowHidePasswordState({required this.isShown});

  @override
  List<Object> get props => [Random().nextDouble(), isShown];
}

class ShowHideConfirmedPasswordState extends CreatePasswordState {
  final bool isShown;

  const ShowHideConfirmedPasswordState({required this.isShown});

  @override
  List<Object> get props => [Random().nextDouble(), isShown];
}

class HasMin8State extends CreatePasswordState {
  final bool hasMin8;

  const HasMin8State({required this.hasMin8});

  @override
  List<Object> get props => [Random().nextDouble(), hasMin8];
}

class HasNumericState extends CreatePasswordState {
  final bool hasNumeric;

  const HasNumericState({required this.hasNumeric});

  @override
  List<Object> get props => [Random().nextDouble(), hasNumeric];
}

class HasUpperLowerState extends CreatePasswordState {
  final bool hasUpperLower;

  const HasUpperLowerState({required this.hasUpperLower});

  @override
  List<Object> get props => [Random().nextDouble(), hasUpperLower];
}

class HasSpecialState extends CreatePasswordState {
  final bool hasSpecial;

  const HasSpecialState({required this.hasSpecial});

  @override
  List<Object> get props => [Random().nextDouble(), hasSpecial];
}

class PasswordMatchState extends CreatePasswordState {
  @override
  List<Object> get props => [Random().nextDouble()];
}
