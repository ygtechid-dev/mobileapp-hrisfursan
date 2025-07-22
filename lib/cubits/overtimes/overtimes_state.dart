part of 'overtimes_cubit.dart';

abstract class OvertimesState extends Equatable {
  const OvertimesState();

  @override
  List<Object?> get props => [];
}

class OvertimesInitial extends OvertimesState {}

class OvertimesLoaded extends OvertimesState {
  final List<Overtimes>? data;


  OvertimesLoaded({this.data});

  @override
  List<Object?> get props => [data];
}

class OvertimesLoadingFailed extends OvertimesState {
  final String? message;

  OvertimesLoadingFailed(this.message);

  @override
  List<Object?> get props => [message];
}