part of 'services.dart';


class UserServices {
  static Future<ApiReturnValue<User>> login(
      String email, String password, {String? login_type, http.MultipartRequest? request}) async {

    String url = baseUrl + 'login';

    if (request == null) {
      request = http.MultipartRequest('POST', Uri.parse(url))
        ..headers["Content-Type"] = "multipart/form-data"
        ..headers["Accept"] = "application/json";
    }

    Map<String, String> fieldData = {
      'login': email,
      'password': password,
      'login_type': "${login_type}",
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

static Future<ApiReturnValue<User>> getProfile(String token, {http.Client? client}) async {
  if (client == null) {
    client = http.Client();
  }

  String url = baseUrl + 'mobile/profile';
  
  print("=== UserService getProfile START ===");
  print("URL: $url");
  print("Token: $token");

  var response = await client.get(Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      });

  print("=== HTTP Response ===");
  print("Status Code: ${response.statusCode}");
  print("Response Body: ${response.body}");

  if (response.statusCode != 200) {
    print("=== HTTP Error ===");
    return ApiReturnValue(message: 'Please Try Again');
  }

  var data = jsonDecode(response.body);
  
  print("=== Parsed JSON Debug ===");
  print("Full data: $data");
  
  // Debug data structure
  if (data["data"] != null) {
    print("data['data'] exists: ${data["data"]}");
    
    if (data["data"]['user'] != null) {
      print("data['data']['user'] exists");
      var userData = data["data"]['user'];
      
      print("=== User Data Fields ===");
      print("ID: ${userData['id']}");
      print("First Name: ${userData['first_name']}");
      print("Email: ${userData['email']}");
      print("Plan: ${userData['plan']}");
      print("Subscription RAW: ${userData['subscription']}");
      print("Subscription Type: ${userData['subscription'].runtimeType}");
      
      // Test manual access
      String? testSubscription = userData['subscription'];
      print("Manual subscription extraction: $testSubscription");
      
    } else {
      print("ERROR: data['data']['user'] is null");
    }
  } else {
    print("ERROR: data['data'] is null");
  }

  print("=== Creating User Model ===");
  User value = User.fromJson(data["data"]['user']);
  
  print("=== User Model Created ===");
  print("User ID: ${value.id}");
  print("User Name: ${value.first_name} ${value.last_name}");
  print("User Plan: ${value.plan}");
  print("User Subscription: ${value.subscription}");
  print("User Subscription Type: ${value.subscription.runtimeType}");

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
      'designation_id': user.designation_id ?? "1",
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

  static Future<ApiReturnValue<User>> updatePhoto(String token, File file, {http.MultipartRequest? request}) async {


    String url = baseUrl + 'mobile/update-photo-profile';


    if (request == null) {
      request = http.MultipartRequest('POST', Uri.parse(url))
        ..headers["Content-Type"] = "multipart/form-data"
        ..headers["Authorization"] = "Bearer $token"
        ..headers["Accept"] = "application/json";
    }

    var multiPartFile =
    await http.MultipartFile.fromPath('avatar', file.path);

    request.files.add(multiPartFile);

    var response = await request.send();

    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      print("RESPONSE ${responseBody}");

      var data = jsonDecode(responseBody);


      User value = User.fromJson(data['data']['user']);

      return ApiReturnValue(value: value, message: '${data['message']}');
    } else {
      String responseBody = await response.stream.bytesToString();
      print("RESPONSE ${responseBody}");

      var data = jsonDecode(responseBody);

      return ApiReturnValue(message: '${data['message']}', value: data);
    }
  }

  static Future<ApiReturnValue<bool>> forgot_password(String email, {http.MultipartRequest? request}) async {

    String url = baseUrl + 'mobile/forgot-password';

    if (request == null) {
      request = http.MultipartRequest('POST', Uri.parse(url))
        ..headers["Content-Type"] = "multipart/form-data"
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

  static Future<ApiReturnValue<bool>> check_token(String email, String tokenPin, {http.MultipartRequest? request}) async {

    String url = baseUrl + 'mobile/check-reset-token';

    if (request == null) {
      request = http.MultipartRequest('POST', Uri.parse(url))
        ..headers["Content-Type"] = "multipart/form-data"
        ..headers["Accept"] = "application/json";
    }

    Map<String, String> fieldData = {
      'token': tokenPin,
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

  static Future<ApiReturnValue<bool>> reset_password(String tokenPin, String email, String password, String password_confirmation, {http.MultipartRequest? request}) async {


    String url = baseUrl + 'mobile/reset-password';


    if (request == null) {
      request = http.MultipartRequest('POST', Uri.parse(url))
        ..headers["Content-Type"] = "multipart/form-data"
        ..headers["Accept"] = "application/json";
    }

    Map<String, String> fieldData = {
      'token': tokenPin,
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

  static Future<ApiReturnValue<Resign>> submitResign(String token, Resign resignData, File file, {http.MultipartRequest? request}) async {


    String url = baseUrl + 'mobile/resign';


    if (request == null) {
      request = http.MultipartRequest('POST', Uri.parse(url))
        ..headers["Content-Type"] = "multipart/form-data"
        ..headers["Authorization"] = "Bearer $token"
        ..headers["Accept"] = "application/json";
    }

    Map<String, String> fieldData = {
      'resignation_date': resignData.resign_date ?? "",
      'description': resignData.description ?? "",
    };

    var multiPartFile =
    await http.MultipartFile.fromPath('attachment', file.path);

    request.files.add(multiPartFile);
    request.fields.addAll(fieldData);

    var response = await request.send();

    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      print("RESPONSE ${responseBody}");

      var data = jsonDecode(responseBody);


      Resign value = Resign.fromJson(data["data"]);

      return ApiReturnValue(value: value, message: '${data['message']}', status: data["status"]);
    } else {
      String responseBody = await response.stream.bytesToString();
      print("RESPONSE ${responseBody}");

      var data = jsonDecode(responseBody);

      Resign value = Resign.fromJson(data["data"]);

      return ApiReturnValue(message: '${data['message']}', value: value, status: data["status"]);
    }
  }

  static Future<ApiReturnValue<OfficeAssets>> getOfficeAssets(String token, {http.Client? client}) async {
    if (client == null) {
      client = http.Client();
    }

    String url = baseUrl + 'mobile/office-assets';

    var response = await client.get(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        });

    print("OFFICE " + response.body.toString());

    if (response.statusCode != 200) {
      return ApiReturnValue(message: 'Please Try Again');
    }

    var data = jsonDecode(response.body);



    OfficeAssets? value = (data["data"].isNotEmpty && data["data"][0] != null) ? OfficeAssets.fromJson(data["data"][0]) : null;

    return ApiReturnValue(value: value);
  }
}