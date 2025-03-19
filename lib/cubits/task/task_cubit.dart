import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/models.dart';
import '../../services/services.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());

  Future<void> getTask(String token) async {
    ApiReturnValue<ProjectsSummary> result = await TaskServices.getProjectSummary(token);

    if(result.value != null){
      emit(TaskLoaded(data: result.value));
    } else {
      emit(TaskLoadingFailed(result.message));
    }
  }

}