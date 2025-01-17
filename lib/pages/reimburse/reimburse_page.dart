part of '../pages.dart';

class ReimbursePage extends StatefulWidget {
  const ReimbursePage({super.key});

  @override
  State<ReimbursePage> createState() => _ReimbursePageState();
}

class _ReimbursePageState extends State<ReimbursePage> {

  List<List<String>> listData = [
    ["22 December 2024", "Kacamata", "Rp1.200.000", "Waiting Approval", "request"],
  ];

  List<List<String>> listData2 = [
    ["22 December 2024", "Kacamata", "Rp1.200.000", "Approved at 19 Sept 2024", "approved"],
    ["22 December 2024", "Kacamata", "Rp1.200.000", "Rejected at 22 Sept 2024", "rejected"],
  ];

  String selectedTab = "Request";
  String selectedMenu = "All Status";

  List<String> menuEvents = [
    "All Status",
    "Approve",
    "Reject",
  ];

  @override
  Widget build(BuildContext context) {
    double defaultWidth = MediaQuery.of(context).size.width - 2*defaultMargin2;
    double fullWidth = MediaQuery.of(context).size.width;

    return GeneralPage(
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
                    onTap: (){},
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
                  "Reimbursement",
                  textAlign: TextAlign.center,
                  style: blackFontStyle.copyWith(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600),
                ),
                SizedBox(width: 32,)
              ],
            ),
          ),
          SizedBox(height: 20),
          ReimburseSummaryCard("", defaultWidth),
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
                        "Request",
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
                              "Status",
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
          Column(
              children: [
                (selectedTab == "Request") ? (listData.isEmpty) ? Container(
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
                          "No Reimburse Submitted!",
                          textAlign: TextAlign.start,
                          style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Ready to catch some fresh air? Click “Reimbursement Request” and \ntake that well-deserved break!",
                          textAlign: TextAlign.start,
                          style: greyFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(height: 140),
                      ]
                  ),
                ) : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                          children: listData.map((e) => ReimburseItemCard(defaultWidth, date: e[0], typeData: e[1], value: e[2], status: e[3], type: e[4])).toList()
                      ),
                    ]
                ) : SizedBox(),
                (selectedTab == "Status") ? (listData2.isEmpty) ? Container(
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
                          "No Reimburse Submitted!",
                          textAlign: TextAlign.start,
                          style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Ready to catch some fresh air? Click “Reimbursement Request” and \ntake that well-deserved break!",
                          textAlign: TextAlign.start,
                          style: greyFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(height: 140),
                      ]
                  ),
                ) : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                          children: listData2.map((e) => ReimburseItemCard(defaultWidth, date: e[0], typeData: e[1], value: e[2], status: e[3], type: e[4])).toList()
                      ),
                    ]
                ) : SizedBox(),
              ]
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
        child: ButtonCard("Reimbursement Request", defaultWidth - 2*24, mainColor, colorGradient: buttonGradient, onPressed: () async {
          Get.to(ReimburseCreatePage());
        }),
      ),
    );
  }


}
