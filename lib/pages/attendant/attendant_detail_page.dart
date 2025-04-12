part of '../pages.dart';

class AttendantDetailPage extends StatefulWidget {
  final String token;
  final AttendantRecords records;

  AttendantDetailPage(this.token, this.records);

  @override
  State<AttendantDetailPage> createState() => _AttendantDetailPageState();
}

class _AttendantDetailPageState extends State<AttendantDetailPage> {
  TextEditingController noteC = TextEditingController();

  bool isLoading = false;

  List<TaskInfo>? _tasks;
  late List<ItemHolder> _items;
  late bool _showContent;
  late bool _permissionReady;
  late bool _saveInPublicStorage;
  late String _localPath;

  @override
  void initState() {
    super.initState();

    // _bindBackgroundIsolate();

    FlutterDownloader.registerCallback(downloadCallback, step: 1);

    _showContent = false;
    _permissionReady = false;
    _saveInPublicStorage = false;

    _prepare();
  }

  @override
  void dispose() {
    _unbindBackgroundIsolate();
    super.dispose();
  }

  // void _bindBackgroundIsolate() {
  //   final isSuccess = IsolateNameServer.registerPortWithName(
  //     _port.sendPort,
  //     'downloader_send_port',
  //   );
  //   if (!isSuccess) {
  //     _unbindBackgroundIsolate();
  //     _bindBackgroundIsolate();
  //     return;
  //   }
  //   _port.listen((dynamic data) {
  //     final taskId = (data as List<dynamic>)[0] as String;
  //     final status = DownloadTaskStatus.fromInt(data[1] as int);
  //     final progress = data[2] as int;
  //
  //     print(
  //       'Callback on UI isolate: '
  //           'task ($taskId) is in status ($status) and process ($progress)',
  //     );
  //
  //     if (_tasks != null && _tasks!.isNotEmpty) {
  //       final task = _tasks!.firstWhere((task) => task.taskId == taskId);
  //       setState(() {
  //         task
  //           ..status = status
  //           ..progress = progress;
  //       });
  //     }
  //   });
  // }

  void _unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  @pragma('vm:entry-point')
  static void downloadCallback(
      String id,
      int status,
      int progress,
      ) {
    print(
      'Callback on background isolate: '
          'task ($id) is in status ($status) and process ($progress)',
    );

    IsolateNameServer.lookupPortByName('downloader_send_port')
        ?.send([id, status, progress]);
  }

