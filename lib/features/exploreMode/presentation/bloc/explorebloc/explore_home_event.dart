part of 'explore_home_bloc.dart';

abstract class ExploreHomeEvent extends Equatable {
  const ExploreHomeEvent();

  @override
  List<Object> get props => [];
}

class ExploreHomeConfigurableEvent extends ExploreHomeEvent {
  final bool isTimedOut;

  const ExploreHomeConfigurableEvent({required this.isTimedOut});

  @override
  List<Object> get props => [isTimedOut];
}
