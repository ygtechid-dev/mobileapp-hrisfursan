import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/models.dart';
import '../../services/services.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit() : super(NotificationsInitial());

  Future<void> getNotifications(String token) async {
    ApiReturnValue<List<Notifications>> result = await NotificationServices.getListNotifications(token);

    if(result.value != null){
      emit(NotificationsLoaded(data: result.value));
    } else {
      emit(NotificationsLoadingFailed(result.message));
    }
  }

}