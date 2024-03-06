part of 'explore_home_bloc.dart';

abstract class ExploreHomeState extends Equatable {
  const ExploreHomeState();

  @override
  List<Object> get props => [];
}

class ExploreHomeInitial extends ExploreHomeState {
  const ExploreHomeInitial();

  @override
  List<Object> get props => [];
}

class ExploreHomeTimedOutState extends ExploreHomeState {}
