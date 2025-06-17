part of '../pages.dart';

class TaskDetailPage extends StatefulWidget {
  final String token;
  final Tasks task;

  TaskDetailPage(this.token, this.task);

  @override
  State<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  TextEditingController taskTitleC = TextEditingController();
  TextEditingController dueDateC = TextEditingController();
  TextEditingController assignToC = TextEditingController();
  TextEditingController descriptionC = TextEditingController();
  TextEditingController linkC = TextEditingController();

  bool isAgree = false;

  List<String> menuEvents = [
    "To Do",
    "In Progress",
    "Done",
  ];

  String selectedMenu = "To Do";


  List<TaskInfo>? _tasks;
  late List<ItemHolder> _items;
  late bool _showContent;
  late bool _permissionReady;
  late bool _saveInPublicStorage;
  late String _localPath;

  @override
  void dispose() {
    _unbindBackgroundIsolate();
    super.dispose();
  }

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
  void initState() {
    super.initState();
    context.read<TaskDetailCubit>().getTaskDetail(widget.token, "${widget.task.id}");

    if(widget.task.status == "todo"){
      selectedMenu = menuEvents[0];
    }

    if(widget.task.status == "in_progress"){
      selectedMenu = menuEvents[1];
    }

    if(widget.task.status == "done"){
      selectedMenu = menuEvents[2];
    }

    FlutterDownloader.registerCallback(downloadCallback, step: 1);

    _showContent = false;
    _permissionReady = false;
    _saveInPublicStorage = false;

    _prepare();
  }

