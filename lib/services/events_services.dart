part of 'services.dart';

class EventsServices {

  static Future<ApiReturnValue<List<EventData>>> getListEvents(String token, {http.Client? client}) async {
    if (client == null) {
      client = http.Client();
    }

    String url = baseUrl + 'mobile/events';

    var response = await client.get(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        });

    print("List Events " + response.body.toString());

    if (response.statusCode != 200) {
      return ApiReturnValue(message: 'Please Try Again');
    }

    var data = jsonDecode(response.body);



    List<EventData> value = (data['data'] as Iterable)
        .map((e) => EventData.fromJson(e))
        .toList();

    return ApiReturnValue(value: value);
  }

}