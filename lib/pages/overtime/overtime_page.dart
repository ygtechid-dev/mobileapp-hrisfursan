part of '../pages.dart';

class OvertimePage extends StatefulWidget {
  final String token;

  OvertimePage(this.token);

  @override
  State<OvertimePage> createState() => _OvertimePageState();
}

class _OvertimePageState extends State<OvertimePage> {

  List<List<String>> listData = [
    ["22 December 2024", "10 Nov 2024", "High", "Deadline", "Waiting Approval", "request"],
  ];

  List<List<String>> listData2 = [
    ["22 December 2024", "10 Nov 2024", "High", "Deadline", "Approved at 19 Sept 2024", "approved"],
    ["22 December 2024", "10 Nov 2024", "High", "Deadline", "Rejected at 22 Sept 2024", "rejected"],
  ];

  String selectedTab = "Request";
  String selectedMenu = "All Status";

  List<String> menuEvents = [
    "All Status",
    "Approve",
    "Reject",
  ];

  @override
  void initState() {
    context.read<OvertimesCubit>().getOvertimes(widget.token);
    super.initState();
  }

  Future<bool> _onWillPop() async {
    Get.back();
    return (kIsWeb) ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    double defaultWidth = MediaQuery.of(context).size.width - 2*defaultMargin2;
    double fullWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: _onWillPop,
      child: GeneralPage(
        appBarColor: mainColor,
        appBarColorGradient: backgroundGradient,
        isAppBarCircular: true,
        heightAppBar: 210,
        backColor: "F1F3F8".toColor(),
        title: "",
        child: Column(
          children: [
            Container(
              width: defaultWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: (){
                        Get.back();
                      },
                      child: Container(
                        height: 32,
                        width: 32,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.arrow_back_ios_new_outlined, color: mainColor, size: 20),
                      )
                  ),
                  Text(
                    "overtime_summary".trans(context),
                    textAlign: TextAlign.center,
                    style: blackFontStyle.copyWith(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(width: 32,)
                ],
              ),
            ),
            SizedBox(height: 20),
            OvertimeSummaryCard("", defaultWidth),
            SizedBox(height: 16),
            Container(
              width: defaultWidth,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
              ),
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: (){
                        setState((){
                          selectedTab = "Request";
                        });
                      },
                      child: Container(
                        width: defaultWidth/2-20,
                        decoration: BoxDecoration(
                          color: (selectedTab == "Request") ? mainColor : Colors.white,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                        child: Text(
                          "request".trans(context),
                          textAlign: TextAlign.center,
                          style: blackFontStyle.copyWith(fontSize: 12, color: (selectedTab == "Request") ? Colors.white : blackColor, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        setState((){
                          selectedTab = "Status";
                        });
                      },
                      child: Row(
                          children: [
                            Container(
                              width: (selectedTab == "Status") ? (defaultWidth/2-20 - 30) : (defaultWidth/2-20),
                              decoration: BoxDecoration(
                                color: (selectedTab == "Status") ? mainColor : Colors.white,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                              child: Text(
                                "status".trans(context),
                                textAlign: TextAlign.center,
                                style: blackFontStyle.copyWith(fontSize: 12, color: (selectedTab == "Status") ? Colors.white : blackColor, fontWeight: FontWeight.w600),
                              ),
                            ),
                            (selectedTab == "Status") ? Row(
                                children: [
                                  SizedBox(width: 10),
                                  PopupMenuButton<String>(
                                    padding: EdgeInsets.zero,
                                    icon: Icon(Icons.tune, size: 20, color: mainColor),
                                    onSelected: (String selected) async {
                                      setState(() {
                                        selectedMenu = selected;
                                      });
                                    },
                                    itemBuilder: (BuildContext context) {
                                      return menuEvents.map((String choice) {
                                        return PopupMenuItem<String>(
                                          value: choice,
                                          child: Text(choice, style: blackFontStyle.copyWith(fontSize: 10, color: (selectedMenu == choice) ? mainColor : blackColor, fontWeight: FontWeight.w400)),
                                        );
                                      }).toList();
                                    },
                                  ),
                                ]
                            ) : SizedBox()
                          ]
                      ),
                    ),

                  ]
              ),
            ),
            SizedBox(height: 16),
            BlocBuilder<OvertimesCubit, OvertimesState>(
                builder: (context, state) => (state is OvertimesLoaded) ? (state.data != null && state.data!.isNotEmpty) ? Column(
                    children: [
                      (selectedTab == "Request") ? (state.data!.where((e) => e.status == "pending").isEmpty) ? emptyBox(defaultWidth) : Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                                children: state.data!.where((e) => e.status == "pending")!.map((e) {
                                  var tempHaha = e.created_at!.split("T");
                                  String created_at = tempHaha[0];

                                  DateTime appliedDate = new DateFormat('yyyy-MM-dd').parse(created_at ?? "");
                                  String applied_date = DateFormat("dd MMMM yyyy").format(appliedDate);

                                  DateTime overtimeDate = new DateFormat("yyyy-MM-dd").parse(e.overtime_date ?? "");
                                  String overtime_date = DateFormat("dd MMMM yyyy").format(overtimeDate);

                                  return OvertimeItemCard(defaultWidth, date: applied_date, overtime_date: overtime_date, priority: "High", category: "Deadline", status: e.status);
                                }).toList()
                            ),
                          ]
                      ) : SizedBox(),
                      (selectedTab == "Status") ? (state.data!.where((e) => e.status != "pending").isEmpty) ? emptyBox(defaultWidth) : Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            (selectedMenu == "All Status") ? ((state.data!.where((e) => e.status != "pending").isEmpty) ? emptyBox(defaultWidth) : Column(
                                children: state.data!.where((e) => e.status != "pending").map((e) {

                                  var tempHaha = e.created_at!.split("T");
                                  String created_at = tempHaha[0];

                                  DateTime appliedDate = new DateFormat('yyyy-MM-dd').parse(created_at ?? "");
                                  String applied_date = DateFormat("dd MMMM yyyy").format(appliedDate);

                                  DateTime overtimeDate = new DateFormat("yyyy-MM-dd").parse(e.overtime_date ?? "");
                                  String overtime_date = DateFormat("dd MMMM yyyy").format(overtimeDate);

                                  String? approved_date;
                                  String? rejected_date;

                                  if(e.approved_at != null){
                                    DateTime approvedDate = new DateFormat("yyyy-MM-dd").parse(e.approved_at ?? "");
                                    approved_date = DateFormat("dd MMMM yyyy").format(approvedDate);
                                  }

                                  if(e.rejected_at != null){
                                    DateTime rejectedDate = new DateFormat("yyyy-MM-dd").parse(e.rejected_at ?? "");
                                    rejected_date = DateFormat("dd MMMM yyyy").format(rejectedDate);
                                  }

                                  return OvertimeItemCard(defaultWidth, date: applied_date, overtime_date: overtime_date, priority: "High", category: "Deadline", status: e.status, approved_at: approved_date, rejected_at: rejected_date);
                                }).toList()
                            )) : SizedBox(),
                            (selectedMenu == "Approve") ? ((state.data!.where((e) => e.status == "approved").isEmpty) ? emptyBox(defaultWidth) : Column(
                                children: state.data!.where((e) => e.status == "approved").map((e) {
                                  var tempHaha = e.created_at!.split("T");
                                  String created_at = tempHaha[0];

                                  DateTime appliedDate = new DateFormat('yyyy-MM-dd').parse(created_at ?? "");
                                  String applied_date = DateFormat("dd MMMM yyyy").format(appliedDate);

                                  DateTime overtimeDate = new DateFormat("yyyy-MM-dd").parse(e.overtime_date ?? "");
                                  String overtime_date = DateFormat("dd MMMM yyyy").format(overtimeDate);

                                  DateTime approvedDate = new DateFormat("yyyy-MM-dd").parse(e.approved_at ?? "");
                                  String approved_date = DateFormat("dd MMMM yyyy").format(approvedDate);

                                  return OvertimeItemCard(defaultWidth, date: applied_date, overtime_date: overtime_date, priority: "High", category: "Deadline", status: e.status, approved_at: approved_date,);
                                }).toList()
                            )) : SizedBox(),
                            (selectedMenu == "Reject") ? ((state.data!.where((e) => e.status == "rejected").isEmpty) ? emptyBox(defaultWidth) : Column(
                                children: state.data!.where((e) => e.status == "rejected").map((e) {
                                  var tempHaha = e.created_at!.split("T");
                                  String created_at = tempHaha[0];

                                  DateTime appliedDate = new DateFormat('yyyy-MM-dd').parse(created_at ?? "");
                                  String applied_date = DateFormat("dd MMMM yyyy").format(appliedDate);

                                  DateTime overtimeDate = new DateFormat("yyyy-MM-dd").parse(e.overtime_date ?? "");
                                  String overtime_date = DateFormat("dd MMMM yyyy").format(overtimeDate);

                                  DateTime rejectedDate = new DateFormat("yyyy-MM-dd").parse(e.rejected_at ?? "");
                                  String rejected_date = DateFormat("dd MMMM yyyy").format(rejectedDate);

                                  return OvertimeItemCard(defaultWidth, date: applied_date, overtime_date: overtime_date, priority: "High", category: "Deadline", status: e.status, rejected_at: rejected_date,);
                                }).toList()
                            )) : SizedBox(),
                          ]
                      ) : SizedBox(),
                    ]
                ) : SizedBox() : loadingIndicator
            ),
            SizedBox(height: 50),
          ],
        ),
        navBar: Container(
          width: fullWidth,
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: boxShadow
          ),
          child: ButtonCard("submit_overtime".trans(context), defaultWidth - 2*24, mainColor, colorGradient: buttonGradient, onPressed: () async {
            Get.to(OvertimeCreatePage(widget.token));
          }),
        ),
      )
    );
  }

  Widget emptyBox(width){
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "no_overtime".trans(context),
              textAlign: TextAlign.center,
              style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 5),
            Text(
              "ready_overtime".trans(context),
              textAlign: TextAlign.center,
              style: greyFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 140),
          ]
      ),
    );
  }

}
