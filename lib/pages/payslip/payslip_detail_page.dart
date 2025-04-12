part of "../pages.dart";

class PayslipDetailPage extends StatefulWidget {
  final String token;
  final Payslip payslip;

  PayslipDetailPage(this.token, this.payslip);

  @override
  State<PayslipDetailPage> createState() => _PayslipDetailPageState();
}

class _PayslipDetailPageState extends State<PayslipDetailPage> {

  bool isLoading = false;

  @override
  void initState() {
    context.read<PayslipDetailCubit>().getPayslipDetail(widget.token, "${widget.payslip.id}");

    // _bindBackgroundIsolate();

    FlutterDownloader.registerCallback(downloadCallback, step: 1);

    _showContent = false;
    _permissionReady = false;
    _saveInPublicStorage = false;

    _prepare();

    super.initState();
  }


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
  Widget build(BuildContext context) {
    double defaultWidth = MediaQuery.of(context).size.width - 2*defaultMargin2;
    double itemWidth = MediaQuery.of(context).size.width - 2*defaultMargin3;
    double fullWidth = MediaQuery.of(context).size.width;

    return GeneralPage(
      statusBarColor: mainColor,
      isBackInvert: false,
      isFrontAppBar: true,
      marginAppBar: 72,
      title: "payslip".trans(context),
      onBackButtonPressed: (){
        Get.back();
      },
      backColor: "F1F3F8".toColor(),
      appBarColor: Colors.white,
      child: BlocBuilder<PayslipDetailCubit, PayslipDetailState>(
          builder: (context, state) {
            if (state is PayslipDetailLoaded) {
              if (state.data != null) {
                return Container(
                    width: fullWidth,
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: defaultMargin2),
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        PayslipSummaryCard(widget.token, defaultWidth, "${state.data!.total_working_hours ?? 0}:${state.data!.total_working_minutes ?? 0}", "${state.data!.total_overtime_hours ?? 0}:${state.data!.total_overtime_minutes ?? 0}"),
                        SizedBox(height: 20),
                        PayslipResumeCard(defaultWidth, state.data!),
                        SizedBox(height: 20),
                      ],
                    )
                );
              } else {
                return SizedBox();
              }
            } else {
              return loadingIndicator;
            }
          }
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

          await PayslipServices.getPayslipPdf(widget.token, "${widget.payslip!.id}").then((result) async {

            if(result != null && result.value != null){

              setState(() {
                isLoading = false;
              });

              TaskInfo task = TaskInfo(
                name: "${result.value!.file_name}",
                link: "${result.value!.file_url}",
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
        }),
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

