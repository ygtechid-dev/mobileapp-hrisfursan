part of "models.dart";

class Attendant extends Equatable {
  final String? employee_id;
  final String? company_timezone;
  final List<AttendantRecords>? attendance_records;

  Attendant(
      {this.employee_id,
        this.company_timezone,
        this.attendance_records,
        });

  factory Attendant.fromJson(Map<String, dynamic> data) =>
      Attendant(
        employee_id: data['employee_id'] ?? null,
        company_timezone: data['company_timezone'],
        attendance_records: (data['attendance_records'] != null) ? (data['attendance_records'] as Iterable)
            .map((e) => AttendantRecords.fromJson(e))
            .toList() : [],
      );

  @override
  List<Object?> get props =>
      [
        company_timezone,
        employee_id,
        attendance_records,
      ];
}

class AttendantRecords extends Equatable {
  final int? id;
  final String? date;
  final String? employee_name;
  final String? clock_in;
  final String? clock_in_location;
  final String? clock_in_latitude;
  final String? clock_in_longitude;
  final String? clock_in_photo;
  final String? clock_in_notes;
  final String? clock_out;
  final String? clock_out_location;
  final String? clock_out_latitude;
  final String? clock_out_longitude;
  final String? clock_out_photo;
  final String? clock_out_notes;
  final String? status;
  final String? late;
  final String? early_leaving;
  final String? timezone;
  final String? overtime;
  final String? total_rest;
  final String? clock_in_formatted;
  final String? clock_out_formatted;

  AttendantRecords({this.id, this.date, this.employee_name, this.clock_in,
    this.clock_in_location, this.clock_in_latitude, this.clock_in_longitude,
    this.clock_in_photo, this.clock_in_notes, this.clock_out,
    this.clock_out_location, this.clock_out_latitude,
    this.clock_out_longitude, this.clock_out_photo, this.clock_out_notes,
    this.status, this.late, this.early_leaving, this.timezone, this.overtime,
    this.total_rest, this.clock_in_formatted, this.clock_out_formatted});

  factory AttendantRecords.fromJson(Map<String, dynamic> data) =>
      AttendantRecords(
        id: data['id'] ?? 1,
        date: data['date'] ?? null,
        employee_name: data['employee_name'],
        clock_in: data['clock_in'] ?? null,
        clock_in_location: data['clock_in_location'] ?? null,
        clock_in_latitude: data['clock_in_latitude'] ?? null,
        clock_in_longitude: data['clock_in_longitude'],
        clock_in_photo: data['clock_in_photo'] ?? null,
        clock_in_notes: data['clock_in_notes'] ?? null,
        clock_out: data['clock_out'] ?? null,
        clock_out_location: data['clock_out_location'] ?? null,
        clock_out_latitude: data['clock_out_latitude'] ?? null,
        clock_out_longitude: data['clock_out_longitude'] ?? null,
        clock_out_photo: data['clock_out_photo'] ?? null,
        clock_out_notes: data['clock_out_notes'] ?? null,
        status: data['status'] ?? null,
        late: data['late'] ?? null,
        early_leaving: data['early_leaving'] ?? null,
        timezone: data['timezone'] ?? null,
        overtime: data['overtime'] ?? null,
        total_rest: data['total_rest'] ?? null,
        clock_in_formatted: data['clock_in_formatted'] ?? null,
        clock_out_formatted: data['clock_out_formatted'] ?? null,
      );

  @override
  List<Object?> get props =>
      [
        id,
        date,
        employee_name,
        clock_in,
        clock_in_location,
        clock_in_latitude,
        clock_in_longitude,
        clock_in_photo,
        clock_in_notes,
        clock_out,
        clock_out_location,
        clock_out_latitude,
        clock_out_longitude,
        clock_out_photo,
        clock_out_notes,
        status,
        late,
        early_leaving,
        timezone,
        overtime,
        total_rest,
        clock_in_formatted,
        clock_out_formatted,
      ];
}

