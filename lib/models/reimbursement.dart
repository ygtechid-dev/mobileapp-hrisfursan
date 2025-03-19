part of 'models.dart';

class ReimbursementSummary extends Equatable {
  final List<Reimbursement>? reimbursement;
  final ReimbursementPeriod? period;
  final String? total_requested_month;
  final String? total_approved_month;

  ReimbursementSummary(
      {this.reimbursement,
      this.period,
      this.total_requested_month,
      this.total_approved_month});

  factory ReimbursementSummary.fromJson(Map<String, dynamic> data) =>
      ReimbursementSummary(
        reimbursement: (data['reimbursement'] != null) ? (data['reimbursement'] as Iterable)
            .map((e) => Reimbursement.fromJson(e))
            .toList() : [],
        period: (data['period'] != null) ? ReimbursementPeriod.fromJson(data['period']) : null,
        total_requested_month: data['total_requested_month'],
        total_approved_month: data['total_approved_month'],
      );

  @override
  List<Object?> get props =>
      [
        period,
        reimbursement,
      ];
}

class ReimbursementPeriod extends Equatable {
  final String? start_date;
  final String? end_date;

  ReimbursementPeriod({this.start_date, this.end_date});

  factory ReimbursementPeriod.fromJson(Map<String, dynamic> data) =>
      ReimbursementPeriod(
        start_date: data['start_date'] ?? "",
        end_date: data['end_date'] ?? "",
      );

  @override
  List<Object?> get props =>
      [
        start_date,
        end_date,
      ];
}

class Reimbursement extends Equatable {
  final int? id;
  final int? employee_id;
  final String? request_number;
  final String? title;
  final String? description;
  final String? amount;
  final String? receipt_path;
  final String? status;
  final String? transaction_date;
  final String? requested_at;
  final int? approved_by;
  final String? approved_at;
  final int? rejected_by;
  final String? rejected_at;
  final int? paid_by;
  final String? paid_at;
  final String? payment_method;
  final String? notes;
  final int? category_id;
  final ReimbursementCategory? category;
  final Employee? employee;
  final User? approver;
  final User? rejecter;
  final User? payer;

  Reimbursement({this.id, this.employee_id, this.request_number, this.title,
    this.description, this.amount, this.receipt_path, this.status,
    this.transaction_date, this.requested_at, this.approved_by,
    this.approved_at, this.rejected_by, this.rejected_at, this.paid_by, this.employee,
    this.paid_at, this.payment_method, this.notes, this.category_id,
    this.category, this.approver, this.rejecter, this.payer});

  factory Reimbursement.fromJson(Map<String, dynamic> data) =>
      Reimbursement(
        id: data['id'] ?? null,
        employee_id: data['employee_id'],
        description: data['description'],
        request_number: data['request_number'],
        title: data['title'],
        status: data['status'],
        amount: data['amount'],
        receipt_path: data['receipt_path'],
        transaction_date: data['transaction_date'],
        requested_at: data['requested_at'],
        approved_by: data['approved_by'],
        approved_at: data['approved_at'],
        rejected_by: data['rejected_by'],
        rejected_at: data['rejected_at'],
        paid_by: data['paid_by'],
        employee: (data['employee'] != null) ? Employee.fromJson(data['employee']) : null,
        paid_at: data['paid_at'],
        payment_method: data['payment_method'],
        notes: data['notes'],
        category_id: data['category_id'],
        approver: (data['approver'] != null) ? User.fromJson(data['approver']) : null,
        rejecter: (data['rejecter'] != null) ? User.fromJson(data['rejecter']) : null,
        payer: (data['payer'] != null) ? User.fromJson(data['payer']) : null,
        category: (data['category'] != null) ? ReimbursementCategory.fromJson(data['category']) : null,
      );

  @override
  List<Object?> get props =>
      [ id,
        employee_id,
        description,
        request_number,
        title,
        status,
        amount,
        receipt_path,
        transaction_date,
        requested_at,
        rejected_by,
        rejected_at,
        paid_by,
        employee,
        paid_at,
        payment_method,
        notes,
        category_id,
        approver,
        rejecter,
        payer,
        category,
      ];
}

class ReimbursementCategory extends Equatable {
  final int? id;
  final String? name;
  final String? description;
  final String? max_amount;
  final int? is_active;

  ReimbursementCategory(
      {this.id,
        this.name,
        this.description,
        this.max_amount,
        this.is_active});

  factory ReimbursementCategory.fromJson(Map<String, dynamic> data) =>
      ReimbursementCategory(
        id: data['id'] ?? null,
        name: data['name'],
        description: data['description'],
        max_amount: data['max_amount'],
        is_active: data['is_active'],
      );

  @override
  List<Object?> get props =>
      [
        id,
        name,
        description,
        max_amount,
        is_active,
      ];
}