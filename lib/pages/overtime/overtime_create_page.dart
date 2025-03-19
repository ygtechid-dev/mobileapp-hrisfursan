part of '../pages.dart';

class OvertimeCreatePage extends StatefulWidget {
  final String token;

  OvertimeCreatePage(this.token);

  @override
  State<OvertimeCreatePage> createState() => _OvertimeCreatePageState();
}

class _OvertimeCreatePageState extends State<OvertimeCreatePage> {
  TextEditingController categoryC = TextEditingController();
  TextEditingController timeStartC = TextEditingController();
  TextEditingController timeEndC = TextEditingController();
  TextEditingController dateC = TextEditingController();
  TextEditingController priorityC = TextEditingController();
  TextEditingController descriptionC = TextEditingController();
  TextEditingController phoneC = TextEditingController();

  String? selectedLeaveCategory;

  bool isAgree = false;
  bool isLoading = false;

  DateTime selectedDate = DateTime.now();
  TimeOfDay? selectedTime1 = TimeOfDay.now();
  TimeOfDay? selectedTime2 = TimeOfDay.now();


  Future<void> _selectDate(BuildContext context) async {

    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1980, 8),
        lastDate: DateTime(2040),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: mainColor, // header background color
                onPrimary: Colors.white, // header text color
                onSurface: blackColor, // body text color
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: mainColor, // button text color
                ),
              ),
            ),
            child: child!,
          );
        },
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;

        String data = DateFormat('yyyy-MM-dd').format(selectedDate);
        dateC.text = data;
      });
    }
  }

  Future<void> _selectTime1(BuildContext context) async {

    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime1 ?? TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: mainColor, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: blackColor, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: mainColor, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (selectedTime != null && selectedTime != selectedTime1) {
      setState(() {
        selectedTime1 = selectedTime;
        timeStartC.text = "${selectedTime.hour}:${selectedTime.minute}";
      });
    }
  }

  Future<void> _selectTime2(BuildContext context) async {

    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime1 ?? TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: mainColor, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: blackColor, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: mainColor, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (selectedTime != null && selectedTime != selectedTime2) {
      setState(() {
        selectedTime2 = selectedTime;
        timeEndC.text = "${selectedTime.hour}:${selectedTime.minute}";
      });
    }
  }

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
        marginAppBar: 75,
        title: "submit_overtime".trans(context),
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
                          "fill_overtime".trans(context),
                          textAlign: TextAlign.start,
                          style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 3),
                        Text(
                          "information_overtime".trans(context),
                          textAlign: TextAlign.start,
                          style: greyFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(height: 15),
                        FormWithLabelCard(
                            outerLabelText: "overtime_category".trans(context),
                            hintText: "select_category".trans(context),
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
                            outerLabelText: "overtime_date".trans(context),
                            hintText: "select_date".trans(context),
                            controller: dateC,
                            prefixSvg: "${prefixIcons}ic_form_date.svg",
                            readOnly: true,
                            onSaved: (e) {
                              dateC.text = e ?? "";
                            },
                            onTap: (){
                              _selectDate(context);
                            },
                            validator: (e) {
                              return simpleValidator(e, null);
                            },
                            filled: true),
                        SizedBox(height: 20),
                        FormWithLabelCard(
                            outerLabelText: "overtime_start".trans(context),
                            hintText: "select_start".trans(context),
                            controller: timeStartC,
                            prefixSvg: "${prefixIcons}ic_form_date.svg",
                            readOnly: true,
                            onSaved: (e) {
                              timeStartC.text = e ?? "";
                            },
                            onTap: () async {
                              await _selectTime1(context);
                            },
                            validator: (e) {
                              return simpleValidator(e, null);
                            },
                            filled: true),
                        SizedBox(height: 20),
                        FormWithLabelCard(
                            outerLabelText: "overtime_end".trans(context),
                            hintText: "select_end".trans(context),
                            controller: timeEndC,
                            prefixSvg: "${prefixIcons}ic_form_date.svg",
                            readOnly: true,
                            onSaved: (e) {
                              timeEndC.text = e ?? "";
                            },
                            onTap: () async {
                              await _selectTime2(context);
                            },
                            validator: (e) {
                              return simpleValidator(e, null);
                            },
                            filled: true),
                        SizedBox(height: 20),
                        FormWithLabelCard(
                            outerLabelText: "priority".trans(context),
                            hintText: "select_priority".trans(context),
                            controller: priorityC,
                            prefixSvg: "${prefixIcons}ic_form_priority.svg",
                            onSaved: (e) {
                              priorityC.text = e ?? "";
                            },
                            validator: (e) {
                              return simpleValidator(e, null);
                            },
                            filled: true),
                        SizedBox(height: 20),
                        FormWithLabelCard(
                            outerLabelText: "overtime_description".trans(context),
                            hintText: "overtime_description".trans(context),
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
            if(selectedLeaveCategory != null && descriptionC.text.isNotEmpty && dateC.text.isNotEmpty && timeStartC.text.isNotEmpty && timeEndC.text.isNotEmpty){
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
            if(selectedLeaveCategory != null && descriptionC.text.isNotEmpty && dateC.text.isNotEmpty && timeStartC.text.isNotEmpty && timeEndC.text.isNotEmpty){
              setState(() {
                isLoading = true;
              });

              await OvertimesServices.submitLeaves(widget.token, timeStartC.text, timeEndC.text, dateC.text, descriptionC.text,).then((result) {

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

                  Get.to(OvertimePage(widget.token));

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
          return ModalOvertimeCalendarCard(token, fullWidth, 16, onSelected: (result){
            setState((){

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
          return ModalOvertimeCategoryCard(token, fullWidth, 16, onSelected: (result){
            setState((){
              selectedLeaveCategory = result;
              categoryC.text = result;
            });
          });
        });
  }

}
