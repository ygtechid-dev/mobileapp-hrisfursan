part of 'models.dart';

class Payslip extends Equatable {
  final int? id;
  final String? payslip_number;
  final String? month;
  final String? month_name;
  final String? year;
  final String? period;
  final String? salary_type;
  final String? basic_salary;
  final String? total_allowance;
  final String? total_deduction;
  final String? total_overtime;
  final String? net_salary;
  final String? payment_status;
  final String? payment_method;
  final String? payment_date;
  final String? note;
  final String? file_url;
  final String? created_at;
  final int? total_working_hours;
  final int? total_working_minutes;
  final int? total_overtime_hours;
  final int? total_overtime_minutes;

  Payslip(
      {this.id,
      this.payslip_number,
      this.month,
      this.month_name,
      this.year,
      this.period,
      this.salary_type,
      this.basic_salary,
      this.total_allowance,
      this.total_deduction,
      this.total_overtime,
      this.net_salary,
      this.payment_status,
      this.payment_method,
      this.payment_date,
      this.note,
      this.file_url,
      this.created_at,
      this.total_working_hours,
      this.total_working_minutes,
      this.total_overtime_hours,
      this.total_overtime_minutes});

  factory Payslip.fromJson(Map<String, dynamic> data) =>
      Payslip(
        payslip_number: data['payslip_number'] ?? null,
        id: data['id'],
        month: data['month'] ?? null,
        month_name: data['month_name'] ?? null,
        year: data['year'] ?? null,
        period: data['period'],
        salary_type: data['salary_type'] ?? null,
        created_at: data['created_at'] ?? null,
        basic_salary: data['basic_salary'] ?? null,
        total_allowance: data['total_allowance'] ?? null,
        total_working_hours: data['total_working_hours'] ?? null,
        total_working_minutes: data['total_working_minutes'] ?? null,
        total_overtime_hours: data['total_overtime_hours'] ?? null,
        total_overtime_minutes: data['total_overtime_minutes'] ?? null,
        total_deduction: data['total_deduction'] ?? null,
        total_overtime: data['total_overtime'] ?? null,
        net_salary: data['net_salary'] ?? null,
        payment_status: data['payment_status'] ?? null,
        payment_method: data['payment_method'] ?? null,
        payment_date: data['payment_date'] ?? null,
        note: data['note'] ?? null,
        file_url: data['file_url'] ?? null,
      );

  @override
  List<Object?> get props =>
      [
        id,
        payslip_number,
        month,
        created_at,
        total_working_hours,
        total_working_minutes,
        total_overtime_hours,
        total_overtime_minutes,
        month_name,
        year,
        period,
        salary_type,
        basic_salary,
        total_allowance,
        total_deduction,
        total_overtime,
        net_salary,
        payment_status,
        payment_method,
        payment_date,
        note,
        file_url,
      ];
}

class PayslipExport extends Equatable {
  final String? file_name;
  final String? file_url;

  PayslipExport(
      {this.file_url,
        this.file_name
      });

  factory PayslipExport.fromJson(Map<String, dynamic> data) =>
      PayslipExport(
        file_url: data['file_url'] ?? null,
        file_name: data['file_name'],
      );

  @override
  List<Object?> get props =>
      [
        file_url,
        file_name
      ];
}