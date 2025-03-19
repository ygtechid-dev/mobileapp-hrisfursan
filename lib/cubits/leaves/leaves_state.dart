part of 'leaves_cubit.dart';

abstract class LeavesState extends Equatable {
  const LeavesState();

  @override
  List<Object?> get props => [];
}

class LeavesInitial extends LeavesState {}

class LeavesLoaded extends LeavesState {
  final List<Leaves>? data;


  LeavesLoaded({this.data});

  @override
  List<Object?> get props => [data];
}

class LeavesLoadingFailed extends LeavesState {
  final String? message;

  LeavesLoadingFailed(this.message);

  @override
  List<Object?> get props => [message];
}