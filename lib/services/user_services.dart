part of 'services.dart';


class UserServices {
  static Future<ApiReturnValue<User>> login(
      String email, String password, {http.MultipartRequest? request}) async {

    String url = baseUrl + 'login';

    if (request == null) {
      request = http.MultipartRequest('POST', Uri.parse(url))
        ..headers["Content-Type"] = "multipart/form-data"
        ..headers["Accept"] = "application/json";
    }

    Map<String, String> fieldData = {
      'login': email,
      'password': password,
      'login_type': "email",
      'platform': "mobile",
    };

    request.fields.addAll(fieldData);

    var response = await request.send();

    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      print("RESPONSE ${responseBody}");

      var data = jsonDecode(responseBody);

      User.token = data['data']['token'];
      User value = User.fromJson(data['data']['user']);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', data['data']['token']);

      return ApiReturnValue(value: value, message: '');
    } else {
      String responseBody = await response.stream.bytesToString();
      print("RESPONSE ${responseBody}");

      var data = jsonDecode(responseBody);

      return ApiReturnValue(message: '${data['message']}');
    }

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


  static Future<ApiReturnValue<User>> register(
      User user, String password, {http.MultipartRequest? request}) async {


    String url = baseUrl + 'mobile/sign-up';

    if (request == null) {
      request = http.MultipartRequest('POST', Uri.parse(url))
        ..headers["Content-Type"] = "multipart/form-data"
        ..headers["Accept"] = "application/json";
    }

    Map<String, String> fieldData = {
      'email': user.email ?? "",
      'phone': user.phone ?? '',
      'company_id': user.company_id ?? "CMP-1737691213LDY86",
      'first_name': user.first_name ?? "h",
      'last_name': user.last_name ?? "h",
      'password_confirmation': password,
      'password': password,
    };

    request.fields.addAll(fieldData);

    var response = await request.send();

    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      print("RESPONSE ${responseBody}");

      var data = jsonDecode(responseBody);

      User.token = data['data']['token'];
      User value = User.fromJson(data['data']['user']);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', data['data']['token']);

      return ApiReturnValue(value: value, message: '');
    } else {
      String responseBody = await response.stream.bytesToString();
      print("RESPONSE ${responseBody}");

      var data = jsonDecode(responseBody);

      return ApiReturnValue(message: '${data['message']}');
    }

  }

  static Future<ApiReturnValue<User>> update(String token,
      User user, {http.MultipartRequest? request}) async {


    String url = baseUrl + 'mobile/update-account-profile';

    if (request == null) {
      request = http.MultipartRequest('POST', Uri.parse(url))
        ..headers["Content-Type"] = "multipart/form-data"
        ..headers["Authorization"] = "Bearer $token"
        ..headers["Accept"] = "application/json";
    }

    Map<String, String> fieldData = {
      'phone': user.phone ?? "",
      'dob': user.dob ?? "",
      'first_name': user.first_name ?? "",
      'last_name': user.last_name ?? "",
      'designation_id': "1",
      'address': user.address ?? "",
    };

    request.fields.addAll(fieldData);

    var response = await request.send();

    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      print("RESPONSE ${responseBody}");

      var data = jsonDecode(responseBody);


      User value = User.fromJson(data['data']['user']);

      return ApiReturnValue(value: value, message: '');
    } else {
      String responseBody = await response.stream.bytesToString();
      print("RESPONSE ${responseBody}");

      var data = jsonDecode(responseBody);

      return ApiReturnValue(message: '${data['message']}');
    }

  }

  static Future<ApiReturnValue<bool>> forgot_password(String token, String email, {http.MultipartRequest? request}) async {

    String url = baseUrl + 'mobile/forgot-password';

    if (request == null) {
      request = http.MultipartRequest('POST', Uri.parse(url))
        ..headers["Content-Type"] = "multipart/form-data"
        ..headers["Authorization"] = "Bearer $token"
        ..headers["Accept"] = "application/json";
    }

    Map<String, String> fieldData = {
      'email': email,
    };

    request.fields.addAll(fieldData);

    var response = await request.send();

    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      print("RESPONSE ${responseBody}");

      var data = jsonDecode(responseBody);


      bool value = data['status'];

      return ApiReturnValue(value: value, message: '${data['message']}');
    } else {
      String responseBody = await response.stream.bytesToString();
      print("RESPONSE ${responseBody}");

      var data = jsonDecode(responseBody);

      return ApiReturnValue(message: '${data['message']}', value: false);
    }
  }

  static Future<ApiReturnValue<bool>> check_token(String token, String email, {http.MultipartRequest? request}) async {

    String url = baseUrl + 'mobile/check-reset-token';

    if (request == null) {
      request = http.MultipartRequest('POST', Uri.parse(url))
        ..headers["Content-Type"] = "multipart/form-data"
        ..headers["Authorization"] = "Bearer $token"
        ..headers["Accept"] = "application/json";
    }

    Map<String, String> fieldData = {
      'token': "token",
      'email': email,
    };

    request.fields.addAll(fieldData);

    var response = await request.send();

    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      print("RESPONSE ${responseBody}");

      var data = jsonDecode(responseBody);


      bool value = data['status'];

      return ApiReturnValue(value: value, message: '${data['message']}');
    } else {
      String responseBody = await response.stream.bytesToString();
      print("RESPONSE ${responseBody}");

      var data = jsonDecode(responseBody);

      return ApiReturnValue(message: '${data['message']}', value: false);
    }
  }

  static Future<ApiReturnValue<bool>> reset_password(String token, String email, String password, String password_confirmation, {http.MultipartRequest? request}) async {


    String url = baseUrl + 'mobile/reset-password';


    if (request == null) {
      request = http.MultipartRequest('POST', Uri.parse(url))
        ..headers["Content-Type"] = "multipart/form-data"
        ..headers["Authorization"] = "Bearer $token"
        ..headers["Accept"] = "application/json";
    }

    Map<String, String> fieldData = {
      'token': "token",
      'email': email,
      'password': password,
      'password_confirmation': password_confirmation,
    };

    request.fields.addAll(fieldData);

    var response = await request.send();

    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      print("RESPONSE ${responseBody}");

      var data = jsonDecode(responseBody);


      bool value = data['status'];

      return ApiReturnValue(value: value, message: '${data['message']}');
    } else {
      String responseBody = await response.stream.bytesToString();
      print("RESPONSE ${responseBody}");

      var data = jsonDecode(responseBody);

      return ApiReturnValue(message: '${data['message']}', value: false);
    }
  }
}