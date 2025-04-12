part of '../pages.dart';

class ReimburseCreatePage extends StatefulWidget {
  final String token;

  ReimburseCreatePage(this.token);

  @override
  State<ReimburseCreatePage> createState() => _ReimburseCreatePageState();
}

class _ReimburseCreatePageState extends State<ReimburseCreatePage> {
  TextEditingController titleC = TextEditingController();
  TextEditingController categoryC = TextEditingController();
  TextEditingController dateC = TextEditingController();
  TextEditingController descriptionC = TextEditingController();
  TextEditingController amountC = TextEditingController();

  bool isAgree = false;

  @override
  void initState() {
    super.initState();
    context.read<ReimbursementCategoryCubit>().getReimbursementCategory(widget.token);
  }

  String? category_id;

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
      title: "submit_expense".trans(context),
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
                        "fill_claim".trans(context),
                        textAlign: TextAlign.start,
                        style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 3),
                      Text(
                        "information_claim".trans(context),
                        textAlign: TextAlign.start,
                        style: greyFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(height: 20),
                      CommonDottedButtonWithImage2(title: "upload_claim".trans(context), subtitle: "format_should".trans(context), onPicked: (value){

                      }),
                      SizedBox(height: 20),
                      FormWithLabelCard(
                          outerLabelText: "title".trans(context),
                          hintText: "Enter ${"title".trans(context)}",
                          controller: amountC,
                          onSaved: (e) {
                            titleC.text = e ?? "";
                          },
                          validator: (e) {
                            return simpleValidator(e, null);
                          },
                          filled: true),
                      SizedBox(height: 20),
                      BlocBuilder<ReimbursementCategoryCubit, ReimbursementCategoryState>(
                          builder: (context, state) {
                            if (state is ReimbursementCategoryLoaded){
                              if (state.data != null) {

                                return FormWithLabelCard(
                                    outerLabelText: "expense_category".trans(context),
                                    hintText: "select_category".trans(context),
                                    controller: categoryC,
                                    prefixSvg: "${prefixIcons}ic_form_title.svg",
                                    onSaved: (e) {
                                      categoryC.text = e ?? "";
                                    },
                                    onTap: (){
                                      modalBottomSheetCategory(context, widget.token, state.data ?? []);
                                    },
                                    validator: (e) {
                                      return simpleValidator(e, null);
                                    },
                                    filled: true);
                              } else {
                                return SizedBox();
                              }
                            } else {
                              return loadingIndicator;
                            }
                          }
                      ),
                      SizedBox(height: 20),
                      FormWithLabelCard(
                          outerLabelText: "transaction_date".trans(context),
                          hintText: "Enter ${"transaction_date".trans(context)}",
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
                          outerLabelText: "expense_amount".trans(context),
                          hintText: "Enter ${"expense_amount".trans(context)}",
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
                          outerLabelText: "expense_description".trans(context),
                          hintText: "Enter ${"expense_description".trans(context)}",
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
        child: ButtonCard("submit".trans(context), defaultWidth - 2*24, mainColor, colorGradient: buttonGradient, onPressed: () async {
          modalBottomSheet(context, widget.token);
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
          return ModalDefaultSubmitCard(token, fullWidth, 16, "ready_submit".trans(context), "double_check_form".trans(context), "img_leave.png", onSubmit: () async {
            if(titleC.text.isNotEmpty && dateC.text.isNotEmpty && amountC.text.isNotEmpty && category_id != null){
              setState(() {
                isLoading = true;
              });

              await ReimbursementServices.createReimbursement(widget.token, "${titleC.text}", "${descriptionC.text}", "${category_id}", "${amountC.text}", "${dateC.text}").then((result) async {

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

                  await context.read<ReimbursementCubit>().getReimbursement(widget.token);

                  Get.to(ReimbursePage(widget.token));

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

  void modalBottomSheetCategory(contexts, String token, List<ReimbursementCategory> listData){
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
          return ModalReimburseCategoryCard(token, fullWidth, 16, listData, onSelected: (value) {
            setState((){
              category_id = "${value.id}";
              categoryC.text = "${value.name}";
            });
          });
        });
  }

}
