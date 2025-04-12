part of '../pages.dart';

class CalendarPage extends StatefulWidget {
  final String token;

  CalendarPage(this.token);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {

  String? startDate;
  String? endDate;

  @override
  void initState() {
    context.read<EventsCubit>().getEvents(widget.token);

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
      title: "calendar".trans(context),
      onBackButtonPressed: (){
        Get.back();
      },
      appBarColor: Colors.white,
      backColor: Colors.white,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: 20, left: defaultMargin2, right: defaultMargin2),
            color: bcgPrimaryBlackColor,
            child: CalendarCard(onSelected: (value){
              setState((){
                startDate = value[0];
                endDate = value[1];
              });
            },),
          ),
          Container(
            color: bcgPrimaryBlackColor,
            padding: EdgeInsets.only(top: 20),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: defaultMargin2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              alignment: Alignment.center,
              child: BlocBuilder<EventsCubit, EventsState>(
                  builder: (context, state) => (state is EventsLoaded) ? (state.data != null && state.data!.isNotEmpty) ? Column(
                      children: [
                        SizedBox(height: 20),
                        Text(
                          "events".trans(context),
                          textAlign: TextAlign.start,
                          style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 3),
                        Text(
                          "events_day".trans(context),
                          textAlign: TextAlign.start,
                          style: greyFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(height: 20),
                        EventCard(defaultWidth, "events_important".trans(context), Colors.green, (startDate != null && endDate != null) ? state.data!.where((e) => e.priority == "high").where((e) => e.start == "${startDate}" || e.end == "${endDate}").toList() : state.data!.where((e) => e.priority == "high").toList()),
                        EventCard(defaultWidth, "events_monthly".trans(context), Colors.blue, (startDate != null && endDate != null) ? state.data!.where((e) => e.priority == "medium").where((e) => e.start == "${startDate}" || e.end == "${endDate}").toList() : state.data!.where((e) => e.priority == "medium").toList()),
                      ]
                  ) : SizedBox() : loadingIndicator
              ),
            ),
          )
        ]
      ),
    );
  }
}
