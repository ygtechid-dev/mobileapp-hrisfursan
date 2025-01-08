part of '../pages.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {

  List<EventData> listData = [
    EventData(
        state: "PayDay",
        title: "Happy PayDay!",
        desc: "all information about this you can ask HR Staff",
        date: "25 Des 2024",
        credit: "By Staff HR"
    )
  ];

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
      title: "Calendar",
      onBackButtonPressed: (){
        Get.back();
      },
      appBarColor: Colors.white,
      backColor: Colors.white,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: defaultMargin2),
            color: bcgPrimaryBlackColor,
            child: CalendarCard(),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: defaultMargin2),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            alignment: Alignment.center,
            child: Column(
              children: [
                Text(
                  "Events",
                  textAlign: TextAlign.start,
                  style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 3),
                Text(
                  "Events day in December",
                  textAlign: TextAlign.start,
                  style: greyFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 20),
                EventCard(defaultWidth, "Important Event", Colors.green, listData),
                SizedBox(height: 20),
                EventCard(defaultWidth, "Monhtly Event", Colors.blue, []),
              ]
            ),
          ),
        ]
      ),
    );
  }
}
