import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/models.dart';
import '../../services/services.dart';

part 'reimbursement_state.dart';

class ReimbursementCubit extends Cubit<ReimbursementState> {
  ReimbursementCubit() : super(ReimbursementInitial());

  Future<void> getReimbursement(String token) async {
    ApiReturnValue<ReimbursementSummary> result = await ReimbursementServices.getReimbursementSummary(token);

    if(result.value != null){
      emit(ReimbursementLoaded(data: result.value));
    } else {
      emit(ReimbursementLoadingFailed(result.message));
    }
  }

}