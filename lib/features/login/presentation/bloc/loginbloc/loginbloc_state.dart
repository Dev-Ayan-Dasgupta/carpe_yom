part of 'loginbloc_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {
  const LoginInitial();

  @override
  List<Object> get props => [];
}

class LoginEmailState extends LoginState {
  final bool isValid;
  final bool isInit;

  const LoginEmailState({required this.isValid, required this.isInit});

  @override
  List<Object> get props => [Random().nextDouble(), isValid, isInit];
}

class LoginPasswordState extends LoginState {
  final bool isPasswordValid;
  //final bool isInit;

  const LoginPasswordState({required this.isPasswordValid});

  @override
  List<Object> get props => [Random().nextDouble(), isPasswordValid];
}

class ShowHidePasswordState extends LoginState {
  final bool isShown;

  const ShowHidePasswordState({required this.isShown});

  @override
  List<Object> get props => [Random().nextDouble(), isShown];
}
