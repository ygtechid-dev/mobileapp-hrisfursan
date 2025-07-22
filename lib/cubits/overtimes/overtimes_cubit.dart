import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/models.dart';
import '../../services/services.dart';

part 'overtimes_state.dart';

class OvertimesCubit extends Cubit<OvertimesState> {
  OvertimesCubit() : super(OvertimesInitial());

  Future<void> getOvertimes(String token) async {
    ApiReturnValue<List<Overtimes>> result = await OvertimesServices.getOvertimes(token);

    if(result.value != null){
      emit(OvertimesLoaded(data: result.value));
    } else {
      emit(OvertimesLoadingFailed(result.message));
    }
  }

}