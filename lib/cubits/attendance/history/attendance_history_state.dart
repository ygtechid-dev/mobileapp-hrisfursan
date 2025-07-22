part of 'attendance_history_cubit.dart';

abstract class AttendanceHistoryState extends Equatable {
  const AttendanceHistoryState();

  @override
  List<Object?> get props => [];
}

class AttendanceHistoryInitial extends AttendanceHistoryState {}

class AttendanceHistoryLoaded extends AttendanceHistoryState {
  final Attendant? data;


  AttendanceHistoryLoaded({this.data});

  @override
  List<Object?> get props => [data];
}

class AttendanceHistoryLoadingFailed extends AttendanceHistoryState {
  final String? message;

  AttendanceHistoryLoadingFailed(this.message);

  @override
  List<Object?> get props => [message];
}