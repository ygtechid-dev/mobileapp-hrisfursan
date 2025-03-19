part of 'services.dart';

class OvertimesServices {

  static Future<ApiReturnValue<List<Overtimes>>> getOvertimes(String token, {http.Client? client}) async {
    if (client == null) {
      client = http.Client();
    }

    String url = baseUrl + 'mobile/overtimes';

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

    List<Overtimes> value = (data['data'] as Iterable)
        .map((e) => Overtimes.fromJson(e))
        .toList();

    return ApiReturnValue(value: value);
  }

  static Future<ApiReturnValue<Overtimes>> submitLeaves(String token,
      String start_time,
      String end_time,
      String overtime_date,
      String remark, {String? title, http.MultipartRequest? request}) async {

    String url = baseUrl + 'mobile/overtimes/submit-request';

    if (request == null) {
      request = http.MultipartRequest('POST', Uri.parse(url))
        ..headers["Content-Type"] = "multipart/form-data"
        ..headers["Authorization"] = "Bearer $token"
        ..headers["Accept"] = "application/json";
    }

    Map<String, String> fieldData = {
      'start_time': start_time ?? "",
      'end_time': end_time ?? "",
      'overtime_date': overtime_date ?? "",
      'remark': remark,
      'title': title ?? "",
    };

    request.fields.addAll(fieldData);

    var response = await request.send();

    if (response.statusCode == 201 || response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      print("RESPONSE ${responseBody}");

      var data = jsonDecode(responseBody);

      Overtimes value = Overtimes.fromJson(data['data']['overtime']);

      return ApiReturnValue(value: value, message: '');
    } else {
      String responseBody = await response.stream.bytesToString();
      print("RESPONSE ${responseBody}");

      var data = jsonDecode(responseBody);

      return ApiReturnValue(message: '${data['message']}');
    }

  }

}