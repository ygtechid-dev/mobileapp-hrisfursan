import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/models.dart';
import '../../services/services.dart';

part 'leaves_state.dart';

class LeavesCubit extends Cubit<LeavesState> {
  LeavesCubit() : super(LeavesInitial());

  Future<void> getLeaves(String token) async {
    ApiReturnValue<List<Leaves>> result = await LeaveServices.getLeaves(token);

    if(result.value != null){
      emit(LeavesLoaded(data: result.value));
    } else {
      emit(LeavesLoadingFailed(result.message));
    }
  }

}