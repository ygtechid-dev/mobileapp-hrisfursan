import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/models.dart';
import '../../services/services.dart';

part 'events_state.dart';

class EventsCubit extends Cubit<EventsState> {
  EventsCubit() : super(EventsInitial());

  Future<void> getEvents(String token) async {
    ApiReturnValue<List<EventData>> result = await EventsServices.getListEvents(token);

    if(result.value != null){
      emit(EventsLoaded(data: result.value));
    } else {
      emit(EventsLoadingFailed(result.message));
    }
  }

}