part of 'services.dart';


class UserServices {
  static Future<ApiReturnValue<User>> login(
      String email, String password, {http.Client? client}) async {
    if (client == null) {
      client = http.Client();
    }

    String url = baseUrl + 'login';

    var response = await client.post(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
          'platform': "mobile",
        }));

    print("RESPONSE ${response.body}");

    if (response.statusCode != 200) {
      return ApiReturnValue(message: 'Please Try Again');
    }

    var data = jsonDecode(response.body);

    User.token = data['data']['token'];
    User value = User.fromJson(data['data']['user']);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', data['data']['token']);

    return ApiReturnValue(value: value);
  }

  static Future<ApiReturnValue<String>> logout(String token, {http.Client? client}) async {
    if (client == null) {
      client = http.Client();
    }

    String url = baseUrl + 'logout';

    var response = await client.post(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: jsonEncode(<String, dynamic>{

        }));

    if (response.statusCode != 200) {
      return ApiReturnValue(message: 'Please Try Again');
    }

    var data = jsonDecode(response.body);

    String value = data['message'];

    return ApiReturnValue(value: value);
  }

}