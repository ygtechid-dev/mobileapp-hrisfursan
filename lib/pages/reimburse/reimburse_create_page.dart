part of '../pages.dart';

class ReimburseCreatePage extends StatefulWidget {

  @override
  State<ReimburseCreatePage> createState() => _ReimburseCreatePageState();
}

class _ReimburseCreatePageState extends State<ReimburseCreatePage> {
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
      title: "Submit Expense",
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
                        "Fill Claim Information",
                        textAlign: TextAlign.start,
                        style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 3),
                      Text(
                        "Information about claim details",
                        textAlign: TextAlign.start,
                        style: greyFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(height: 20),
                      CommonDottedButtonWithImage2(title: "Upload Claim Document", subtitle: "Format should be in .pdf .jpeg .png less than 5MB", onPicked: (value){

                      }),
                      SizedBox(height: 20),
                      FormWithLabelCard(
                          outerLabelText: "Expense Category",
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
                          outerLabelText: "Transaction Date",
                          hintText: "Enter Date Transaction",
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
                          outerLabelText: "Expense Amount (IDR)",
                          hintText: "Enter Amount",
                          controller: amountC,
                          inputType: TextInputType.number,
                          prefixSvg: "${prefixIcons}ic_form_amount.svg",
                          onSaved: (e) {
                            amountC.text = e ?? "";
                          },
                          validator: (e) {
                            return simpleValidator(e, null);
                          },
                          filled: true),
                      SizedBox(height: 20),
                      FormWithLabelCard(
                          outerLabelText: "Expense Description",
                          hintText: "Expense Description",
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
          return ModalReimburseCategoryCard(token, fullWidth, 16);
        });
  }

}
