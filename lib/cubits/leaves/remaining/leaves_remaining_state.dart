part of 'leaves_remaining_cubit.dart';

abstract class LeavesRemainingState extends Equatable {
  const LeavesRemainingState();

  @override
  List<Object?> get props => [];
}

class LeavesRemainingInitial extends LeavesRemainingState {}

class LeavesRemainingLoaded extends LeavesRemainingState {
  final List<LeavesRemaining>? data;


  LeavesRemainingLoaded({this.data});

  @override
  List<Object?> get props => [data];
}

class LeavesRemainingLoadingFailed extends LeavesRemainingState {
  final String? message;

  LeavesRemainingLoadingFailed(this.message);

  @override
  List<Object?> get props => [message];
}