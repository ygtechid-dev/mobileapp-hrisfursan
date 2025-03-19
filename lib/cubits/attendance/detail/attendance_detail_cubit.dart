import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/models.dart';
import '../../../services/services.dart';

part 'attendance_detail_state.dart';

class AttendanceDetailCubit extends Cubit<AttendanceDetailState> {
  AttendanceDetailCubit() : super(AttendanceDetailInitial());

  Future<void> getAttendanceDetail(String token, String employee_id,) async {
    ApiReturnValue<AttendantDetail> result = await AttendanceServices.getEmployeeHistoryDetail(token, employee_id);

    if(result.value != null){
      emit(AttendanceDetailLoaded(data: result.value));
    } else {
      emit(AttendanceDetailLoadingFailed(result.message));
    }
  }

}