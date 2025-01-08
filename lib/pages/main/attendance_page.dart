part of '../pages.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {

  List<List<String>> listData = [
    ["22 December 2024", "08:00:00", "09:00 AM", "05:00 PM"],
    ["21 December 2024", "08:00:00", "09:00 AM", "05:00 PM"],
    ["20 December 2024", "08:00:00", "09:00 AM", "05:00 PM"],
    ["19 December 2024", "08:00:00", "09:00 AM", "05:00 PM"],
  ];

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
                      "Let’s Clock-In!",
                      textAlign: TextAlign.start,
                      style: blackFontStyle.copyWith(fontSize: 24, color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Don’t miss your clock in schedule",
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
          WorkingCard("", defaultWidth),
          SizedBox(height: 20),
          (listData.isEmpty) ? Container(
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
                    "No Working Time Available",
                    textAlign: TextAlign.start,
                    style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "It looks like you don’t have any working time in this period. Don’t worry, this space will be updated as new working time submitted.",
                    textAlign: TextAlign.start,
                    style: greyFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 140),
                ]
            ),
          ) : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "History of Work",
                      textAlign: TextAlign.start,
                      style: blackFontStyle.copyWith(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    InkWell(
                      onTap: (){
                        Get.to(AttendantHistoryPage());
                      },
                      child: Text(
                        "See More",
                        textAlign: TextAlign.end,
                        style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w600, color: mainColor),
                      ),
                    )
                  ]
                ),
                SizedBox(height: 15),
                Column(
                  children: listData.map((e) => AttendantCard(defaultWidth, date: e[0], total_hours: e[1], clock_in: e[2], clock_out: e[3])).toList()
                ),
              ]
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }
}