  @override
  Widget build(BuildContext context) {
    double defaultWidth = MediaQuery.of(context).size.width - 2*defaultMargin2;
    double itemWidth = MediaQuery.of(context).size.width - 2*defaultMargin3;
    double fullWidth = MediaQuery.of(context).size.width;

    DateTime appliedDate = new DateFormat("yyyy-MM-dd").parse(widget.records.date ?? "");
    String applied_date = DateFormat("dd MMMM yyyy").format(appliedDate);

    String? _hoursString;

    if(widget.records.clock_out != null){
      var clockin_temp = widget.records.clock_in!.split(":");
      double hours = double.parse(clockin_temp[0]);
      double minutes = double.parse(clockin_temp[1]);
      double seconds = double.parse(clockin_temp[2]);

      var timeHehe = widget.records.clock_out!.split(":");
      double hours_ = double.parse(timeHehe[0]);
      double minutes_ = double.parse(timeHehe[1]);
      double seconds_ = double.parse(timeHehe[2]);

      double fixHours = hours_ - hours;
      double fixMinutes = minutes_ - minutes;
      double fixSeconds = seconds_ - seconds;

      _hoursString = "${fixHours}:${fixMinutes}:${fixSeconds}";
    }

    return GeneralPage(
      statusBarColor: mainColor,
      isBackInvert: false,
      isFrontAppBar: true,
      marginAppBar: 65,
      title: "details".trans(context),
      onBackButtonPressed: (){
        Get.back();
      },
      appBarColor: Colors.white,
      child: Container(
          width: fullWidth,
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: defaultMargin2),
          alignment: Alignment.center,
          child: Column(
            children: [
              Container(
                  width: defaultWidth,
                  padding: EdgeInsets.symmetric(vertical: 24, horizontal: defaultMargin3),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Container(
                        width: defaultWidth - 2*defaultMargin3,
                        child: Row(
                            children: [
                              Icon(Icons.date_range, size: 18, color: mainColor),
                              SizedBox(width: 6),
                              Text(
                                "${applied_date}",
                                textAlign: TextAlign.start,
                                style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                              ),
                            ]
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                          width: defaultWidth - 2*defaultMargin3,
                          padding: EdgeInsets.symmetric(vertical: 10.5, horizontal: 12),
                          alignment: Alignment.topCenter,
                          decoration: BoxDecoration(
                            color: "F9FAFB".toColor(),
                            border: Border.all(color: "EAECF0".toColor()),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                              children: [
                                Text(
                                  "selfie_clockin".trans(context),
                                  textAlign: TextAlign.center,
                                  style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                                ),
                                SizedBox(height: 10),
                                Container(
                                    width: 225,
                                    height: 240,
                                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                                    alignment: Alignment.bottomCenter,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            colorFilter: ColorFilter.mode(
                                              Colors.black.withOpacity(0.3),
                                              BlendMode.srcOver,
                                            ),
                                            image: CachedNetworkImageProvider("${baseUrl2}${widget.records.clock_in_photo}")
                                        )
                                    ),
                                    child: Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            width: (defaultWidth - 2*defaultMargin3) - 2*12,
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Lat : ${widget.records.clock_in_latitude}",
                                              textAlign: TextAlign.start,
                                              style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.white),
                                            ),
                                          ),
                                          SizedBox(height: 3),
                                          Container(
                                            width: (defaultWidth - 2*defaultMargin3) - 2*12,
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Long : ${widget.records.clock_in_longitude}",
                                              textAlign: TextAlign.start,
                                              style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.white),
                                            ),
                                          ),
                                          SizedBox(height: 3),
                                          Container(
                                            width: (defaultWidth - 2*defaultMargin3) - 2*12,
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "${widget.records.clock_in_formatted} GMT ${DateTime.now().toUtc()}",
                                              textAlign: TextAlign.start,
                                              style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.white),
                                            ),
                                          ),
                                        ]
                                    )
                                ),
                                SizedBox(height: 20),
                                Text(
                                  "selfie_clockout".trans(context),
                                  textAlign: TextAlign.center,
                                  style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                                ),
                                SizedBox(height: 10),
                                Container(
                                    width: 225,
                                    height: 240,
                                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                                    alignment: Alignment.bottomCenter,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            colorFilter: ColorFilter.mode(
                                              Colors.black.withOpacity(0.3),
                                              BlendMode.srcOver,
                                            ),
                                            image: CachedNetworkImageProvider("${baseUrl2}${widget.records.clock_out_photo}")
                                        )
                                    ),
                                    child: Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            width: (defaultWidth - 2*defaultMargin3) - 2*12,
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Lat : ${widget.records.clock_out_latitude}",
                                              textAlign: TextAlign.start,
                                              style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.white),
                                            ),
                                          ),
                                          SizedBox(height: 3),
                                          Container(
                                            width: (defaultWidth - 2*defaultMargin3) - 2*12,
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Long : ${widget.records.clock_out_longitude}",
                                              textAlign: TextAlign.start,
                                              style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.white),
                                            ),
                                          ),
                                          SizedBox(height: 3),
                                          Container(
                                            width: (defaultWidth - 2*defaultMargin3) - 2*12,
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "${widget.records.clock_out_formatted} GMT +07:00",
                                              textAlign: TextAlign.start,
                                              style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.white),
                                            ),
                                          ),
                                        ]
                                    )
                                ),
                                SizedBox(height: 20),
                                Container(
                                    width: (defaultWidth - 2*defaultMargin3) - 2*12,
                                  alignment: Alignment.centerLeft,
                                    child: Text(
                                      "clockin_notes_hint".trans(context),
                                      textAlign: TextAlign.start,
                                      style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                                    ),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  width: (defaultWidth - 2*defaultMargin3) - 2*12,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "------",
                                    textAlign: TextAlign.start,
                                    style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "total_hours".trans(context),
                                              textAlign: TextAlign.start,
                                              style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                                            ),
                                            Text(
                                              "${_hoursString ?? "-"} hrs",
                                              textAlign: TextAlign.start,
                                              style: blackFontStyle.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
                                            ),
                                          ]
                                      ),
                                      Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "clockin_out".trans(context),
                                              textAlign: TextAlign.start,
                                              style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                                            ),
                                            Text(
                                              "${widget.records.clock_in} — ${widget.records.clock_out}",
                                              textAlign: TextAlign.start,
                                              style: blackFontStyle.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
                                            ),
                                          ]
                                      ),
                                    ]
                                )
                              ]
                          )
                      ),
                      SizedBox(height: 60),
                    ],
                  )
              ),
            ],
          )
      ),
      navBar: Container(
        width: fullWidth,
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: boxShadow
        ),
        child: ButtonCard("export_as_pdf".trans(context), defaultWidth - 2*24, mainColor, isLoading: isLoading, colorGradient: buttonGradient, onPressed: () async {
          setState(() {
            isLoading = true;
          });

          await AttendanceServices.getDownload(widget.token, "${widget.records!.id}").then((result) async {

            if(result != null && result.value != null){

              setState(() {
                isLoading = false;
              });

              TaskInfo task = TaskInfo(
                name: "${result.value!.filename}",
                link: "${result.value!.download_url}",
              );

              await _requestDownload(task);

              Fluttertoast.showToast(
                  msg: "${result.message}",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0
              );

              modalBottomSheet(context, widget.token);

            } else {
              setState(() {
                isLoading = false;
              });

              Fluttertoast.showToast(
                  msg: "${result.message}",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
            }
          });


        })
      ),
    );
  }

  Future<bool> _checkPermission() async {
    if (Platform.isIOS) {
      return true;
    }

    if (Platform.isAndroid) {

      final status = await Permission.storage.status;
      if (status == PermissionStatus.granted) {
        return true;
      }

      final result = await Permission.storage.request();
      return result == PermissionStatus.granted;
    }

    throw StateError('unknown platform');
  }

  Future<void> _prepare() async {
    final tasks = await FlutterDownloader.loadTasks();

    if (tasks == null) {
      print('No tasks were retrieved from the database.');
      return;
    }

    var count = 0;
    _tasks = [];
    _items = [];

    _items.add(ItemHolder(name: 'APKs'));
    for (var i = count; i < _tasks!.length; i++) {
      _items.add(ItemHolder(name: _tasks![i].name, task: _tasks![i]));
      count++;
    }

    for (final task in tasks) {
      for (final info in _tasks!) {
        if (info.link == task.url) {
          info
            ..taskId = task.taskId
            ..status = task.status
            ..progress = task.progress;
        }
      }
    }

    _permissionReady = await _checkPermission();
    if (_permissionReady) {
      await _prepareSaveDir();
    }

    setState(() {
      _showContent = true;
    });
  }

  Future<void> _prepareSaveDir() async {
    _localPath = (await _getSavedDir())!;
    final savedDir = Directory(_localPath);
    if (!savedDir.existsSync()) {
      await savedDir.create();
    }
  }

  Future<String?> _getSavedDir() async {
    String? externalStorageDirPath;
    externalStorageDirPath =
        (await getApplicationDocumentsDirectory()).absolute.path;

    return externalStorageDirPath;
  }

  Future<void> _requestDownload(TaskInfo task) async {
    task.taskId = await FlutterDownloader.enqueue(
      url: task.link!,
      headers: {'Authorization': 'Bearer ${widget.token}'},
      savedDir: _localPath,
      saveInPublicStorage: _saveInPublicStorage,
    );
  }

  void modalBottomSheet(contexts, String token){
    double fullWidth = MediaQuery.of(context).size.width;

    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
        ),
        context: contexts,
        enableDrag: true,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (bc){
          return ModalExportPDFSuccessCard(token, fullWidth, 16);
        });
  }
}

class TaskInfo {
  TaskInfo({this.name, this.link});

  final String? name;
  final String? link;

  String? taskId;
  int? progress = 0;
  DownloadTaskStatus? status = DownloadTaskStatus.undefined;
}

class ItemHolder {
  ItemHolder({this.name, this.task});

  final String? name;
  final TaskInfo? task;
}