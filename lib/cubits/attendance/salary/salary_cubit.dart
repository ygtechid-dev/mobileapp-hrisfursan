import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/models.dart';
import '../../../services/services.dart';

part 'salary_state.dart';

class SalaryCubit extends Cubit<SalaryState> {
  SalaryCubit() : super(SalaryInitial());

  Future<void> getSalary(String token) async {
    ApiReturnValue<Salary> result = await AttendanceServices.getSalary(token);

    if(result.value != null){
      emit(SalaryLoaded(data: result.value));
    } else {
      emit(SalaryLoadingFailed(result.message));
    }
  }

}