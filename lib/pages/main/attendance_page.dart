part of '../pages.dart';

class AttendancePage extends StatefulWidget {
  final String token;
  final String employee_id;

  AttendancePage(this.token, this.employee_id);

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {

  Future<void> getDataAttendance() async {
    // 2025-02-24
    DateTime now = DateTime.now();
    String formattedDate = intl.DateFormat('yyyy-MM').format(now);

    String startDate = "${formattedDate}-01";
    String endDate = "${formattedDate}-31";

    if(widget.employee_id != null){
      await context.read<AttendanceHistoryCubit>().getAttendanceHistory(widget.token, widget.employee_id, startDate, endDate);
    } else {

    }
  }

  @override
  void initState() {
    context.read<UserCubit>().getProfile(widget.token);

    getDataAttendance();



    super.initState();
  }

  Future<List<String?>> getDataShared(String employee_id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd MMMM yyyy').format(now);

    var dateBefore = await prefs.getString('date');
    String? clockin;
    String? clockout;

    ApiReturnValue<Attendant> result = await AttendanceServices.getEmployeeHistory(widget.token, employee_id, formattedDate, formattedDate);

    if(result != null && result.value != null) {
      if (result.value!.attendance_records != null &&
          result.value!.attendance_records!.isNotEmpty) {
        if (result.value!.attendance_records![0].clock_in != null) {
          clockin =
              result.value!.attendance_records![0].clock_in!;
        }

        if (result.value!.attendance_records![0].clock_out != null) {
          clockin =
              result.value!.attendance_records![0].clock_out!;
        }
      }
    }

    return [clockin, clockout];
  }

  @override
  Widget build(BuildContext context) {
    double defaultWidth = MediaQuery.of(context).size.width - 2*defaultMargin2;
    double fullWidth = MediaQuery.of(context).size.width;

    return GeneralPage(
      title: "",
      appBarColor: mainColor,
      appBarColorGradient: backgroundGradient,
      isAppBarCircular: true,
      heightAppBar: 210,
      backColor: "F1F3F8".toColor(),
      child: Column(
        children: [
          Container(
            width: defaultWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "lets_clockin".trans(context),
                      textAlign: TextAlign.start,
                      style: blackFontStyle.copyWith(fontSize: 24, color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "sub_lets_clockin".trans(context),
                      textAlign: TextAlign.start,
                      style: blackFontStyle.copyWith(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("${prefixImages}img_header_attendance.png")
                      )
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 10),
          BlocBuilder<UserCubit, UserState>(
              builder: (context, state) => (state is UserLoaded) ? (state.user != null) ? FutureBuilder(
                  future: getDataShared("${state.user!.employee!.employee_id}"),
                  builder: (context, snapshot) {
                    if(snapshot.connectionState == ConnectionState.done){
                      return WorkingCard(widget.token, defaultWidth, clockin: snapshot.data![0], clockout: snapshot.data![1],);
                    } else {
                      return loadingIndicator;
                    }
                  }
              ) : SizedBox() : loadingIndicator
          ),
          SizedBox(height: 20),
          BlocBuilder<AttendanceHistoryCubit, AttendanceHistoryState>(
              builder: (context, state) => (state is AttendanceHistoryLoaded) ? (state.data != null && state.data!.attendance_records != null && state.data!.attendance_records!.isNotEmpty) ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: defaultWidth,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "history_of_work".trans(context),
                              textAlign: TextAlign.start,
                              style: blackFontStyle.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            InkWell(
                              onTap: (){
                                Get.to(AttendantHistoryPage(widget.token, "${widget.employee_id}"));
                              },
                              child: Text(
                                "see_more".trans(context),
                                textAlign: TextAlign.end,
                                style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w600, color: mainColor),
                              ),
                            )
                          ]
                      ),
                    ),
                    SizedBox(height: 15),
                    Column(
                        children: state.data!.attendance_records!.map((e) {

                          String? _hoursString;

                          if(e.clock_out != null){
                            var clockin_temp = e.clock_in!.split(":");
                            double hours = double.parse(clockin_temp[0]);
                            double minutes = double.parse(clockin_temp[1]);
                            double seconds = double.parse(clockin_temp[2]);

                            var timeHehe = e.clock_out!.split(":");
                            double hours_ = double.parse(timeHehe[0]);
                            double minutes_ = double.parse(timeHehe[1]);
                            double seconds_ = double.parse(timeHehe[2]);

                            double fixHours = hours_ - hours;
                            double fixMinutes = minutes_ - minutes;
                            double fixSeconds = seconds_ - seconds;

                            _hoursString = "${(fixHours > 9) ? fixHours.toStringAsFixed(0) : "0${fixHours.toStringAsFixed(0)}"}:${(fixMinutes < 0) ? "00" : ((fixMinutes > 9) ? fixMinutes.toStringAsFixed(0) : "0${fixMinutes.toStringAsFixed(0)}")}:${(fixSeconds < 0) ? "00" : ((fixSeconds > 9) ? fixSeconds.toStringAsFixed(0) : "0${fixSeconds.toStringAsFixed(0)}")}";
                          }

                          DateTime appliedDate = new DateFormat("yyyy-MM-dd").parse(e.date ?? "");
                          String applied_date = DateFormat("dd MMMM yyyy").format(appliedDate);

                          return AttendantCard(widget.token, e, defaultWidth, date: applied_date, total_hours: _hoursString, clock_in: e.clock_in, clock_out: e.clock_out);
                        }).toList()
                    )
                  ]
              ) : Container(
                width: defaultWidth,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "no_working".trans(context),
                        textAlign: TextAlign.start,
                        style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "desc_working".trans(context),
                        textAlign: TextAlign.start,
                        style: greyFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(height: 140),
                    ]
                ),
              ) : Container(
                width: defaultWidth,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "no_working".trans(context),
                        textAlign: TextAlign.start,
                        style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "desc_working".trans(context),
                        textAlign: TextAlign.start,
                        style: greyFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(height: 140),
                    ]
                ),
              )
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }
}
