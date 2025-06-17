import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/models.dart';
import '../../services/services.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  Future<void> login(String email, String password, {String? login_type}) async {
    ApiReturnValue<User> result = await UserServices.login(email, password, login_type: login_type);

    if(result.value != null){
      emit(UserLoaded(user: result.value));
    } else {
      emit(UserLoadingFailed(result.message));
    }
  }

  Future<void> getProfile(String token) async {
    ApiReturnValue<User> result = await UserServices.getProfile(token);

    if(result.value != null){
      emit(UserLoaded(user: result.value));
    } else {
      emit(UserLoadingFailed(result.message));
    }
  }

}