class AttendantDetail extends Equatable {
  final int? id;
  final String? date;
  final Employee? employee;
  final ClockIn? clock_in;
  final ClockOut? clock_out;
  final Schedule? schedule;
  final String? status;
  final Metrics? metrics;
  final String? timezone;

  AttendantDetail({this.id, this.date, this.employee, this.clock_in,
    this.clock_out, this.schedule, this.status, this.metrics, this.timezone});

  factory AttendantDetail.fromJson(Map<String, dynamic> data) =>
      AttendantDetail(
        date: data['date'] ?? null,
        id: data['id'],
        employee: (data['employee'] != null) ?  Employee.fromJson(data['employee']) : null,
        clock_in: (data['clock_in'] != null) ?  ClockIn.fromJson(data['clock_in']) : null,
        clock_out: (data['clock_out'] != null) ?  ClockOut.fromJson(data['clock_out']) : null,
        schedule: (data['schedule'] != null) ?  Schedule.fromJson(data['schedule']) : null,
        status: data['status'] ?? "",
        timezone: data['timezone'] ?? "",
        metrics: (data['metrics'] != null) ?  Metrics.fromJson(data['metrics']) : null,
      );

  @override
  List<Object?> get props =>
      [
        employee,
        date,
        id,
        clock_out,
        clock_in,
        schedule,
        status,
        timezone,
        metrics,
      ];
}

class Employee extends Equatable {
  final int? id;
  final String? name;
  final String? employee_id;
  final String? address;
  final Designation? designation;

  Employee(
      {this.id,
        this.name,
        this.employee_id,
        this.designation,
        this.address,
      });

  factory Employee.fromJson(Map<String, dynamic> data) =>
      Employee(
        id: data['id'] ?? null,
        name: data['name'],
        employee_id: data['employee_id'],
        address: data['address'],
        designation: (data['designation'] != null) ?  Designation.fromJson(data['designation']) : null,
      );

  @override
  List<Object?> get props =>
      [
        id,
        name,
        employee_id
      ];
}

class ClockIn extends Equatable {
  final String? time;
  final String? photo;
  final String? location;
  final String? latitude;
  final String? longitude;
  final String? notes;

  ClockIn({this.time, this.photo, this.location, this.latitude, this.longitude,
    this.notes});

  factory ClockIn.fromJson(Map<String, dynamic> data) =>
      ClockIn(
        time: data['time'] ?? null,
        photo: data['photo'] ?? "",
        location: data['location'] ?? "",
        latitude: data['latitude'] ?? "",
        longitude: data['longitude'] ?? "",
        notes: data['notes'] ?? "",
      );

  @override
  List<Object?> get props =>
      [
        time,
        photo,
        location,
        latitude,
        longitude,
        notes
      ];
}

class ClockOut extends Equatable {
  final String? time;
  final String? photo;
  final String? location;
  final String? latitude;
  final String? longitude;
  final String? notes;

  ClockOut({this.time, this.photo, this.location, this.latitude, this.longitude,
    this.notes});

  factory ClockOut.fromJson(Map<String, dynamic> data) =>
      ClockOut(
        time: data['time'] ?? null,
        photo: data['photo'] ?? "",
        location: data['location'] ?? "",
        latitude: data['latitude'] ?? "",
        longitude: data['longitude'] ?? "",
        notes: data['notes'] ?? "",
      );

  @override
  List<Object?> get props =>
      [
        time,
        photo,
        location,
        latitude,
        longitude,
        notes
      ];
}

class Schedule extends Equatable {
  final String? start_time;
  final String? end_time;

  Schedule(
      {this.start_time,
        this.end_time
      });

  factory Schedule.fromJson(Map<String, dynamic> data) =>
      Schedule(
        start_time: data['start_time'] ?? null,
        end_time: data['end_time'],
      );

  @override
  List<Object?> get props =>
      [
        start_time,
        end_time
      ];
}

class Metrics extends Equatable {
  final String? late;
  final String? early_leaving;
  final String? overtime;
  final String? total_rest;

