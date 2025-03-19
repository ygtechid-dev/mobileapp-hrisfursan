part of 'services.dart';

class ReimbursementServices {

  static Future<ApiReturnValue<ReimbursementSummary>> getReimbursementSummary(String token, {http.Client? client}) async {
    if (client == null) {
      client = http.Client();
    }

    String url = baseUrl + 'mobile/reimbursements';

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

    ReimbursementSummary value = ReimbursementSummary.fromJson(data["data"]);

    return ApiReturnValue(value: value);
  }


  static Future<ApiReturnValue<List<ReimbursementCategory>>> getListCategory(String token, {http.Client? client}) async {
    if (client == null) {
      client = http.Client();
    }

    String url = baseUrl + 'mobile/reimbursements/categories';

    var response = await client.get(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        });

    if (response.statusCode != 200) {
      return ApiReturnValue(message: 'Please Try Again');
    }

    var data = jsonDecode(response.body);

    print("List Category " + response.body.toString());

    List<ReimbursementCategory> value = (data['data'] as Iterable)
        .map((e) => ReimbursementCategory.fromJson(e))
        .toList();

    return ApiReturnValue(value: value);
  }

  static Future<ApiReturnValue<Reimbursement>> createReimbursement(String token,
      String title,
      String description,
      String category_id,
      String amount,
      String transaction_date,
      {http.MultipartRequest? request}) async {

    String url = baseUrl + 'mobile/reimbursements';

    if (request == null) {
      request = http.MultipartRequest('POST', Uri.parse(url))
        ..headers["Content-Type"] = "multipart/form-data"
        ..headers["Authorization"] = "Bearer $token"
        ..headers["Accept"] = "application/json";
    }

    Map<String, String> fieldData = {
      'category_id': category_id,
      'title': title,
      'description': description,
      'amount': amount,
      'transaction_date': transaction_date,
    };

    request.fields.addAll(fieldData);

    var response = await request.send();

    if (response.statusCode == 201 || response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      print("RESPONSE ${responseBody}");

      var data = jsonDecode(responseBody);

      Reimbursement value = Reimbursement.fromJson(data['data']);

      return ApiReturnValue(value: value, message: '');
    } else {
      String responseBody = await response.stream.bytesToString();
      print("RESPONSE ${responseBody}");

      var data = jsonDecode(responseBody);

      return ApiReturnValue(message: '${data['message']}');
    }

  }

}