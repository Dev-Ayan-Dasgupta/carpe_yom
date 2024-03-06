part of 'loginbloc_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class EnterEmailEvent extends LoginEvent {
  final String email;

  const EnterEmailEvent({required this.email});

  @override
  List<Object> get props => [email];
}

class EnterPasswordEvent extends LoginEvent {
  final String password;

  const EnterPasswordEvent({required this.password});

  @override
  List<Object> get props => [password];
}

class ShowHidePasswordEvent extends LoginEvent {
  final bool showPassword;

  const ShowHidePasswordEvent({required this.showPassword});

  @override
  List<Object> get props => [showPassword];
}
