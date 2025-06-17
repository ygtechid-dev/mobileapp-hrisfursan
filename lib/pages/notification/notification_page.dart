part of '../pages.dart';

class NotificationPage extends StatefulWidget {
  final String token;

  NotificationPage(this.token);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    context.read<NotificationsCubit>().getNotifications(widget.token);

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
      title: "notification".trans(context),
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
          SizedBox(height: 10),
          BlocBuilder<NotificationsCubit, NotificationsState>(
              builder: (context, state) {
                if (state is NotificationsLoaded) {
                  if (state.data != null && state.data!.isNotEmpty) {
                    if(searchController.text.isNotEmpty){
                      return Column(
                          children: state.data!.where((data) => data.title!.contains(searchController.text) || data.description!.contains(searchController.text)).map((e) {
                            return NotificationCard(fullWidth, "${e.title}", "${e.description}", "img_notification.png", "${e.time}");
                          }).toList()
                      );
                    } else {
                      return Column(
                          children: state.data!.map((e) {
                            return NotificationCard(fullWidth, "${e.title}", "${e.description}", "img_notification.png", "${e.time}");
                          }).toList()
                      );
                    }

                  } else {
                    return SizedBox();
                  }
                } else {
                  return SizedBox();
                }
              }
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
                    hintText: "search".trans(context),
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
