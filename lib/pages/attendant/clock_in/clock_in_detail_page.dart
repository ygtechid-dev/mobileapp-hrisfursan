part of '../../pages.dart';

class ClockInDetailPage extends StatefulWidget {
  final File fileImage;
  final String token;
  final String latitude;
  final String longitude;
  final String location;

  ClockInDetailPage(this.token, this.latitude, this.longitude, this.location, this.fileImage);

  @override
  State<ClockInDetailPage> createState() => _ClockInDetailPageState();
}

class _ClockInDetailPageState extends State<ClockInDetailPage> {
  TextEditingController noteC = TextEditingController();

  String? _timeString;

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    setState(() {
      _timeString = formattedDateTime;
    });
  }


  String _formatDateTime(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy h:mm a').format(dateTime);
  }

  @override
  void initState() {
    _timeString = _formatDateTime(DateTime.now());
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    super.initState();
  }

  Future<bool> _onWillPop() async {
    Get.to(MainPage(token: widget.token));
    return true;
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    double defaultWidth = MediaQuery.of(context).size.width - 2*defaultMargin2;
    double itemWidth = MediaQuery.of(context).size.width - 2*defaultMargin3;
    double fullWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
        onWillPop: _onWillPop,
      child: GeneralPage(
        statusBarColor: mainColor,
        isBackInvert: false,
        isFrontAppBar: true,
        marginAppBar: 65,
        title: "selfie_to".trans(context),
        onBackButtonPressed: (){
          Get.to(ClockInPage(widget.token));
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
                            height: 440,
                            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                            alignment: Alignment.bottomCenter,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    colorFilter: ColorFilter.mode(
                                      Colors.black.withOpacity(0.3),
                                      BlendMode.srcOver,
                                    ),
                                    image: FileImage(widget.fileImage)
                                )
                            ),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    width: (defaultWidth - 2*defaultMargin3) - 2*12,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Lat : ${widget.latitude}",
                                      textAlign: TextAlign.start,
                                      style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(height: 3),
                                  Container(
                                    width: (defaultWidth - 2*defaultMargin3) - 2*12,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Long :  ${widget.longitude}",
                                      textAlign: TextAlign.start,
                                      style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(height: 3),
                                  Container(
                                    width: (defaultWidth - 2*defaultMargin3) - 2*12,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "${_timeString} GMT +07:00",
                                      textAlign: TextAlign.start,
                                      style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  ButtonCard("retake".trans(context), (defaultWidth - 2*defaultMargin3) - 2*12, mainColor, iconData: Icons.sync, colorGradient: buttonGradient, onPressed: () async {
                                    Get.to(ClockInCameraPage(widget.token, "${widget!.latitude}", "${widget!.longitude}", widget.location));
                                  }),
                                ]
                            )
                        ),
                        SizedBox(height: 15),
                        FormWithLabelCard(
                            outerLabelText: "clockin_notes".trans(context),
                            hintText: "clockin_notes_hint".trans(context),
                            controller: noteC,
                            inputType: TextInputType.multiline,
                            maxLines: 6,
                            minLines: 6,
                            onSaved: (e) {
                              noteC.text = e ?? "";
                            },
                            validator: (e) {
                              return simpleValidator(e, null);
                            },
                            filled: true),
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
          child: ButtonCard("clock_in".trans(context), defaultWidth - 2*24, mainColor, isLoading: isLoading, colorGradient: buttonGradient, onPressed: () async {

            setState(() {
              isLoading = true;
            });

            await AttendanceServices.clockIn(widget.token, widget.location, widget.latitude, widget.longitude, widget.fileImage, noteC.text).then((result) async {

              if(result != null && result.value != null){

                DateTime now = DateTime.now();
                String formattedDate = DateFormat('dd MMMM yyyy').format(now);

                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setString('clockin', "${result.value!.attendance!.clock_in}");
                await prefs.setString('date', "${formattedDate}");
                await prefs.setString('employee_id', "${result.value!.attendance!.employee_id}");

                setState(() {
                  isLoading = false;
                });

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
      )
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
          return ModalClockInSuccessCard(token, fullWidth, 16);
        });
  }
}
