part of 'models.dart';

class EventData extends Equatable {
  final int? id;
  final String? status;
  final String? title;
  final String? description;
  final String? start;
  final String? color;
  final String? end;
  final String? type;
  final String? priority;
  final int? project_id;
  final int? created_by;

  EventData(
      {this.id,
      this.status,
      this.title,
      this.description,
      this.start,
      this.color,
      this.end,
      this.type,
      this.priority,
      this.project_id,
      this.created_by});

  factory EventData.fromJson(Map<String, dynamic> data) =>
      EventData(
        id: data['id'] ?? null,
        status: data['status'] ?? "",
        title: data['title'] ?? "",
        description: data['description'] ?? "",
        start: data['start'] ?? "",
        end: data['end'] ?? "",
        color: data['color'] ?? "",
        type: data['type'] ?? "",
        priority: data['priority'] ?? "",
        project_id: data['project_id'] ?? null,
        created_by: data['created_by'] ?? null,

      );

  @override
  // TODO: implement props
  List<Object?> get props => [id, status, title, description, start, end, color, type, priority, project_id];
}