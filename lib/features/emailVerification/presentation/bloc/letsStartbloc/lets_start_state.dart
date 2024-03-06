part of 'lets_start_bloc.dart';

abstract class LetsStartState extends Equatable {
  const LetsStartState();
  @override
  List<Object> get props => [];
}

class LetsStartInitial extends LetsStartState {
  const LetsStartInitial();

  @override
  List<Object> get props => [];
}

class LetsStartEmailState extends LetsStartState {
  final bool isValid;
  final bool isInit;

  const LetsStartEmailState({required this.isValid, required this.isInit});

  @override
  List<Object> get props => [Random().nextDouble(), isValid, isInit];
}
