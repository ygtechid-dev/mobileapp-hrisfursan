part of 'notifications_cubit.dart';

abstract class NotificationsState extends Equatable {
  const NotificationsState();

  @override
  List<Object?> get props => [];
}

class NotificationsInitial extends NotificationsState {}

class NotificationsLoaded extends NotificationsState {
  final List<Notifications>? data;


  NotificationsLoaded({this.data});

  @override
  List<Object?> get props => [data];
}

class NotificationsLoadingFailed extends NotificationsState {
  final String? message;

  NotificationsLoadingFailed(this.message);

  @override
  List<Object?> get props => [message];
}