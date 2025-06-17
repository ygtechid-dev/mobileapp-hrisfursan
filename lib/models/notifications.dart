part of 'models.dart';

class Notifications extends Equatable {
  final String? title;
  final String? description;
  final String? status;
  final String? time;

  Notifications({this.title, this.description, this.status, this.time});

  factory Notifications.fromJson(Map<String, dynamic> data) => Notifications(
    title: data['title'] ?? "",
    description: data['message'] ?? "",
    status: data['status'] ?? "",
    time: data['formatted_date'] ?? "",
  );

  @override
  // TODO: implement props
  List<Object?> get props => [title, description, status, time];
}