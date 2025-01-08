part of '../pages.dart';

class AttendantDetailPage extends StatefulWidget {

  @override
  State<AttendantDetailPage> createState() => _AttendantDetailPageState();
}

class _AttendantDetailPageState extends State<AttendantDetailPage> {
  TextEditingController noteC = TextEditingController();

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
      title: "Details",
      onBackButtonPressed: (){
        Get.back();
      },
      appBarColor: Colors.white,
      child: Container(
          width: fullWidth,
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: defaultMargin2),
          alignment: Alignment.center,
          child: Column(
            children: [
              Container(
                  width: defaultWidth,
                  padding: EdgeInsets.symmetric(vertical: 24, horizontal: defaultMargin3),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Container(
                        width: defaultWidth - 2*defaultMargin3,
                        child: Row(
                            children: [
                              Icon(Icons.date_range, size: 14, color: mainColor),
                              SizedBox(width: 6),
                              Text(
                                "27 September 2024",
                                textAlign: TextAlign.start,
                                style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                              ),
                            ]
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                          width: defaultWidth - 2*defaultMargin3,
                          padding: EdgeInsets.symmetric(vertical: 10.5, horizontal: 12),
                          alignment: Alignment.topCenter,
                          decoration: BoxDecoration(
                            color: "F9FAFB".toColor(),
                            border: Border.all(color: "EAECF0".toColor()),
                            borderRadius: BorderRadius.vertical(top: Radius.circular(5)),
                          ),
                          child: Column(
                              children: [
                                Text(
                                  "Selfie Clock In",
                                  textAlign: TextAlign.center,
                                  style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                                ),
                                SizedBox(height: 10),
                                Container(
                                    width: (defaultWidth - 2*defaultMargin3) - 2*12,
                                    height: 440,
                                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                                    alignment: Alignment.bottomCenter,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage("${prefixImages}img_photo_dummy.png")
                                        )
                                    ),
                                    child: Column(
                                        children: [
                                          Container(
                                            width: (defaultWidth - 2*defaultMargin3) - 2*12,
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Lat : 45.43534",
                                              textAlign: TextAlign.start,
                                              style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.white),
                                            ),
                                          ),
                                          SizedBox(height: 3),
                                          Container(
                                            width: (defaultWidth - 2*defaultMargin3) - 2*12,
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Long : 97897.576",
                                              textAlign: TextAlign.start,
                                              style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.white),
                                            ),
                                          ),
                                          SizedBox(height: 3),
                                          Container(
                                            width: (defaultWidth - 2*defaultMargin3) - 2*12,
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "22/12/24 09:00AM GMT +07:00",
                                              textAlign: TextAlign.start,
                                              style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.white),
                                            ),
                                          ),
                                          SizedBox(height: 20),
                                          ButtonCard("Retake Photo", (defaultWidth - 2*defaultMargin3) - 2*12, mainColor, iconData: Icons.sync, colorGradient: buttonGradient, onPressed: () async {

                                          }),
                                        ]
                                    )
                                ),
                                SizedBox(height: 20),
                                Text(
                                  "Selfie Clock Out",
                                  textAlign: TextAlign.center,
                                  style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                                ),
                                SizedBox(height: 10),
                                Container(
                                    width: (defaultWidth - 2*defaultMargin3) - 2*12,
                                    height: 440,
                                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                                    alignment: Alignment.bottomCenter,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage("${prefixImages}img_photo_dummy.png")
                                        )
                                    ),
                                    child: Column(
                                        children: [
                                          Container(
                                            width: (defaultWidth - 2*defaultMargin3) - 2*12,
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Lat : 45.43534",
                                              textAlign: TextAlign.start,
                                              style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.white),
                                            ),
                                          ),
                                          SizedBox(height: 3),
                                          Container(
                                            width: (defaultWidth - 2*defaultMargin3) - 2*12,
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Long : 97897.576",
                                              textAlign: TextAlign.start,
                                              style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.white),
                                            ),
                                          ),
                                          SizedBox(height: 3),
                                          Container(
                                            width: (defaultWidth - 2*defaultMargin3) - 2*12,
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "22/12/24 09:00AM GMT +07:00",
                                              textAlign: TextAlign.start,
                                              style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.white),
                                            ),
                                          ),
                                          SizedBox(height: 20),
                                          ButtonCard("Retake Photo", (defaultWidth - 2*defaultMargin3) - 2*12, mainColor, iconData: Icons.sync, colorGradient: buttonGradient, onPressed: () async {

                                          }),
                                        ]
                                    )
                                ),
                                SizedBox(height: 20),
                                Container(
                                    width: (defaultWidth - 2*defaultMargin3) - 2*12,
                                  alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Clock-In Notes",
                                      textAlign: TextAlign.start,
                                      style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                                    ),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  width: (defaultWidth - 2*defaultMargin3) - 2*12,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "------",
                                    textAlign: TextAlign.start,
                                    style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Total Hours",
                                              textAlign: TextAlign.start,
                                              style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                                            ),
                                            Text(
                                              "08:00:00 hrs",
                                              textAlign: TextAlign.start,
                                              style: blackFontStyle.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
                                            ),
                                          ]
                                      ),
                                      Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Clock in & Out",
                                              textAlign: TextAlign.start,
                                              style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                                            ),
                                            Text(
                                              "09:00 AM — 05:00 PM",
                                              textAlign: TextAlign.start,
                                              style: blackFontStyle.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
                                            ),
                                          ]
                                      ),
                                    ]
                                )
                              ]
                          )
                      ),
                    ],
                  )
              ),
            ],
          )
      ),
      navBar: Container(
        width: fullWidth,
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: boxShadow
        ),
        child: ButtonCard("Export As PDF", defaultWidth - 2*24, mainColor, colorGradient: buttonGradient, onPressed: () async {
          modalBottomSheet(context, "");
        }),
      ),
    );
  }

  void modalBottomSheet(contexts, String token){
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
          return ModalExportPDFSuccessCard(token, fullWidth, 16);
        });
  }
}