  Metrics(
      {
        this.late,
        this.early_leaving,
        this.overtime,
        this.total_rest
      });

  factory Metrics.fromJson(Map<String, dynamic> data) =>
      Metrics(
        late: data['late'] ?? null,
        early_leaving: data['early_leaving'],
        overtime: data['overtime'] ?? null,
        total_rest: data['total_rest'],
      );

  @override
  List<Object?> get props =>
      [
        overtime,
        total_rest,
        late,
        early_leaving
      ];
}

class AttendantDownload extends Equatable {
  final String? download_url;
  final String? filename;

  AttendantDownload(
      {this.download_url,
        this.filename
      });

  factory AttendantDownload.fromJson(Map<String, dynamic> data) =>
      AttendantDownload(
        download_url: data['download_url'] ?? null,
        filename: data['filename'],
      );

  @override
  List<Object?> get props =>
      [
        filename,
        download_url
      ];
}

class AttendantResultClockIn extends Equatable {
  final AttendantResultDetail? attendance;
  final Employee? employee;
  final String? clock_in_time;
  final String? late_duration;
  final String? datetime_utc;

  AttendantResultClockIn({this.attendance, this.employee, this.clock_in_time,
    this.late_duration, this.datetime_utc});

  factory AttendantResultClockIn.fromJson(Map<String, dynamic> data) =>
      AttendantResultClockIn(
        late_duration: data['late_duration'] ?? null,
        clock_in_time: data['clock_in_time'],
        employee: (data['employee'] != null) ?  Employee.fromJson(data['employee']) : null,
        attendance: (data['attendance'] != null) ?  AttendantResultDetail.fromJson(data['attendance']) : null,
        datetime_utc: data['datetime_utc'] ?? "",
      );

  @override
  List<Object?> get props =>
      [
        employee,
        late_duration,
        clock_in_time,
        employee,
        attendance,
        datetime_utc,
      ];
}

class AttendantResultClockOut extends Equatable {
  final AttendantResultDetail? attendance;
  final Employee? employee;
  final String? early_leaving;
  final String? overtime;
  final String? datetime_utc;

  AttendantResultClockOut({this.attendance, this.employee, this.early_leaving,
    this.overtime, this.datetime_utc});

  factory AttendantResultClockOut.fromJson(Map<String, dynamic> data) =>
      AttendantResultClockOut(
        early_leaving: data['early_leaving'] ?? null,
        overtime: data['overtime'],
        employee: (data['employee'] != null) ?  Employee.fromJson(data['employee']) : null,
        attendance: (data['attendance'] != null) ?  AttendantResultDetail.fromJson(data['attendance']) : null,
        datetime_utc: data['datetime_utc'] ?? "",
      );

  @override
  List<Object?> get props =>
      [
        employee,
        early_leaving,
        overtime,
        employee,
        attendance,
        datetime_utc,
      ];
}

class AttendantResultDetail extends Equatable {
  final int? id;
  final int? employee_id;
  final String? date;
  final String? clock_in;
  final String? clock_out;
  final String? late;
  final String? early_leaving;
  final String? overtime;
  final String? total_rest;
  final String? status;
  final String? timezone;

  AttendantResultDetail({this.id, this.employee_id, this.date, this.clock_in,
    this.clock_out, this.late, this.early_leaving, this.overtime,
    this.total_rest, this.status, this.timezone});

  factory AttendantResultDetail.fromJson(Map<String, dynamic> data) =>
      AttendantResultDetail(
        id: data['id'] ?? null,
        employee_id: data['employee_id'],
        clock_in: data['clock_in'] ?? "",
        clock_out: data['clock_out'] ?? "",
        late: data['late'] ?? "",
        early_leaving: data['early_leaving'] ?? "",
        overtime: data['overtime'] ?? "",
        total_rest: data['total_rest'] ?? "",
        status: data['status'] ?? "",
        timezone: data['timezone'] ?? "",
      );

