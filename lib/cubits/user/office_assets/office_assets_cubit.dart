import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/models.dart';
import '../../../services/services.dart';

part 'office_assets_state.dart';

class OfficeAssetsCubit extends Cubit<OfficeAssetsState> {
  OfficeAssetsCubit() : super(OfficeAssetsInitial());

  Future<void> getOfficeAssets(String token,) async {
    ApiReturnValue<OfficeAssets> result = await UserServices.getOfficeAssets(token,);

    if(result.value != null){
      emit(OfficeAssetsLoaded(data: result.value));
    } else {
      emit(OfficeAssetsLoadingFailed(result.message));
    }
  }

}