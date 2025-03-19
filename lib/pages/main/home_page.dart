part of '../pages.dart';

class HomePage extends StatefulWidget {
  final String token;


  HomePage(this.token);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
  }

  Future<List<String?>> getDataShared() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? clockin = await prefs.getString('clockin');
    String? clockout = await prefs.getString('clockout');

    return [clockin, clockout];
  }

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
                BlocBuilder<UserCubit, UserState>(
                    builder: (context, state) => (state is UserLoaded) ? (state.user != null) ? Row(
              children: [
                InkWell(
                  onTap: (){
                    modalBottomSheetTermination(context, "");
                  },
                  child: Container(
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
                ),
                SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${state.user!.first_name} ${state.user!.last_name}",
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
            ) : SizedBox() : loadingIndicator
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
          FutureBuilder(
              future: getDataShared(),
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.done){
                  return WorkingCard(widget.token, defaultWidth, clockin: snapshot.data![0], clockout: snapshot.data![1],);
                } else {
                  return loadingIndicator;
                }
              }
          ),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MenuCard((defaultWidth - 2*12)/3, "attendance_log".trans(context), "ic_attendance.svg", onTap: (){
                      Get.to(AttendantHistoryPage(widget.token));
                    }),
                    MenuCard((defaultWidth - 2*12)/3, "leave_request_alt".trans(context), "ic_leave.svg", onTap: (){
                      Get.to(LeavePage(widget.token));
                    }),
                    MenuCard((defaultWidth - 2*12)/3, "overtime_request".trans(context), "ic_overtime.svg", onTap: (){
                      Get.to(OvertimePage(widget.token));
                    }),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MenuCard((defaultWidth - 2*12)/3, "reimbursement_request".trans(context), "ic_reimbursement.svg", onTap: (){
                      Get.to(ReimbursePage());
                    },),
                    MenuCard((defaultWidth - 2*12)/3, "calendar".trans(context), "ic_calendar_home.svg", onTap: (){
                      Get.to(CalendarPage());
                    },),
                    MenuCard((defaultWidth - 2*12)/3, "payslip".trans(context), "ic_payslip.svg", onTap: (){
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

  void modalBottomSheetTermination(contexts, String token){
    double fullWidth = MediaQuery.of(context).size.width;

    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
        ),
        context: contexts,
        enableDrag: true,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (bc){
          return ModalTerminationCard(token, fullWidth, 16);
        });
  }


}
