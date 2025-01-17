part of '../pages.dart';

class LeaveCreatePage extends StatefulWidget {

  @override
  State<LeaveCreatePage> createState() => _LeaveCreatePageState();
}

class _LeaveCreatePageState extends State<LeaveCreatePage> {
  TextEditingController categoryC = TextEditingController();
  TextEditingController durationC = TextEditingController();
  TextEditingController delegationC = TextEditingController();
  TextEditingController descriptionC = TextEditingController();
  TextEditingController phoneC = TextEditingController();

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
      title: "Submit Leave",
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Fill Leave Information",
                        textAlign: TextAlign.start,
                        style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 3),
                      Text(
                        "Information about leave details",
                        textAlign: TextAlign.start,
                        style: greyFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(height: 15),
                      FormWithLabelCard(
                          outerLabelText: "Leave Category",
                          hintText: "Select Category",
                          controller: categoryC,
                          prefixSvg: "${prefixIcons}ic_form_title.svg",
                          onSaved: (e) {
                            categoryC.text = e ?? "";
                          },
                          onTap: (){
                            modalBottomSheetCategory(context, "");
                          },
                          validator: (e) {
                            return simpleValidator(e, null);
                          },
                          filled: true),
                      SizedBox(height: 20),
                      FormWithLabelCard(
                          outerLabelText: "Leave Duration",
                          hintText: "Select Duration",
                          controller: durationC,
                          prefixSvg: "${prefixIcons}ic_form_date.svg",
                          onSaved: (e) {
                            durationC.text = e ?? "";
                          },
                          onTap: (){
                            modalBottomSheetCalendar(context, "");
                          },
                          validator: (e) {
                            return simpleValidator(e, null);
                          },
                          filled: true),
                      SizedBox(height: 20),
                      FormWithLabelCard(
                          outerLabelText: "Task Delegation",
                          hintText: "Select Category",
                          controller: delegationC,
                          prefixSvg: "${prefixIcons}ic_form_assign.svg",
                          onSaved: (e) {
                            delegationC.text = e ?? "";
                          },
                          validator: (e) {
                            return simpleValidator(e, null);
                          },
                          filled: true),
                      SizedBox(height: 20),
                      FormWithLabelCard(
                          outerLabelText: "Phone Number",
                          hintText: "+62 0000 0000 0000",
                          controller: phoneC,
                          inputType: TextInputType.number,
                          prefixSvg: "${prefixIcons}ic_phone.svg",
                          onSaved: (e) {
                            phoneC.text = e ?? "";
                          },
                          validator: (e) {
                            return phoneValidator(e, null);
                          },
                          filled: true),
                      SizedBox(height: 20),
                      FormWithLabelCard(
                          outerLabelText: "Leave Description",
                          hintText: "Leave Description",
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
          return ModalDefaultSubmitCard(token, fullWidth, 16, "Ready to Submit?", "Double-check your form details to ensure everything is correct. Do you want to proceed?", "img_leave.png", onSubmit: (){

          });
        });
  }

  void modalBottomSheetCalendar(contexts, String token){
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
          return ModalLeaveCalendarCard(token, fullWidth, 16);
        });
  }

  void modalBottomSheetCategory(contexts, String token){
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
          return ModalLeaveCategoryCard(token, fullWidth, 16);
        });
  }

}
