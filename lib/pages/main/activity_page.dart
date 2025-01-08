part of '../pages.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

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
                      "Activity",
                      textAlign: TextAlign.start,
                      style: blackFontStyle.copyWith(fontSize: 24, color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Choose your Requestment",
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
              ActivityCard(defaultWidth, "Workspace", "Summary of your work"),
              ActivityCard(defaultWidth, "Leave Request", "Request your off day", onTap: (result){
                Get.to(LeavePage());
              }),
              ActivityCard(defaultWidth, "Overtime Request", "Request to overtime work"),
              ActivityCard(defaultWidth, "Reimbursement Request", "Claim your expenses here"),
              ActivityCard(defaultWidth, "Calendar", "All Event are Here", onTap: (result){
                Get.to(CalendarPage());
              }),
              ActivityCard(defaultWidth, "Payslip", "Download and check your payslip", onTap: (result){
                Get.to(PayslipHistoryPage());
              }),
            ]
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }
}
