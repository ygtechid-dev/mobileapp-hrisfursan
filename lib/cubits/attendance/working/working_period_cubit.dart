import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/models.dart';
import '../../../services/services.dart';

part 'working_period_state.dart';

class WorkingPeriodCubit extends Cubit<WorkingPeriodState> {
  WorkingPeriodCubit() : super(WorkingPeriodInitial());

  Future<void> getWorkingPeriod(String token) async {
    ApiReturnValue<WorkingPeriodAll> result = await AttendanceServices.getWorkingPeriodAll(token);

    if(result.value != null){
      emit(WorkingPeriodLoaded(data: result.value));
    } else {
      emit(WorkingPeriodLoadingFailed(result.message));
    }
  }

}