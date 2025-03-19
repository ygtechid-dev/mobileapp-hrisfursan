import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/models.dart';
import '../../services/services.dart';

part 'payslip_state.dart';

class PayslipCubit extends Cubit<PayslipState> {
  PayslipCubit() : super(PayslipInitial());

  Future<void> getPayslip(String token) async {
    ApiReturnValue<List<Payslip>> result = await PayslipServices.getListPayslip(token);

    if(result.value != null){
      emit(PayslipLoaded(data: result.value));
    } else {
      emit(PayslipLoadingFailed(result.message));
    }
  }

}