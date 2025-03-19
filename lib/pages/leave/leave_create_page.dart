part of '../pages.dart';

class LeaveCreatePage extends StatefulWidget {
  final String token;

  LeaveCreatePage(this.token);

  @override
  State<LeaveCreatePage> createState() => _LeaveCreatePageState();
}

class _LeaveCreatePageState extends State<LeaveCreatePage> {
  TextEditingController categoryC = TextEditingController();
  TextEditingController durationC = TextEditingController();
  TextEditingController delegationC = TextEditingController();
  TextEditingController descriptionC = TextEditingController();
  TextEditingController phoneC = TextEditingController();

  bool isLoading = false;
  bool isAgree = false;

  String? selectedLeaveCategory;
  List<String>? selectedDuration;

  @override
  Widget build(BuildContext context) {
    double defaultWidth = MediaQuery.of(context).size.width - 2*defaultMargin2;
    double itemWidth = MediaQuery.of(context).size.width - 2*defaultMargin3;
    double fullWidth = MediaQuery.of(context).size.width;

    return LoadingOverlay(
        progressIndicator: loadingIndicator,
        isLoading: isLoading,
      child: GeneralPage(
        statusBarColor: mainColor,
        isBackInvert: false,
        isFrontAppBar: true,
        marginAppBar: 65,
        title: "submit_leave".trans(context),
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
                          "fill_leave".trans(context),
                          textAlign: TextAlign.start,
                          style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 3),
                        Text(
                          "information_leave".trans(context),
                          textAlign: TextAlign.start,
                          style: greyFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(height: 15),
                        FormWithLabelCard(
                            outerLabelText: "leave_category".trans(context),
                            hintText: "select_category".trans(context),
                            controller: categoryC,
                            prefixSvg: "${prefixIcons}ic_form_title.svg",
                            onSaved: (e) {
                              categoryC.text = e ?? "";
                            },
                            readOnly: true,
                            onTap: (){
                              modalBottomSheetCategory(context, widget.token);
                            },
                            validator: (e) {
                              return simpleValidator(e, null);
                            },
                            filled: true),
                        SizedBox(height: 20),
                        FormWithLabelCard(
                            outerLabelText: "leave_duration".trans(context),
                            hintText: "select_duration".trans(context),
                            controller: durationC,
                            prefixSvg: "${prefixIcons}ic_form_date.svg",
                            onSaved: (e) {
                              durationC.text = e ?? "";
                            },
                            readOnly: true,
                            onTap: (){
                              modalBottomSheetCalendar(context, widget.token);
                            },
                            validator: (e) {
                              return simpleValidator(e, null);
                            },
                            filled: true),
                        SizedBox(height: 20),
                        FormWithLabelCard(
                            outerLabelText: "task_delegation".trans(context),
                            hintText: "input_task".trans(context),
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
                            outerLabelText: "phone_number".trans(context),
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
                            outerLabelText: "leave_desc".trans(context),
                            hintText: "leave_desc".trans(context),
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
                        SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
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
          child: ButtonCard("submit".trans(context), defaultWidth - 2*24, mainColor, colorGradient: buttonGradient, onPressed: () async {
            if(selectedLeaveCategory != null && selectedDuration != null && descriptionC.text.isNotEmpty){
              modalBottomSheet(context, widget.token);
            }

          }),
        ),
      )
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
          return ModalDefaultSubmitCard(token, fullWidth, 16, "ready_submit".trans(context), "double_check_form".trans(context), "img_leave.png", onSubmit: () async {

            if(selectedLeaveCategory != null && selectedDuration != null && descriptionC.text.isNotEmpty){
              setState(() {
                isLoading = true;
              });

              await LeaveServices.submitLeaves(widget.token, "1", "${selectedLeaveCategory}", selectedDuration![0], selectedDuration![1], descriptionC.text, phoneC.text, "").then((result) {

                if(result != null && result.value != null){

                  setState(() {
                    isLoading = false;
                  });

                  Fluttertoast.showToast(
                      msg: "success_submit".trans(context),
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 16.0
                  );

                  Get.to(LeavePage(widget.token));

                } else {
                  setState(() {
                    isLoading = false;
                  });

                  Fluttertoast.showToast(
                      msg: "${result.message}",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0
                  );
                }


              });
            }

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
          return ModalLeaveCalendarCard(token, fullWidth, 16, onSelected: (result){
            setState((){
              selectedDuration = result;
              durationC.text = "${result[0]} - ${result[1]}";
            });
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
          return ModalLeaveCategoryCard(token, fullWidth, 16, onSelected: (result){
            setState((){
              selectedLeaveCategory = result[0];
              categoryC.text = result[1];
            });
          });
        });
  }

}
