part of "../pages.dart";

class FormResignPage extends StatefulWidget {
  final String token;

  FormResignPage(this.token);

  @override
  State<FormResignPage> createState() => _FormResignPageState();
}

class _FormResignPageState extends State<FormResignPage> {
  TextEditingController categoryC = TextEditingController();
  TextEditingController dateC = TextEditingController();
  TextEditingController descriptionC = TextEditingController();

  bool isAgree = false;

  File? selectedFile;

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {

    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1980, 8),
        lastDate: DateTime(2040)
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;

        String data = DateFormat('yyyy-MM-dd').format(selectedDate);
        dateC.text = data;
      });
    }
  }

  bool isLoading = false;

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
      title: "form_resign".trans(context),
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
                        "fill_info".trans(context),
                        textAlign: TextAlign.start,
                        style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 3),
                      Text(
                        "info_about".trans(context),
                        textAlign: TextAlign.start,
                        style: greyFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(height: 20),
                      CommonDottedButtonWithImage2(title: "upload_resign".trans(context), subtitle: "format_should".trans(context), onPicked: (value){
                        setState((){
                          selectedFile = value;
                        });
                      }),
                      SizedBox(height: 20),
                      FormWithLabelCard(
                          outerLabelText: "date_resign".trans(context),
                          hintText: "enter_date_resign".trans(context),
                          controller: dateC,
                          prefixSvg: "${prefixIcons}ic_form_date.svg",
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
                          outerLabelText: "resign_desc".trans(context),
                          hintText: "resign_desc".trans(context),
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
        child: ButtonCard("submit".trans(context), defaultWidth - 2*24, mainColor, isLoading: isLoading, colorGradient: buttonGradient, onPressed: () async {
          if(descriptionC.text.isNotEmpty && dateC.text.isNotEmpty && selectedFile != null){
            setState(() {
              isLoading = true;
            });

            Resign resign = Resign(
              description: descriptionC.text,
              resign_date: dateC.text,
            );

            await UserServices.submitResign(widget.token, resign, selectedFile!).then((result) {

              if(result != null && result.value != null){

                setState(() {
                  isLoading = false;
                });

                Fluttertoast.showToast(
                    msg: "success_update".trans(context),
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0
                );

                Get.to(MainPage(token: widget.token));

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
        }),
      ),
    );
  }
}