  @override
  Widget build(BuildContext context) {
    double defaultWidth = MediaQuery.of(context).size.width - 2*defaultMargin2;
    double itemWidth = MediaQuery.of(context).size.width - 2*defaultMargin3;
    double fullWidth = MediaQuery.of(context).size.width;

    return GeneralPage(
      statusBarColor: mainColor,
      isBackInvert: false,
      isFrontAppBar: true,
      marginAppBar: 65,
      title: "${widget.task.title}",
      onBackButtonPressed: (){
        Get.back();
      },
      appBarColor: Colors.white,
      child: BlocBuilder<TaskDetailCubit, TaskDetailState>(
          builder: (context, state) => (state is TaskDetailLoaded) ? (state.data != null) ? Container(
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
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                PopupMenuButton<String>(
                                  padding: EdgeInsets.all(0),
                                  icon: statusCard(selectedMenu),
                                  initialValue: selectedMenu,
                                  onSelected: (String selected) async {
                                    setState(() {
                                      selectedMenu = selected;
                                    });

                                    String? finalData;

                                    if(selectedMenu == menuEvents[0]){
                                      finalData = "todo";
                                    }

                                    if(selectedMenu == menuEvents[1]){
                                      finalData = "in_progress";
                                    }

                                    if(selectedMenu == menuEvents[2]){
                                      finalData = "done";
                                    }

                                    await TaskServices.updateStatus(widget.token, "${widget.task.id}", finalData!).then((result) async {

                                      if(result != null && result.value != null){

                                        Fluttertoast.showToast(
                                            msg: "success_submit".trans(context),
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.green,
                                            textColor: Colors.white,
                                            fontSize: 16.0
                                        );

                                        await context.read<TaskCubit>().getTask(widget.token);
                                        await context.read<TaskDetailCubit>().getTaskDetail(widget.token, "${widget.task.id}");

                                      } else {
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
                                  },
                                  itemBuilder: (BuildContext context) {
                                    return menuEvents.map((String choice) {
                                      return PopupMenuItem<String>(
                                        value: choice,
                                        child: Text(choice),
                                      );
                                    }).toList();
                                  },
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(Icons.remove_red_eye_outlined, size: 20, color: mainColor),
                                      SizedBox(width: 12),
                                      Icon(Icons.more_vert_outlined, size: 20, color: mainColor),
                                    ]
                                ),
                              ]
                          ),
                          SizedBox(height: 16),
                          BlocBuilder<UserCubit, UserState>(
                              builder: (context, state) => (state is UserLoaded) ? (state.user != null) ? Container(
                                  width: fullWidth - 2*15,
                                  padding: EdgeInsets.symmetric(vertical: 10.5, horizontal: 12),
                                  alignment: Alignment.centerLeft,
                                  decoration: BoxDecoration(
                                    color: "F9FAFB".toColor(),
                                    border: Border.all(color: "EAECF0".toColor()),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 52,
                                        height: 52,
                                        decoration: BoxDecoration(
                                            color: CupertinoColors.systemGrey2,
                                            borderRadius: BorderRadius.circular(16),
                                            border: Border.all(color: mainColor),
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: CachedNetworkImageProvider("${state.user!.avatar!}")
                                            )
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${state.user!.first_name} ${state.user!.last_name}",
                                            textAlign: TextAlign.start,
                                            style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            "${state.user!.employee!.designation!.name}",
                                            textAlign: TextAlign.start,
                                            style: blackFontStyle.copyWith(fontSize: 12, color: mainColor, fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                              ) : SizedBox() : loadingIndicator
                          ),
                          SizedBox(height: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "due_date".trans(context),
                                textAlign: TextAlign.start,
                                style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                              ),
                              SizedBox(height: 5),
                              Row(
                                  children: [
                                    Icon(Icons.date_range, size: 18, color: mainColor ),
                                    SizedBox(width: 5),
                                    Text(
                                      "${state.data!.due_date}",
                                      textAlign: TextAlign.start,
                                      style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w600),
                                    ),
                                  ]
                              )
                            ],
                          ),
                          SizedBox(height: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "priority".trans(context),
                                textAlign: TextAlign.start,
                                style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                              ),
                              SizedBox(height: 5),
                              Row(
                                  children: [
                                    Icon(Icons.layers_outlined, size: 18, color: mainColor ),
                                    SizedBox(width: 5),
                                    Text(
                                      "${state.data!.priority}",
                                      textAlign: TextAlign.start,
                                      style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w600),
                                    ),
                                  ]
                              )
                            ],
                          ),
                          SizedBox(height: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "assign_to".trans(context),
                                textAlign: TextAlign.start,
                                style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                              ),
                              SizedBox(height: 5),
                              Row(
                                  children: [
                                    (state.data!.assignees![0].avatar != null && state.data!.assignees![0].avatar != "") ? Container(
                                      width: 38,
                                      height: 38,
                                      decoration: BoxDecoration(
                                          color: CupertinoColors.systemGrey2,
                                          borderRadius: BorderRadius.circular(30),
                                          border: Border.all(color: mainColor),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: CachedNetworkImageProvider("${state.data!.assignees![0].avatar}")
                                          )
                                      ),
                                    ) : Container(
                                      width: 38,
                                      height: 38,
                                      decoration: BoxDecoration(
                                          color: CupertinoColors.systemGrey2,
                                          borderRadius: BorderRadius.circular(30),
                                          border: Border.all(color: mainColor),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage("${prefixImages}img_avatar_dummy.png")
                                          )
                                      ),
                                    ),
                                    SizedBox(width: 12),
                                    Text(
                                      "${state.data!.assignees![0].name} - ${state.data!.assignees![0].designation}",
                                      textAlign: TextAlign.start,
                                      style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                                    ),
                                  ]
                              )
                            ],
                          ),
                          SizedBox(height: 16),
                          FormWithLabelCard(
                              outerLabelText: "task_description".trans(context),
                              hintText: "",
                              initialText: "${state.data!.description ?? ""}",
                              readOnly: true,
                              inputType: TextInputType.multiline,
                              maxLines: 10,
                              minLines: 6,
                              filled: true),
                          SizedBox(height: 16),
                          Container(
                            width: defaultWidth - 2*defaultMargin3,
                            alignment: Alignment.centerLeft,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "attachment".trans(context),
                                    textAlign: TextAlign.start,
                                    style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(height: 3),
                                  Text(
                                    "download_file".trans(context),
                                    textAlign: TextAlign.start,
                                    style: greyFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                                  ),
                                ]
                            ),
                          ),
                          SizedBox(height: 15),
                          (state.data!.attachments != null) ? Container(
                              width: defaultWidth - 2*defaultMargin3,
                            child: Wrap(
                              alignment: WrapAlignment.start,
                              spacing: 15,
                              runSpacing: 15,
                              children: state.data!.attachments!.map((e) => InkWell(
                                  onTap: () async {
                                    Get.to(FullPhoto(url: "${e.file_path}"));
                                  },
                                  child: Container(
                                    width: (defaultWidth - 2*defaultMargin3)/3 - 10,
                                    height: (defaultWidth - 2*defaultMargin3)/3 - 10,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: CachedNetworkImageProvider("${e.file_path}")
                                        )
                                    ),
                                  )
                              )).toList(),
                            )
                          ) : SizedBox(),
                        ],
                      )
                  ),
                  SizedBox(height: 60),
                ],
              )
          ) : SizedBox() : loadingIndicator
      ),
    );
  }


  Future<bool> _checkPermission() async {
    if (Platform.isIOS) {
      return true;
    }

    if (Platform.isAndroid) {
      // final info = await DeviceInfoPlugin().androidInfo;
      // if (info.version.sdkInt > 28) {
      //   return true;
      // }

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

    var status = await Permission.storage.status;

    if (status.isDenied) {
      Fluttertoast.showToast(
          msg: "Error when saving file",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
    if (await Permission.storage.isRestricted) {
      Fluttertoast.showToast(
          msg: "Error when saving file",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }

    var directory = Directory('/storage/emulated/0/Download');

    task.taskId = await FlutterDownloader.enqueue(
      url: task.link!,
      headers: {'Authorization': 'Bearer ${widget.token}'},
      savedDir: directory.path,
      saveInPublicStorage: _saveInPublicStorage,
    );
  }

  Widget statusCard(String status){
    Color color = "47C28B".toColor();

    if(status == "Done"){
      color = "47C28B".toColor();
    }

    if(status == "To Do"){
      color = "7A5AF8".toColor();
    }

    if(status == "In Progress"){
      color = "F79009".toColor();
    }

    return Container(
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "${status}",
            textAlign: TextAlign.start,
            style: blackFontStyle.copyWith(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w600),
          ),
          SizedBox(width: 12),
          Icon(Icons.keyboard_arrow_down_sharp, size: 14, color: Colors.white )
        ]
      ),
    );
  }

}
