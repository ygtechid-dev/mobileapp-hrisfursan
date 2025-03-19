part of 'services.dart';

class DesignationServices {

  static Future<ApiReturnValue<List<Designation>>> getDesignations(String token, {http.Client? client}) async {
    if (client == null) {
      client = http.Client();
    }

    String url = baseUrl + 'designations';

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

    List<Designation> value = (data['data'] as Iterable)
        .map((e) => Designation.fromJson(e))
        .toList();

    return ApiReturnValue(value: value);
  }


}