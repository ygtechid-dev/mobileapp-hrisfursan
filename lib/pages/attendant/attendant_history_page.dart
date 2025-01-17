part of '../pages.dart';

class AttendantHistoryPage extends StatefulWidget {
  const AttendantHistoryPage({super.key});

  @override
  State<AttendantHistoryPage> createState() => _AttendantHistoryPageState();
}

class _AttendantHistoryPageState extends State<AttendantHistoryPage> {
  TextEditingController searchController = TextEditingController();

  List<List<String>> listData = [
    ["22 December 2024", "08:00:00", "09:00 AM", "05:00 PM"],
    ["21 December 2024", "08:00:00", "09:00 AM", "05:00 PM"],
    ["20 December 2024", "08:00:00", "09:00 AM", "05:00 PM"],
    ["19 December 2024", "08:00:00", "09:00 AM", "05:00 PM"],
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
      title: "History of Work",
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
          Column(
              children: listData.map((e) => AttendantCard(defaultWidth, date: e[0], total_hours: e[1], clock_in: e[2], clock_out: e[3])).toList()
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
                    hintText: "Search",
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
