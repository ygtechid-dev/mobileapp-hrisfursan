part of 'models.dart';

class Overtimes extends Equatable {
  final int? id;
  final int? employee_id;
  final String? title;
  final String? number_of_days;
  final String? overtime_date;
  final String? start_time;
  final String? end_time;
  final int? hours;
  final int? rate;
  final String? remark;
  final String? status;
  final String? created_at;
  final int? approved_by;
  final String? approved_at;
  final String? rejection_reason;
  final String? rejected_at;

  Overtimes(
      {this.id,
      this.employee_id,
      this.title,
      this.number_of_days,
      this.overtime_date,
      this.start_time,
      this.end_time,
      this.hours,
      this.rate,
      this.remark,
      this.status,
      this.created_at,
      this.approved_by,
      this.approved_at,
        this.rejected_at,
      this.rejection_reason});

  factory Overtimes.fromJson(Map<String, dynamic> data) =>
      Overtimes(
        employee_id: data['employee_id'] ?? null,
        id: data['id'],
        title: data['title'] ?? null,
        number_of_days: data['number_of_days'] ?? null,
        overtime_date: data['overtime_date'] ?? null,
        start_time: data['start_time'],
        end_time: data['end_time'] ?? null,
        hours: data['hours'] ?? null,
        rate: data['rate'] ?? null,
        remark: data['remark'] ?? null,
        status: data['status'] ?? null,
        approved_by: data['approved_by'] ?? null,
        approved_at: data['approved_at'] ?? null,
        rejected_at: data['rejected_at'] ?? null,
        rejection_reason: data['rejection_reason'] ?? null,
        created_at: data['created_at'] ?? null,
      );

  @override
  List<Object?> get props =>
      [
        id,
        employee_id,
        title,
        number_of_days,
        overtime_date,
        start_time,
        end_time,
        hours,
        rate,
        remark,
        status,
        approved_by,
        approved_at,
        rejected_at,
        rejection_reason,
        created_at,
      ];
}