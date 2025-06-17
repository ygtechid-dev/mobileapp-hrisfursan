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

    List<Tasks> taskTemp = [];

    await getListTask(token).then((dataTask) async {
      if(dataTask.value != null){
        taskTemp.addAll(dataTask.value!);
      }
    });

    print("${taskTemp}");

    List<Projects> listData = [];

    projects.forEach((item) async {

      if(taskTemp.where((e) => e.project_id == item.id).isNotEmpty) {
        List<Tasks> tempTasks = taskTemp.where((e) => e.project_id == item.id).toList();
        listData.add(item.copyWith(tasks: tempTasks));
      }

    });

    ProjectsCounts? project_counts;

    await getTaskCount(token).then((dataTaskCount) async {
      project_counts = dataTaskCount.value;
    });

    ProjectsSummary value = ProjectsSummary(projects: listData, project_counts: project_counts,);

    return ApiReturnValue(value: value);
  }

  static Future<ApiReturnValue<List<Tasks>>> getListTask(String token, {http.Client? client}) async {
    if (client == null) {
      client = http.Client();
    }

    String url = baseUrl + 'mobile/projects/all-task';

    var response = await client.get(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        });

    print("List Task " + response.body.toString());

    var data = jsonDecode(response.body);

    if (response.statusCode != 200) {
      return ApiReturnValue(message: 'Please Try Again');
    }

    List<Tasks> value = (data['data']["tasks"] as Iterable)
        .map((e) => Tasks.fromJson(e))
        .toList();

    return ApiReturnValue(value: value);
  }

  static Future<ApiReturnValue<ProjectsCounts>> getTaskCount(String token, {http.Client? client}) async {
    if (client == null) {
      client = http.Client();
    }

    String url = baseUrl + 'mobile/projects/all-task';

    var response = await client.get(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        });

    print("List Task " + response.body.toString());

    var data = jsonDecode(response.body);

    if (response.statusCode != 200) {
      return ApiReturnValue(message: 'Please Try Again');
    }

    ProjectsCounts value = ProjectsCounts.fromJson(data['data']["task_counts"]);

    return ApiReturnValue(value: value);
  }

  static Future<ApiReturnValue<List<Employee>>> getAssignee(String token, {http.Client? client}) async {
    if (client == null) {
      client = http.Client();
    }

    String url = baseUrl + 'mobile/projects/tasks/get-employees';

    var response = await client.get(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        });

    print("List Employee " + response.body.toString());

    var data = jsonDecode(response.body);

    if (response.statusCode != 200) {
      return ApiReturnValue(message: 'Please Try Again');
    }

    List<Employee> value = (data['data'] as Iterable)
        .map((e) => Employee.fromJson(e))
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
      String linkUrl,
      String assignee_id,
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
      'attachments[0][url]': linkUrl,
      'assigned[][id]': assignee_id
    };

    attachments.forEachIndexed((index, e) async {
      var multiPartFile = await http.MultipartFile.fromPath('attachments[${index}][file]', e.path);

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