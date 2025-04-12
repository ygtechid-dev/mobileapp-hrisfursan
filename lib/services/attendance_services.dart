part of 'services.dart';

class AttendanceServices {

  static Future<ApiReturnValue<Attendant>> getEmployeeHistory(String token, String employee_id, String start_date, String end_date, {http.Client? client}) async {
    if (client == null) {
      client = http.Client();
    }

    String url = baseUrl + 'mobile/attendance/employee/${employee_id}?start_date=${start_date}&end_date=${end_date}';

    var response = await client.get(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        });

    if (response.statusCode != 200) {
      return ApiReturnValue(message: 'Please Try Again');
    }

    var data = jsonDecode(response.body);

    print(response.body.toString());

    Attendant value = Attendant.fromJson(data["data"]);

    return ApiReturnValue(value: value);
  }

  static Future<ApiReturnValue<AttendantDetail>> getEmployeeHistoryDetail(String token, String attendance_id, {http.Client? client}) async {
    if (client == null) {
      client = http.Client();
    }

    String url = baseUrl + 'mobile/attendance/${attendance_id}';

    var response = await client.get(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        });

    if (response.statusCode != 200) {
      return ApiReturnValue(message: 'Please Try Again');
    }

    var data = jsonDecode(response.body);

    print(response.body.toString());

    AttendantDetail value = AttendantDetail.fromJson(data["data"]);

    return ApiReturnValue(value: value);
  }

  static Future<ApiReturnValue<AttendantDownload>> getDownload(String token, String attendance_id, {http.Client? client}) async {
    if (client == null) {
      client = http.Client();
    }

    String url = baseUrl + 'mobile/attendance/${attendance_id}/download';

    var response = await client.get(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        });

    var data = jsonDecode(response.body);

    if (response.statusCode != 200) {
      return ApiReturnValue(message: '${data["message"]}');
    }


    print(response.body.toString());

    AttendantDownload value = AttendantDownload.fromJson(data["data"]);

    return ApiReturnValue(value: value);
  }

  static Future<ApiReturnValue<AttendantResultClockIn>> clockIn(String token,
      String location,
      String latitude,
      String longitude,
      File photo,
      String notes,
      {http.MultipartRequest? request}) async {

    String url = baseUrl + 'mobile/attendance/clock-in';

    if (request == null) {
      request = http.MultipartRequest('POST', Uri.parse(url))
        ..headers["Content-Type"] = "multipart/form-data"
        ..headers["Authorization"] = "Bearer $token"
        ..headers["Accept"] = "application/json";
    }

    Map<String, String> fieldData = {
      'location': location ?? "",
      'latitude': latitude ?? "",
      'longitude': longitude ?? "",
      'notes': notes,
    };

    var multiPartFile =
    await http.MultipartFile.fromPath('photo', photo.path);

    request.files.add(multiPartFile);
    request.fields.addAll(fieldData);

    var response = await request.send();

    if (response.statusCode == 201 || response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      print("RESPONSE ${responseBody}");

      var data = jsonDecode(responseBody);

      AttendantResultClockIn value = AttendantResultClockIn.fromJson(data['data']);

      return ApiReturnValue(value: value, message: data['message']);
    } else {
      String responseBody = await response.stream.bytesToString();
      print("RESPONSE ${responseBody}");

      var data = jsonDecode(responseBody);

      return ApiReturnValue(message: '${data['message']}');
    }

  }

  static Future<ApiReturnValue<AttendantResultClockIn>> clockOut(String token,
      String location,
      String latitude,
      String longitude,
      File photo,
      String notes,
      {http.MultipartRequest? request}) async {

    String url = baseUrl + 'mobile/attendance/clock-out';

    if (request == null) {
      request = http.MultipartRequest('POST', Uri.parse(url))
        ..headers["Content-Type"] = "multipart/form-data"
        ..headers["Authorization"] = "Bearer $token"
        ..headers["Accept"] = "application/json";
    }

    Map<String, String> fieldData = {
      'location': location ?? "",
      'latitude': latitude ?? "",
      'longitude': longitude ?? "",
      'notes': notes,
    };

    var multiPartFile =
    await http.MultipartFile.fromPath('photo', photo.path);

    request.files.add(multiPartFile);

    request.fields.addAll(fieldData);

    var response = await request.send();

    if (response.statusCode == 201 || response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      print("RESPONSE ${responseBody}");

      var data = jsonDecode(responseBody);

      AttendantResultClockIn value = AttendantResultClockIn.fromJson(data['data']);

      return ApiReturnValue(value: value, message: '');
    } else {
      String responseBody = await response.stream.bytesToString();
      print("RESPONSE ${responseBody}");

      var data = jsonDecode(responseBody);

      return ApiReturnValue(message: '${data['message']}');
    }

  }


  static Future<ApiReturnValue<WorkingPeriodAll>> getWorkingPeriodAll(String token, {http.Client? client}) async {
    if (client == null) {
      client = http.Client();
    }

    String url = baseUrl + 'mobile/get-employee-working-period';

    var response = await client.get(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        });

    if (response.statusCode != 200) {
      return ApiReturnValue(message: 'Please Try Again');
    }

    var data = jsonDecode(response.body);

    print(response.body.toString());

    WorkingPeriodAll value = WorkingPeriodAll.fromJson(data["data"]);

    return ApiReturnValue(value: value);
  }

  static Future<ApiReturnValue<Salary>> getSalary(String token, {http.Client? client}) async {
    if (client == null) {
      client = http.Client();
    }

    String url = baseUrl + 'mobile/profile';

    var response = await client.get(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        });

    if (response.statusCode != 200) {
      return ApiReturnValue(message: 'Please Try Again');
    }

    var data = jsonDecode(response.body);

    print(response.body.toString());

    Salary value = Salary.fromJson(data["data"]);

    return ApiReturnValue(value: value);
  }


}