part of 'assignee_cubit.dart';

abstract class AssigneeState extends Equatable {
  const AssigneeState();

  @override
  List<Object?> get props => [];
}

class AssigneeInitial extends AssigneeState {}

class AssigneeLoaded extends AssigneeState {
  final List<Employee>? data;


  AssigneeLoaded({this.data});

  @override
  List<Object?> get props => [data];
}

class AssigneeLoadingFailed extends AssigneeState {
  final String? message;

  AssigneeLoadingFailed(this.message);

  @override
  List<Object?> get props => [message];
}