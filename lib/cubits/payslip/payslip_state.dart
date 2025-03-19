part of 'payslip_cubit.dart';

abstract class PayslipState extends Equatable {
  const PayslipState();

  @override
  List<Object?> get props => [];
}

class PayslipInitial extends PayslipState {}

class PayslipLoaded extends PayslipState {
  final List<Payslip>? data;


  PayslipLoaded({this.data});

  @override
  List<Object?> get props => [data];
}

class PayslipLoadingFailed extends PayslipState {
  final String? message;

  PayslipLoadingFailed(this.message);

  @override
  List<Object?> get props => [message];
}