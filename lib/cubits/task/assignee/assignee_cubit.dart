import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/models.dart';
import '../../../services/services.dart';

part 'assignee_state.dart';

class AssigneeCubit extends Cubit<AssigneeState> {
  AssigneeCubit() : super(AssigneeInitial());

  Future<void> getAssignee(String token) async {
    ApiReturnValue<List<Employee>> result = await TaskServices.getAssignee(token);

    if(result.value != null){
      emit(AssigneeLoaded(data: result.value));
    } else {
      emit(AssigneeLoadingFailed(result.message));
    }
  }

}