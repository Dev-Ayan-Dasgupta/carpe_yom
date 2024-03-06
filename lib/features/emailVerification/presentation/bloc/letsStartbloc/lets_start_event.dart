part of 'lets_start_bloc.dart';

abstract class LetsStartEvent extends Equatable {
  const LetsStartEvent();

  @override
  List<Object> get props => [];
}

class EnterEmailEvent extends LetsStartEvent {
  final String email;

  const EnterEmailEvent({required this.email});

  @override
  List<Object> get props => [email];
}
