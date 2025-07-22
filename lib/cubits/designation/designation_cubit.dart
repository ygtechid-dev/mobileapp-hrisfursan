import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/models.dart';
import '../../services/services.dart';

part 'designation_state.dart';

class DesignationCubit extends Cubit<DesignationState> {
  DesignationCubit() : super(DesignationInitial());

  Future<void> getDesignations(String token) async {
    ApiReturnValue<List<Designation>> result = await DesignationServices.getDesignations(token);

    if(result.value != null){
      emit(DesignationLoaded(data: result.value));
    } else {
      emit(DesignationLoadingFailed(result.message));
    }
  }

}