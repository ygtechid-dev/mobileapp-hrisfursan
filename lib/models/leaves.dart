part of 'models.dart';

class Leaves extends Equatable {
  final int? id;
  final int? employee_id;
  final int? leave_type_id;
  final String? applied_on;
  final String? start_date;
  final String? end_date;
  final String? total_leave_days;
  final String? leave_reason;
  final String? emergency_contact;
  final String? remark;
  final String? status;
  final String? created_by;
  final String? created_at;
  final String? approved_at;
  final String? rejected_at;

  Leaves(
      {this.id,
      this.employee_id,
      this.leave_type_id,
      this.applied_on,
      this.start_date,
      this.end_date,
      this.total_leave_days,
      this.leave_reason,
      this.emergency_contact,
      this.remark,
      this.status,
      this.created_by,
        this.approved_at,
        this.rejected_at,
      this.created_at});

  factory Leaves.fromJson(Map<String, dynamic> data) =>
      Leaves(
        employee_id: data['employee_id'] ?? null,
        id: data['id'],
        leave_type_id: data['leave_type_id'] ?? null,
        applied_on: data['applied_on'] ?? null,
        start_date: data['start_date'] ?? null,
        end_date: data['end_date'],
        total_leave_days: "${data['total_leave_days']}" ?? null,
        leave_reason: data['leave_reason'] ?? null,
        emergency_contact: "${data['emergency_contact']}" ?? null,
        remark: data['remark'] ?? null,
        status: data['status'] ?? null,
        created_by: "${data['created_by']}" ?? null,
        created_at: data['created_at'] ?? null,
        approved_at: data['approved_at'] ?? null,
        rejected_at: data['rejected_at'] ?? null,
      );

  @override
  List<Object?> get props =>
      [
        id,
        employee_id,
        leave_type_id,
        applied_on,
        start_date,
        end_date,
        total_leave_days,
        leave_reason,
        emergency_contact,
        remark,
        status,
        created_by,
        created_at,
        approved_at,
        rejected_at
      ];
}

class LeavesRemaining extends Equatable {
  final int? id;
  final String? leave_type;
  final int? used;
  final int? remaining;

  LeavesRemaining({this.id, this.leave_type, this.used, this.remaining});

  factory LeavesRemaining.fromJson(Map<String, dynamic> data) =>
      LeavesRemaining(
        leave_type: data['leave_type'] ?? null,
        id: data['id'],
        used: data['used'] ?? null,
        remaining: data['remaining'] ?? null,
      );

  @override
  List<Object?> get props =>
      [
        id,
        leave_type,
        used,
        remaining,
      ];
}

class LeavesTypes extends Equatable {
  final int? id;
  final String? title;
  final int? days;

  LeavesTypes({this.id, this.title, this.days});

  factory LeavesTypes.fromJson(Map<String, dynamic> data) =>
      LeavesTypes(
        title: data['title'] ?? null,
        id: data['id'],
        days: data['days'] ?? null,
      );

  @override
  List<Object?> get props =>
      [
        id,
        title,
        days,
      ];
}