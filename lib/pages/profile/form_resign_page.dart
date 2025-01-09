part of "../pages.dart";

class FormResignPage extends StatefulWidget {
  const FormResignPage({super.key});

  @override
  State<FormResignPage> createState() => _FormResignPageState();
}

class _FormResignPageState extends State<FormResignPage> {
  TextEditingController categoryC = TextEditingController();
  TextEditingController dateC = TextEditingController();
  TextEditingController descriptionC = TextEditingController();
  TextEditingController amountC = TextEditingController();

  bool isAgree = false;

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
      title: "Form Resign",
      onBackButtonPressed: (){
        Get.back();
      },
      backColor: "F1F3F8".toColor(),
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
                      Text(
                        "Fill Information",
                        textAlign: TextAlign.start,
                        style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 3),
                      Text(
                        "Information about details",
                        textAlign: TextAlign.start,
                        style: greyFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(height: 20),
                      CommonDottedButtonWithImage2(title: "Upload Resign Document", subtitle: "Format should be in .pdf .jpeg .png less than 5MB", onPicked: (value){

                      }),
                      SizedBox(height: 20),
                      FormWithLabelCard(
                          outerLabelText: "Date of resignation application",
                          hintText: "Enter Date of resignation application",
                          controller: dateC,
                          prefixSvg: "${prefixIcons}ic_form_date.svg",
                          onSaved: (e) {
                            dateC.text = e ?? "";
                          },
                          onTap: (){
                            // modalBottomSheetCalendar(context, "");
                          },
                          validator: (e) {
                            return simpleValidator(e, null);
                          },
                          filled: true),
                      SizedBox(height: 20),
                      FormWithLabelCard(
                          outerLabelText: "Resign Description",
                          hintText: "Resign Description",
                          controller: descriptionC,
                          inputType: TextInputType.multiline,
                          maxLines: 6,
                          minLines: 6,
                          onSaved: (e) {
                            descriptionC.text = e ?? "";
                          },
                          validator: (e) {
                            return simpleValidator(e, null);
                          },
                          filled: true),
                      SizedBox(height: 40),
                    ],
                  )
              ),
              SizedBox(height: 20),
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
        child: ButtonCard("Submit", defaultWidth - 2*24, mainColor, colorGradient: buttonGradient, onPressed: () async {

        }),
      ),
    );
  }
}
