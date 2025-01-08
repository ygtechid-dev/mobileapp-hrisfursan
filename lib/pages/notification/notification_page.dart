part of '../pages.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  TextEditingController searchController = TextEditingController();

  List<List<String>> listData = [
    ["Expense has been approved!", "Your expense has been been approved by HR, view expense report here", "img_notification.png", "05:00"],
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
      marginAppBar: 45,
      title: "Notification",
      onBackButtonPressed: (){
        Get.back();
      },
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
              children: listData.map((e) => NotificationCard(defaultWidth, e[0],  e[1], e[2],  e[3])).toList()
          ),
        ],
      ),
    );
  }

  searchWidget(double width) {
    return Container(
      width: width,
      height: 45,
      decoration: BoxDecoration(
        color: greyColor.withOpacity(0.4),
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
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Icon(Icons.search, color: blackColor, size: 16),
                    ),
                    prefixStyle: greyFontStyle.copyWith(color: Colors.grey, fontSize: 11),
                    contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    hintStyle: greyFontStyle.copyWith(color: Colors.grey, fontSize: 11)),
              ),
            ),
            Icon(Icons.tune, size: 24, color: mainColor)
          ]
      ),
    );
  }
}
