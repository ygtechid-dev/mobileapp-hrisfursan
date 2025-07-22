part of 'models.dart';

class Designation extends Equatable {
  final int? id;
  final int? branch_id;
  final int? department_id;
  final String? name;

  Designation({this.id, this.branch_id, this.department_id, this.name});

  factory Designation.fromJson(Map<String, dynamic> data) =>
      Designation(
        name: data['name'] ?? null,
        id: data['id'],
        department_id: data['department_id'] ?? null,
        branch_id: data['branch_id'] ?? null,
      );

  @override
  List<Object?> get props =>
      [
        id,
        department_id,
        branch_id,
        name,

      ];
}