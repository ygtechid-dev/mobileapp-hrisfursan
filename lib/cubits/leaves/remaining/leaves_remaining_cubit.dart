import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/models.dart';
import '../../../services/services.dart';

part 'leaves_remaining_state.dart';

class LeavesRemainingCubit extends Cubit<LeavesRemainingState> {
  LeavesRemainingCubit() : super(LeavesRemainingInitial());

  Future<void> getLeavesRemaining(String token) async {
    ApiReturnValue<List<LeavesRemaining>> result = await LeaveServices.getLeavesRemaining(token);

    if(result.value != null){
      emit(LeavesRemainingLoaded(data: result.value));
    } else {
      emit(LeavesRemainingLoadingFailed(result.message));
    }
  }

}