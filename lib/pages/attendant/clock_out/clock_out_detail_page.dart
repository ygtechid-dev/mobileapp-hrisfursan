part of '../../pages.dart';

class ClockOutDetailPage extends StatefulWidget {
  final File fileImage;

  ClockOutDetailPage(this.fileImage);

  @override
  State<ClockOutDetailPage> createState() => _ClockOutDetailPageState();
}

class _ClockOutDetailPageState extends State<ClockOutDetailPage> {
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
      title: "Selfie To Clock Out",
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
                        height: 440,
                          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                        alignment: Alignment.bottomCenter,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(widget.fileImage)
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
                      SizedBox(height: 15),
                      FormWithLabelCard(
                          outerLabelText: "Clock Out Notes (Optional)",
                          hintText: "Clock-Out Notes",
                          controller: noteC,
                          inputType: TextInputType.multiline,
                          maxLines: 6,
                          minLines: 6,
                          onSaved: (e) {
                            noteC.text = e ?? "";
                          },
                          validator: (e) {
                            return simpleValidator(e, null);
                          },
                          filled: true),
                      SizedBox(height: 20),
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
        child: ButtonCard("Clock In", defaultWidth - 2*24, mainColor, colorGradient: buttonGradient, onPressed: () async {

        }),
      ),
    );
  }

  void modalBottomSheetForgot(contexts, String token){
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
          return ModalClockInSuccessCard(token, fullWidth, 16);
        });
  }
}
