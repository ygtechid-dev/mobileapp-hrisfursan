part of 'services.dart';

class LeaveServices {

  static Future<ApiReturnValue<List<Leaves>>> getLeaves(String token, {http.Client? client}) async {
    if (client == null) {
      client = http.Client();
    }

    String url = baseUrl + 'mobile/leaves';

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

    List<Leaves> value = (data['data']['leaves'] as Iterable)
        .map((e) => Leaves.fromJson(e))
        .toList();

    return ApiReturnValue(value: value);
  }

  static Future<ApiReturnValue<Leaves>> submitLeaves(String token,
      String employee_id,
      String leave_type_id,
      String start_date,
      String end_date,
      String leave_reason,
      String emergency_contact,
      String remark, {http.MultipartRequest? request}) async {

    String url = baseUrl + 'mobile/leaves/submit-request';

    if (request == null) {
      request = http.MultipartRequest('POST', Uri.parse(url))
        ..headers["Content-Type"] = "multipart/form-data"
        ..headers["Authorization"] = "Bearer $token"
        ..headers["Accept"] = "application/json";
    }

    Map<String, String> fieldData = {
      'employee_id': employee_id ?? "",
      'leave_type_id': leave_type_id ?? "",
      'start_date': start_date ?? "",
      'end_date': end_date ?? "",
      'leave_reason': leave_reason,
      'remark': remark,
      'emergency_contact': emergency_contact ?? "",
    };

    request.fields.addAll(fieldData);

    var response = await request.send();

    if (response.statusCode == 201 || response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      print("RESPONSE ${responseBody}");

      var data = jsonDecode(responseBody);

      Leaves value = Leaves.fromJson(data['data']['leave']);

      return ApiReturnValue(value: value, message: '');
    } else {
      String responseBody = await response.stream.bytesToString();
      print("RESPONSE ${responseBody}");

      var data = jsonDecode(responseBody);

      return ApiReturnValue(message: '${data['message']}');
    }

  }

  static Future<ApiReturnValue<List<LeavesRemaining>>> getLeavesRemaining(String token, {http.Client? client}) async {
    if (client == null) {
      client = http.Client();
    }

    String url = baseUrl + 'mobile/leaves/check-remaining-leave';

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

    List<LeavesRemaining> value = (data['data'] as Iterable)
        .map((e) => LeavesRemaining.fromJson(e))
        .toList();

    return ApiReturnValue(value: value);
  }

  static Future<ApiReturnValue<List<LeavesTypes>>> getLeavesTypes(String token, {http.Client? client}) async {
    if (client == null) {
      client = http.Client();
    }

    String url = baseUrl + 'leave-types';

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

    List<LeavesTypes> value = (data['data'] as Iterable)
        .map((e) => LeavesTypes.fromJson(e))
        .toList();

    return ApiReturnValue(value: value);
  }

}