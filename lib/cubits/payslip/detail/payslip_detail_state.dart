part of 'payslip_detail_cubit.dart';

abstract class PayslipDetailState extends Equatable {
  const PayslipDetailState();

  @override
  List<Object?> get props => [];
}

class PayslipDetailInitial extends PayslipDetailState {}

class PayslipDetailLoaded extends PayslipDetailState {
  final Payslip? data;


  PayslipDetailLoaded({this.data});

  @override
  List<Object?> get props => [data];
}

class PayslipDetailLoadingFailed extends PayslipDetailState {
  final String? message;

  PayslipDetailLoadingFailed(this.message);

  @override
  List<Object?> get props => [message];
}