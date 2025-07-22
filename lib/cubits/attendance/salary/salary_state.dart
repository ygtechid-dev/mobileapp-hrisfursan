part of 'salary_cubit.dart';

abstract class SalaryState extends Equatable {
  const SalaryState();

  @override
  List<Object?> get props => [];
}

class SalaryInitial extends SalaryState {}

class SalaryLoaded extends SalaryState {
  final Salary? data;

  SalaryLoaded({this.data});

  @override
  List<Object?> get props => [data];
}

class SalaryLoadingFailed extends SalaryState {
  final String? message;

  SalaryLoadingFailed(this.message);

  @override
  List<Object?> get props => [message];
}