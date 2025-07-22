part of 'reimbursement_category_cubit.dart';

abstract class ReimbursementCategoryState extends Equatable {
  const ReimbursementCategoryState();

  @override
  List<Object?> get props => [];
}

class ReimbursementCategoryInitial extends ReimbursementCategoryState {}

class ReimbursementCategoryLoaded extends ReimbursementCategoryState {
  final List<ReimbursementCategory>? data;


  ReimbursementCategoryLoaded({this.data});

  @override
  List<Object?> get props => [data];
}

class ReimbursementCategoryLoadingFailed extends ReimbursementCategoryState {
  final String? message;

  ReimbursementCategoryLoadingFailed(this.message);

  @override
  List<Object?> get props => [message];
}