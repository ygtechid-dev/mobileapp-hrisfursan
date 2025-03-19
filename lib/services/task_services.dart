part of 'services.dart';

class TaskServices {

  static Future<ApiReturnValue<ProjectsSummary>> getProjectSummary(String token, {http.Client? client}) async {
    if (client == null) {
      client = http.Client();
    }

    String url = baseUrl + 'mobile/projects';

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

    List<Projects> projects = (data['data']["projects"] as Iterable)
        .map((e) => Projects.fromJson(e))
        .toList();

    ProjectsCounts project_counts = ProjectsCounts.fromJson(data["data"]["project_counts"]);

    List<Tasks> taskTemp = [];

    await getListTask(token).then((dataTask) async {
      if(dataTask.value != null){
        taskTemp = dataTask.value!;
      }
    });

    projects.forEach((item){

      if(taskTemp.where((e) => e.project_id == item.id).isNotEmpty){
        List<Tasks> tempTasks = taskTemp.where((e) => e.project_id == item.id).toList();
        item.copyWith(tasks: tempTasks);
      }

    });

    ProjectsSummary value = ProjectsSummary(projects: projects, project_counts: project_counts,);

    return ApiReturnValue(value: value);
  }

  static Future<ApiReturnValue<List<Tasks>>> getListTask(String token, {http.Client? client}) async {
    if (client == null) {
      client = http.Client();
    }

    String url = baseUrl + 'mobile/all-task';

    var response = await client.get(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        });

    if (response.statusCode != 200) {
      return ApiReturnValue(message: 'Please Try Again');
    }

    var data = jsonDecode(response.body);

    print("List Task " + response.body.toString());

    List<Tasks> value = (data['data'] as Iterable)
        .map((e) => Tasks.fromJson(e))
        .toList();

    return ApiReturnValue(value: value);
  }

  static Future<ApiReturnValue<Tasks>> getTaskDetail(String token, String task_id, {http.Client? client}) async {
    if (client == null) {
      client = http.Client();
    }

    String url = baseUrl + 'mobile/projects/tasks/${task_id}';

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

    Tasks value = Tasks.fromJson(data["data"]);

    return ApiReturnValue(value: value);
  }

  static Future<ApiReturnValue<Tasks>> updateStatus(String token, String task_id,
      String status,
      {http.MultipartRequest? request}) async {

    String url = baseUrl + 'mobile/projects/tasks/${task_id}/update-status';

    if (request == null) {
      request = http.MultipartRequest('POST', Uri.parse(url))
        ..headers["Content-Type"] = "multipart/form-data"
        ..headers["Authorization"] = "Bearer $token"
        ..headers["Accept"] = "application/json";
    }

    Map<String, String> fieldData = {
      '_method': "put",
      'status': status ?? "",
    };

    request.fields.addAll(fieldData);

    var response = await request.send();

    if (response.statusCode == 201 || response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      print("RESPONSE ${responseBody}");

      var data = jsonDecode(responseBody);

      Tasks value = Tasks.fromJson(data['data']);

      return ApiReturnValue(value: value, message: '');
    } else {
      String responseBody = await response.stream.bytesToString();
      print("RESPONSE ${responseBody}");

      var data = jsonDecode(responseBody);

      return ApiReturnValue(message: '${data['message']}');
    }

  }

  static Future<ApiReturnValue<TaskComment>> addComments(String token, String task_id,
      String comment,
      {http.MultipartRequest? request}) async {

    String url = baseUrl + 'mobile/projects/tasks/${task_id}/add-comment';

    if (request == null) {
      request = http.MultipartRequest('POST', Uri.parse(url))
        ..headers["Content-Type"] = "multipart/form-data"
        ..headers["Authorization"] = "Bearer $token"
        ..headers["Accept"] = "application/json";
    }

    Map<String, String> fieldData = {
      'comment': comment ?? "",
    };

    request.fields.addAll(fieldData);

    var response = await request.send();

    if (response.statusCode == 201 || response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      print("RESPONSE ${responseBody}");

      var data = jsonDecode(responseBody);

      TaskComment value = TaskComment.fromJson(data['data']['comment']);

      return ApiReturnValue(value: value, message: '');
    } else {
      String responseBody = await response.stream.bytesToString();
      print("RESPONSE ${responseBody}");

      var data = jsonDecode(responseBody);

      return ApiReturnValue(message: '${data['message']}');
    }

  }

  static Future<ApiReturnValue<TaskAttachment>> addAttachment(String token, String task_id,
      File file,
      {http.MultipartRequest? request}) async {

    String url = baseUrl + 'mobile/projects/tasks/${task_id}/add-attachment';

    if (request == null) {
      request = http.MultipartRequest('POST', Uri.parse(url))
        ..headers["Content-Type"] = "multipart/form-data"
        ..headers["Authorization"] = "Bearer $token"
        ..headers["Accept"] = "application/json";
    }

    var multiPartFile =
    await http.MultipartFile.fromPath('file', file.path);

    request.files.add(multiPartFile);

    var response = await request.send();

    if (response.statusCode == 201 || response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      print("RESPONSE ${responseBody}");

      var data = jsonDecode(responseBody);

      TaskAttachment value = TaskAttachment.fromJson(data['data']['attachment']);

      return ApiReturnValue(value: value, message: '');
    } else {
      String responseBody = await response.stream.bytesToString();
      print("RESPONSE ${responseBody}");

      var data = jsonDecode(responseBody);

      return ApiReturnValue(message: '${data['message']}');
    }

  }

  static Future<ApiReturnValue<Tasks>> createTask(String token,
      String project_id,
      String title,
      String description,
      String priority,
      String due_date,
      List<File> attachments,
      {http.MultipartRequest? request}) async {

    String url = baseUrl + 'mobile/projects/tasks/create-task';

    if (request == null) {
      request = http.MultipartRequest('POST', Uri.parse(url))
        ..headers["Content-Type"] = "multipart/form-data"
        ..headers["Authorization"] = "Bearer $token"
        ..headers["Accept"] = "application/json";
    }

    Map<String, String> fieldData = {
      '_method': "put",
      'project_id': project_id,
      'title': title,
      'description': description,
      'priority': priority,
      'due_date': due_date,
    };

    attachments.forEach((e) async {
      var multiPartFile = await http.MultipartFile.fromPath('attachments[]', e.path);

      request!.files.add(multiPartFile);
    });

    request.fields.addAll(fieldData);

    var response = await request.send();

    if (response.statusCode == 201 || response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      print("RESPONSE ${responseBody}");

      var data = jsonDecode(responseBody);

      Tasks value = Tasks.fromJson(data['data']);

      return ApiReturnValue(value: value, message: '');
    } else {
      String responseBody = await response.stream.bytesToString();
      print("RESPONSE ${responseBody}");

      var data = jsonDecode(responseBody);

      return ApiReturnValue(message: '${data['message']}');
    }

  }
}