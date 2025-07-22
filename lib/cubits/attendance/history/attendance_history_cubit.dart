import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/models.dart';
import '../../../services/services.dart';

part 'attendance_history_state.dart';

class AttendanceHistoryCubit extends Cubit<AttendanceHistoryState> {
  AttendanceHistoryCubit() : super(AttendanceHistoryInitial());

  Future<void> getAttendanceHistory(String token, String employee_id, String start_date, String end_date, ) async {
    ApiReturnValue<Attendant> result = await AttendanceServices.getEmployeeHistory(token, employee_id, start_date, end_date);

    if(result.value != null){
      emit(AttendanceHistoryLoaded(data: result.value));
    } else {
      emit(AttendanceHistoryLoadingFailed(result.message));
    }
  }

}