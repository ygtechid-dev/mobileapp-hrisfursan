part of '../pages.dart';

class AttendantHistoryPage extends StatefulWidget {
  final String token;
  final String employee_id;

  AttendantHistoryPage(this.token, this.employee_id);

  @override
  State<AttendantHistoryPage> createState() => _AttendantHistoryPageState();
}

class _AttendantHistoryPageState extends State<AttendantHistoryPage> {
  TextEditingController searchController = TextEditingController();

  Future<void> getDataAttendance() async {
    // 2025-02-24
    DateTime now = DateTime.now();
    String formattedDate = intl.DateFormat('yyyy').format(now);
    int hehe = int.parse(formattedDate);
    String yearsAdded = "${hehe+1}";

    String startDate = "${formattedDate}-01-01";
    String endDate = "${yearsAdded}-12-31";

    if(widget.employee_id != null){
      await context.read<AttendanceHistoryCubit>().getAttendanceHistory(widget.token, widget.employee_id, startDate, endDate);
    }
  }

  @override
  void initState() {
    getDataAttendance();

    super.initState();
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
      title: "history_of_work".trans(context),
      onBackButtonPressed: (){
        Get.back();
      },
      backColor: "F1F3F8".toColor(),
      appBarColor: Colors.white,
      child: Column(
        children: [
          Container(
              width: fullWidth,
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: defaultMargin2),
              decoration: BoxDecoration(
                  color: Colors.white,
              ),
              alignment: Alignment.center,
              child: searchWidget(defaultWidth)
          ),
          SizedBox(height: 20),
          BlocBuilder<AttendanceHistoryCubit, AttendanceHistoryState>(
              builder: (context, state) => (state is AttendanceHistoryLoaded) ? (state.data != null && state.data!.attendance_records != null && state.data!.attendance_records!.isNotEmpty) ? Column(
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
              ) : loadingIndicator
          ),
        ],
      ),
    );
  }

  searchWidget(double width) {
    return Container(
      width: width,
      height: 50,
      decoration: BoxDecoration(
        color: greyColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
              child: TextField(
                textInputAction: TextInputAction.search,
                controller: searchController,
                onTap: (){

                },
                onChanged: (value) async {

                },
                onSubmitted: (value) async {
                  if(searchController.text.isNotEmpty){

                  }
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(0)),
                    hintText: "search".trans(context),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 6.0),
                      child: Icon(Icons.search, color: greyColor, size: 20),
                    ),
                    prefixStyle: greyFontStyle.copyWith(color: greyColor, fontSize: 12),
                    contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 12),
                    hintStyle: greyFontStyle.copyWith(color: greyColor, fontSize: 12)),
              ),
          ),
          Container(
            margin: EdgeInsets.only(right: 15),
            child: Icon(Icons.tune, size: 24, color: mainColor)
          ),
        ]
      ),
    );
  }
}