  @override
  List<Object?> get props =>
      [
        id,
        employee_id,
        clock_in,
        clock_out,
        late,
        early_leaving,
        overtime,
        total_rest,
        status,
        timezone,
      ];
}

class WorkingPeriod extends Equatable {
  final int? employee_id;
  final String? year;
  final String? month;
  final String? month_name;
  final String? year_month;
  final double? total_working_days;
  final double? total_working_hours;

  WorkingPeriod(
      {this.employee_id,
      this.year,
      this.month,
      this.month_name,
      this.year_month,
      this.total_working_days,
      this.total_working_hours});

  factory WorkingPeriod.fromJson(Map<String, dynamic> data) =>
      WorkingPeriod(
        employee_id: data['employee_id'] ?? null,
        year: data['year'] ?? "",
        month: data['month'] ?? "",
        month_name: data['month_name'] ?? "",
        year_month: data['year_month'] ?? "",
        total_working_days: double.parse("${data['total_working_days']}") ?? 0,
        total_working_hours: double.parse("${data['total_working_hours']}") ?? 0,

      );

  @override
  // TODO: implement props
  List<Object?> get props => [employee_id, year, month, month_name, year_month, total_working_days, total_working_hours];
}

class WorkingPeriodSummary extends Equatable {
  final String? start_year_month;
  final String? end_year_month;
  final double? total_months;
  final double? total_working_days;
  final double? total_days_present;
  final double? total_days_absent;
  final double? total_working_hours;

  WorkingPeriodSummary(
      {
      this.start_year_month,
      this.end_year_month,
      this.total_months,
      this.total_working_days,
      this.total_days_present,
      this.total_days_absent,
      this.total_working_hours});

  factory WorkingPeriodSummary.fromJson(Map<String, dynamic> data) =>
      WorkingPeriodSummary(
        start_year_month: data['start_year_month'] ?? null,
        end_year_month: data['end_year_month'] ?? 0.0,
        total_months: double.parse("${data['total_months']}") ?? 0.0,
        total_working_days: double.parse("${data['total_working_days']}") ?? 0.0,
        total_days_present: double.parse("${data['total_days_present']}") ?? 0.0,
        total_days_absent: double.parse("${data['total_days_absent']}") ?? 0.0,
        total_working_hours: double.parse("${data['total_working_hours']}") ?? 0.0,

      );

  @override
  // TODO: implement props
  List<Object?> get props => [start_year_month, end_year_month, total_months, total_working_days, total_days_present, total_working_days, total_working_hours];
}

class WorkingPeriodAll extends Equatable {
  final WorkingPeriodSummary? summary;
  final List<WorkingPeriod>? monthly_data;

  WorkingPeriodAll(
      {this.summary,
        this.monthly_data
      });

  factory WorkingPeriodAll.fromJson(Map<String, dynamic> data) =>
      WorkingPeriodAll(
        summary: (data['summary'] != null) ?  WorkingPeriodSummary.fromJson(data['summary']) : null,
        monthly_data: (data['monthly_data'] != null) ? (data['monthly_data'] as Iterable)
            .map((e) => WorkingPeriod.fromJson(e))
            .toList() : [],
      );

  @override
  List<Object?> get props =>
      [
        summary,
        monthly_data
      ];
}

class Salary extends Equatable {
  final int? employee_id;
  final String? start_date;
  final String? end_date;
  final int? salary;
  final String? performance_status;

  Salary({this.employee_id, this.start_date, this.end_date, this.salary, this.performance_status});

  factory Salary.fromJson(Map<String, dynamic> data) =>
      Salary(
        employee_id: data['employee_id'] ?? null,
        start_date: data['start_date'] ?? "",
        end_date: data['end_date'] ?? "",
        salary: data['user']['employee']['salary'] ?? 0,
        performance_status: data['performance_status'] ?? "Good",
      );

  @override
  // TODO: implement props
  List<Object?> get props => [employee_id, start_date, end_date, salary, performance_status];
}