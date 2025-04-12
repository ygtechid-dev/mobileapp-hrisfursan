part of 'working_period_cubit.dart';

abstract class WorkingPeriodState extends Equatable {
  const WorkingPeriodState();

  @override
  List<Object?> get props => [];
}

class WorkingPeriodInitial extends WorkingPeriodState {}

class WorkingPeriodLoaded extends WorkingPeriodState {
  final WorkingPeriodAll? data;


  WorkingPeriodLoaded({this.data});

  @override
  List<Object?> get props => [data];
}

class WorkingPeriodLoadingFailed extends WorkingPeriodState {
  final String? message;

  WorkingPeriodLoadingFailed(this.message);

  @override
  List<Object?> get props => [message];
}