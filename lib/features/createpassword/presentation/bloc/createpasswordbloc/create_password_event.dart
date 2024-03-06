part of 'create_password_bloc.dart';

abstract class CreatePasswordEvent extends Equatable {
  const CreatePasswordEvent();

  @override
  List<Object> get props => [];
}

class CheckPasswordCriteriaEvent extends CreatePasswordEvent {
  final String password;

  const CheckPasswordCriteriaEvent({required this.password});

  @override
  List<Object> get props => [password];
}

class ShowHidePasswordEvent extends CreatePasswordEvent {
  final bool showPassword;

  const ShowHidePasswordEvent({required this.showPassword});

  @override
  List<Object> get props => [showPassword];
}

class ShowHideConfirmedPasswordEvent extends CreatePasswordEvent {
  final bool showConfirmedPassword;

  const ShowHideConfirmedPasswordEvent({required this.showConfirmedPassword});

  @override
  List<Object> get props => [showConfirmedPassword];
}

class PasswordMatchEvent extends CreatePasswordEvent {

}
