part of "../pages.dart";

class PasswordPage extends StatefulWidget {
  final String token;

  PasswordPage(this.token);

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  TextEditingController passwordC = TextEditingController();
  TextEditingController passwordNewC = TextEditingController();
  TextEditingController passwordNewConfirmC = TextEditingController();

  bool isAgree = false;
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
      title: "change_password".trans(context),
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
                        "set_new_password".trans(context),
                        textAlign: TextAlign.start,
                        style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 3),
                      Text(
                        "fill_password".trans(context),
                        textAlign: TextAlign.start,
                        style: greyFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(height: 20),
                      FormWithLabelCard(
                          outerLabelText: "current_password".trans(context),
                          hintText: "current_password".trans(context),
                          controller: passwordC,
                          prefixSvg: "${prefixIcons}ic_password.svg",
                          obscure: true,
                          onSaved: (e) {
                            passwordC.text = e ?? "";
                          },
                          validator: (e) {
                            return passwordValidator(e, null);
                          },
                          filled: true),
                      SizedBox(height: 20),
                      FormWithLabelCard(
                          outerLabelText: "new_password".trans(context),
                          hintText: "new_password".trans(context),
                          controller: passwordNewC,
                          prefixSvg: "${prefixIcons}ic_password.svg",
                          obscure: true,
                          onSaved: (e) {
                            passwordNewC.text = e ?? "";
                          },
                          validator: (e) {
                            return passwordValidator(e, null);
                          },
                          filled: true),
                      SizedBox(height: 20),
                      FormWithLabelCard(
                          outerLabelText: "confirm_new_password".trans(context),
                          hintText: "confirm_new_password".trans(context),
                          controller: passwordNewConfirmC,
                          prefixSvg: "${prefixIcons}ic_password.svg",
                          obscure: true,
                          onSaved: (e) {
                            passwordNewConfirmC.text = e ?? "";
                          },
                          validator: (e) {
                            return passwordValidator(e, null);
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
        child: BlocBuilder<UserCubit, UserState>(
            builder: (context, state) => (state is UserLoaded) ? (state.user != null)
                ? ButtonCard("save".trans(context), defaultWidth - 2*24, mainColor, isLoading: isLoading, colorGradient: buttonGradient, onPressed: () async {

              modalBottomSheet(context, widget.token, state.user!.email!);

            }) : SizedBox() : loadingIndicator
        ),
      ),
    );
  }

  void modalBottomSheet(contexts, String token, String email){
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
          return ModalUpdatePasswordCard(token, fullWidth, 16, onSubmit: () async {
            if(passwordC.text.isNotEmpty && passwordNewC.text.isNotEmpty && passwordNewConfirmC.text.isNotEmpty){
              if(passwordNewC.text == passwordNewConfirmC.text){

                await UserServices.forgot_password(email!).then((result) async {

                  if(result != null && result.value != null && result.value == true){

                    await UserServices.reset_password( "token", email!, passwordNewC.text, passwordNewConfirmC.text).then((result2) async {

                      if(result2 != null && result2.value != null && result2.value == true){
                        setState(() {
                          isLoading = false;
                        });

                        Fluttertoast.showToast(
                            msg: "${result2.message}",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );

                        modalBottomSheetSuccess(contexts, token);

                      } else {
                        setState(() {
                          isLoading = false;
                        });

                        Fluttertoast.showToast(
                            msg: "${result2.message}",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }
                    });
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


              } else {
                Fluttertoast.showToast(
                    msg: "confirm_pass_match".trans(context),
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
              }
            }

          },);
        });
  }

  void modalBottomSheetSuccess(contexts, String token){
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
          return ModalPasswordSuccessCard(token, fullWidth, 16);
        });
  }
}
