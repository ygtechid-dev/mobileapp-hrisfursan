part of 'task_detail_cubit.dart';

abstract class TaskDetailState extends Equatable {
  const TaskDetailState();

  @override
  List<Object?> get props => [];
}

class TaskDetailInitial extends TaskDetailState {}

class TaskDetailLoaded extends TaskDetailState {
  final Tasks? data;


  TaskDetailLoaded({this.data});

  @override
  List<Object?> get props => [data];
}

class TaskDetailLoadingFailed extends TaskDetailState {
  final String? message;

  TaskDetailLoadingFailed(this.message);

  @override
  List<Object?> get props => [message];
}