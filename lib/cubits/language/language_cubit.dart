import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:workwise/cubits/language/language_state.dart';

import '../../utils/cache_helper.dart';

class LocalCubit extends Cubit<LocalState> {
  LocalCubit() : super(LocalInitState());
  String currentLanguage = "";

  void getSavedLanguage() {
    final cachedLanguageCode = CacheHelper.getCachedLanguage();
    currentLanguage = cachedLanguageCode;
    emit(ChangeLocalState(locale: Locale(cachedLanguageCode)));
  }

  Future<void> changeLanguage(String languageCode) async {
    await CacheHelper.cacheLanguage(languageCode);
    currentLanguage = languageCode;

    Get.updateLocale(Locale(languageCode));
    emit(ChangeLocalState(locale: Locale(languageCode)));
  }
}
