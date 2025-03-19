import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/models.dart';
import '../../../services/services.dart';

part 'leaves_types_state.dart';

class LeavesTypesCubit extends Cubit<LeavesTypesState> {
  LeavesTypesCubit() : super(LeavesTypesInitial());

  Future<void> getLeavesTypes(String token) async {
    ApiReturnValue<List<LeavesTypes>> result = await LeaveServices.getLeavesTypes(token);

    if(result.value != null){
      emit(LeavesTypesLoaded(data: result.value));
    } else {
      emit(LeavesTypesLoadingFailed(result.message));
    }
  }

}