part of 'task_cubit.dart';

abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object?> get props => [];
}

class TaskInitial extends TaskState {}

class TaskLoaded extends TaskState {
  final ProjectsSummary? data;


  TaskLoaded({this.data});

  @override
  List<Object?> get props => [data];
}

class TaskLoadingFailed extends TaskState {
  final String? message;

  TaskLoadingFailed(this.message);

  @override
  List<Object?> get props => [message];
}