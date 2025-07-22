part of 'events_cubit.dart';

abstract class EventsState extends Equatable {
  const EventsState();

  @override
  List<Object?> get props => [];
}

class EventsInitial extends EventsState {}

class EventsLoaded extends EventsState {
  final List<EventData>? data;


  EventsLoaded({this.data});

  @override
  List<Object?> get props => [data];
}

class EventsLoadingFailed extends EventsState {
  final String? message;

  EventsLoadingFailed(this.message);

  @override
  List<Object?> get props => [message];
}