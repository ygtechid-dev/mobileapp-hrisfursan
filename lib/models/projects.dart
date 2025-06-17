part of "models.dart";

class ProjectsSummary extends Equatable {
  final List<Projects>? projects;
  final ProjectsCounts? project_counts;

  ProjectsSummary({this.projects, this.project_counts});


  factory ProjectsSummary.fromJson(Map<String, dynamic> data) =>
      ProjectsSummary(
        projects: (data['projects'] != null) ? (data['projects'] as Iterable)
          .map((e) => Projects.fromJson(e))
          .toList() : [],
        project_counts: (data['project_counts'] != null) ? ProjectsCounts.fromJson(data['project_counts']) : null,
      );

  @override
  List<Object?> get props => [projects, project_counts,];
}

class ProjectsCounts extends Equatable {
  final int? todo;
  final int? in_progress;
  final int? done;

  ProjectsCounts({this.todo, this.in_progress, this.done});

  factory ProjectsCounts.fromJson(Map<String, dynamic> data) =>
      ProjectsCounts(
        todo: data['todo'] ?? 0,
        in_progress: data['in_progress'] ?? 0,
        done: data['done'] ?? 0,
      );

  @override
  List<Object?> get props =>
      [
        todo,
        in_progress,
        done,
      ];
}

class Projects extends Equatable {
  final int? id;
  final String? name;
  final String? description;
  final String? start_date;
  final String? end_date;
  final String? status;
  final int? progress;
  final int? members_count;
  final int? tasks_count;
  final int? completed_tasks;
  final List<Tasks>? tasks;
  final String? created_at;
  final String? updated_at;

  Projects(
      {this.id,
      this.name,
      this.description,
      this.start_date,
      this.end_date,
      this.status,
      this.progress,
      this.members_count,
      this.tasks_count,
      this.completed_tasks,
      this.tasks,
        this.created_at,
      this.updated_at});

  factory Projects.fromJson(Map<String, dynamic> data) =>
      Projects(
        id: data['id'] ?? null,
        name: data['name'],
        description: data['description'],
        start_date: data['start_date'],
        end_date: data['end_date'],
        progress: data['progress'],
        status: data['status'],
        members_count: data['members_count'],
        tasks_count: data['tasks_count'],
        completed_tasks: data['completed_tasks'],
        created_at: data['created_at'],
        updated_at: data['updated_at'],
      );

  Projects copyWith({
    int? id,
    String? name,
    String? description,
    String? start_date,
    String? end_date,
    String? status,
    int? progress,
    int? members_count,
    int? tasks_count,
    int? completed_tasks,
    String? created_at,
    String? updated_at,
    List<Tasks>? tasks,
  }) =>
      Projects(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        start_date: start_date ?? this.start_date,
        end_date: end_date ?? this.end_date,
        status: status ?? this.status,
        progress: progress ?? this.progress,
        members_count: members_count ?? this.members_count,
        tasks_count: tasks_count ?? this.tasks_count,
        completed_tasks: completed_tasks ?? this.completed_tasks,
        created_at: created_at ?? this.created_at,
        updated_at: updated_at ?? this.updated_at,
        tasks: tasks ?? this.tasks,
      );

  @override
  List<Object?> get props =>
      [ id,
        name,
        description,
        start_date,
        end_date,
        progress,
        status,
        members_count,
        tasks_count,
        completed_tasks,
        created_at,
        updated_at,
        tasks
      ];
}

class Tasks extends Equatable {
  final int? id;
  final int? project_id;
  final String? project_name;
  final String? title;
  final String? end_date;
  final String? description;
  final String? status;
  final String? priority;
  final String? due_date;
  final int? attachments_count;
  final int? created_by;
  final int? comments_count;
  final String? created_at;
  final String? updated_at;
  final List<TaskAssignees>? assignees;
  final List<TaskAttachment>? attachments;
  final List<TaskComment>? comments;

  Tasks(
      {this.id,
      this.project_id,
      this.project_name,
      this.title,
      this.end_date,
      this.description,
      this.status,
      this.priority,
      this.due_date,
      this.attachments_count,
      this.created_by,
      this.comments_count,
      this.created_at,
      this.updated_at,
        this.attachments,
        this.comments,
      this.assignees});

  factory Tasks.fromJson(Map<String, dynamic> data) =>
      Tasks(
        id: data['id'] ?? null,
        project_id: data['project_id'],
        description: data['description'],
        project_name: data['project_name'],
        end_date: data['end_date'],
        title: data['title'],
        status: data['status'],
        priority: data['priority'],
        due_date: data['due_date'],
        attachments_count: data['attachments_count'],
        created_by: data['created_by'],
        comments_count: data['comments_count'],
        created_at: data['created_at'],
        updated_at: data['updated_at'],
          assignees: (data['assignees'] != null) ? (data['assignees'] as Iterable)
              .map((e) => TaskAssignees.fromJson(e))
              .toList() : [],
        attachments: (data['attachments'] != null) ? (data['attachments'] as Iterable)
            .map((e) => TaskAttachment.fromJson(e))
            .toList() : [],
        comments: (data['comments'] != null) ? (data['comments'] as Iterable)
            .map((e) => TaskComment.fromJson(e))
            .toList() : [],
      );

  @override
  List<Object?> get props =>
      [ id,
        project_id,
        description,
        project_name,
        end_date,
        title,
        status,
        priority,
        due_date,
        attachments_count,
        comments_count,
        created_by,
        created_at,
        updated_at,
      ];
}

class TaskAssignees extends Equatable {
  final int? id;
  final String? name;
  final String? avatar;
  final String? designation;


  TaskAssignees({this.id, this.name, this.avatar, this.designation});


  factory TaskAssignees.fromJson(Map<String, dynamic> data) =>
      TaskAssignees(
        id: data['id'] ?? null,
        name: data['name'],
        designation: data['designation'],
        avatar: data['avatar'],
      );

  @override
  List<Object?> get props =>
      [
        id,
        name,
        avatar,
        designation
      ];
}

class TaskAttachment extends Equatable {
  final int? id;
  final String? file_name;
  final String? file_path;
  final String? file_size;
  final String? file_type;

  TaskAttachment(
      {this.id,
      this.file_name,
      this.file_path,
      this.file_size,
      this.file_type});

  factory TaskAttachment.fromJson(Map<String, dynamic> data) =>
      TaskAttachment(
        id: data['id'] ?? null,
        file_name: data['file_name'],
        file_path: data['file_path'],
        file_size: data['file_size'],
        file_type: data['file_type'],
      );

  @override
  List<Object?> get props =>
      [
        id,
        file_name,
        file_path,
        file_type,
        file_size,
      ];
}

class TaskComment extends Equatable {
  final int? id;
  final String? comment;
  final TaskAssignees? commented_by;

  TaskComment({this.id, this.comment, this.commented_by});

  factory TaskComment.fromJson(Map<String, dynamic> data) =>
      TaskComment(
        id: data['id'] ?? null,
        comment: data['comment'],
        commented_by: (data['commented_by'] != null) ? TaskAssignees.fromJson(data['commented_by']) : null,
      );

  @override
  List<Object?> get props =>
      [
        id,
        comment,
        commented_by,
      ];
}