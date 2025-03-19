import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/models.dart';
import '../../../services/services.dart';

part 'payslip_detail_state.dart';

class PayslipDetailCubit extends Cubit<PayslipDetailState> {
  PayslipDetailCubit() : super(PayslipDetailInitial());

  Future<void> getPayslipDetail(String token, String task_id,) async {
    ApiReturnValue<Payslip> result = await PayslipServices.getPayslipDetail(token, task_id);

    if(result.value != null){
      emit(PayslipDetailLoaded(data: result.value));
    } else {
      emit(PayslipDetailLoadingFailed(result.message));
    }
  }

}