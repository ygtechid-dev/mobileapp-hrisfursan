part of '../pages.dart';

class ActivityPage extends StatefulWidget {
  final String token;

  ActivityPage(this.token);

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  @override
  Widget build(BuildContext context) {
    double defaultWidth = MediaQuery.of(context).size.width - 2*defaultMargin2;
    double fullWidth = MediaQuery.of(context).size.width;

    return GeneralPage(
      title: "",
      heightAppBar: 210,
      appBarColor: mainColor,
      appBarColorGradient: backgroundGradient,
      backColor: "F1F3F8".toColor(),
      isAppBarCircular: true,
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
                      "activity".trans(context),
                      textAlign: TextAlign.start,
                      style: blackFontStyle.copyWith(fontSize: 24, color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "choose_requestment".trans(context),
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
                      image: AssetImage("${prefixImages}img_header_activity.png")
                    )
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 15),
          Column(
            children: [
              ActivityCard(defaultWidth, "analytics".trans(context), "sub_analytics".trans(context), onTap: (){
                Get.to(AnalyticsPage(widget.token));
              }),
              ActivityCard(defaultWidth, "leave_request".trans(context), "sub_leave_request".trans(context), onTap: (){
                Get.to(LeavePage(widget.token));
              }),
              ActivityCard(defaultWidth, "overtime_request".trans(context), "sub_overtime_request".trans(context), onTap: (){
                Get.to(OvertimePage(widget.token));
              }),
              ActivityCard(defaultWidth, "reimbursement_request".trans(context), "sub_reimbursement_request".trans(context), onTap: (){
                Get.to(ReimbursePage(widget.token));
              }),
              ActivityCard(defaultWidth, "calendar".trans(context), "sub_calendar".trans(context), onTap: (){
                Get.to(CalendarPage(widget.token));
              }),
              ActivityCard(defaultWidth, "payslip".trans(context), "sub_payslip".trans(context), onTap: (){
                Get.to(PayslipHistoryPage(widget.token));
              }),
            ]
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }
}
