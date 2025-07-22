part of 'reimbursement_cubit.dart';

abstract class ReimbursementState extends Equatable {
  const ReimbursementState();

  @override
  List<Object?> get props => [];
}

class ReimbursementInitial extends ReimbursementState {}

class ReimbursementLoaded extends ReimbursementState {
  final ReimbursementSummary? data;


  ReimbursementLoaded({this.data});

  @override
  List<Object?> get props => [data];
}

class ReimbursementLoadingFailed extends ReimbursementState {
  final String? message;

  ReimbursementLoadingFailed(this.message);

  @override
  List<Object?> get props => [message];
}