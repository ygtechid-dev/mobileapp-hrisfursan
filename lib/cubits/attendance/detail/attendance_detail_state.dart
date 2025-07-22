part of 'attendance_detail_cubit.dart';

abstract class AttendanceDetailState extends Equatable {
  const AttendanceDetailState();

  @override
  List<Object?> get props => [];
}

class AttendanceDetailInitial extends AttendanceDetailState {}

class AttendanceDetailLoaded extends AttendanceDetailState {
  final AttendantDetail? data;


  AttendanceDetailLoaded({this.data});

  @override
  List<Object?> get props => [data];
}

class AttendanceDetailLoadingFailed extends AttendanceDetailState {
  final String? message;

  AttendanceDetailLoadingFailed(this.message);

  @override
  List<Object?> get props => [message];
}