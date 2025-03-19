import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/models.dart';
import '../../../services/services.dart';

part 'task_detail_state.dart';

class TaskDetailCubit extends Cubit<TaskDetailState> {
  TaskDetailCubit() : super(TaskDetailInitial());

  Future<void> getTaskDetail(String token, String task_id,) async {
    ApiReturnValue<Tasks> result = await TaskServices.getTaskDetail(token, task_id);

    if(result.value != null){
      emit(TaskDetailLoaded(data: result.value));
    } else {
      emit(TaskDetailLoadingFailed(result.message));
    }
  }

}