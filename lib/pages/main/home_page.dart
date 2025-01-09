part of '../pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    double defaultWidth = MediaQuery.of(context).size.width - 2*defaultMargin2;
    double fullWidth = MediaQuery.of(context).size.width;

    return GeneralPage(
      title: "",
      heightAppBar: 240,
      appBarColor: mainColor,
      backColor: "F1F3F8".toColor(),
      appBarColorGradient: backgroundGradient,
      isAppBarCircular: true,
      child: Column(
        children: [
          Container(
            width: defaultWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("${prefixImages}img_avatar_dummy.png")
                        )
                      ),
                    ),
                    SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Adam Sudjana",
                          textAlign: TextAlign.start,
                          style: blackFontStyle.copyWith(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "Graphic Design",
                          textAlign: TextAlign.start,
                          style: blackFontStyle.copyWith(fontSize: 13, color: Colors.white, fontWeight: FontWeight.w400),
                        ),
                      ],
                    )
                  ],
                ),
                InkWell(
                  onTap: (){
                    Get.to(NotificationPage());
                  },
                  child: SvgPicture.asset("${prefixIcons}ic_notification.svg", height: 36, width: 36),
                )
              ],
            ),
          ),
          SizedBox(height: 20),
          WorkingCard("", defaultWidth),
          SizedBox(height: 16),
          Container(
            width: defaultWidth,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 12),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MenuCard((defaultWidth - 2*12)/3, "Attendance Log", "ic_attendance.svg", onTap: (result){
                      Get.to(AttendantHistoryPage());
                    }),
                    MenuCard((defaultWidth - 2*12)/3, "Leave Request", "ic_leave.svg", onTap: (result){
                      Get.to(LeavePage());
                    }),
                    MenuCard((defaultWidth - 2*12)/3, "Overtime Request", "ic_overtime.svg", onTap: (result){
                      Get.to(OvertimePage());
                    }),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MenuCard((defaultWidth - 2*12)/3, "Reimbursement Request", "ic_reimbursement.svg", onTap: (result){
                      Get.to(ReimbursePage());
                    },),
                    MenuCard((defaultWidth - 2*12)/3, "Calendar", "ic_calendar_home.svg", onTap: (result){
                      Get.to(CalendarPage());
                    },),
                    MenuCard((defaultWidth - 2*12)/3, "Payslip", "ic_payslip.svg", onTap: (result){
                      Get.to(PayslipHistoryPage());
                    },),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          GraphCard(defaultWidth),
          SizedBox(height: 50),
        ],
      ),
    );
  }
}
