part of 'services.dart';

class NotificationServices {

  static Future<ApiReturnValue<List<Notifications>>> getListNotifications(String token, {http.Client? client}) async {
    if (client == null) {
      client = http.Client();
    }

    String url = baseUrl + 'mobile/notifications';

    var response = await client.get(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        });

    if (response.statusCode != 200) {
      return ApiReturnValue(message: 'Please Try Again');
    }

    var data = jsonDecode(response.body);

    print("List Notifications " + response.body.toString());

    List<Notifications> value = (data['data'] as Iterable)
        .map((e) => Notifications.fromJson(e))
        .toList();

    return ApiReturnValue(value: value);
  }

}