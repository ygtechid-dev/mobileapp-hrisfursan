import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/models.dart';
import '../../../services/services.dart';

part 'reimbursement_category_state.dart';

class ReimbursementCategoryCubit extends Cubit<ReimbursementCategoryState> {
  ReimbursementCategoryCubit() : super(ReimbursementCategoryInitial());

  Future<void> getReimbursementCategory(String token) async {
    ApiReturnValue<List<ReimbursementCategory>> result = await ReimbursementServices.getListCategory(token);

    if(result.value != null){
      emit(ReimbursementCategoryLoaded(data: result.value));
    } else {
      emit(ReimbursementCategoryLoadingFailed(result.message));
    }
  }

}