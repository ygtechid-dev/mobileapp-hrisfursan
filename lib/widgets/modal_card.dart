part of 'widgets.dart';

class ModalForgotPasswordCard extends StatefulWidget {
  final String token;
  final double width;
  final double padding;

  ModalForgotPasswordCard(this.token, this.width, this.padding);

  @override
  State<ModalForgotPasswordCard> createState() => _ModalForgotPasswordCardState();
}

class _ModalForgotPasswordCardState extends State<ModalForgotPasswordCard> {
  TextEditingController emailC = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 49/100 + MediaQuery.of(context).viewInsets.bottom,
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      color: Colors.transparent,
      child: Stack(
        alignment: Alignment.topCenter,
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Container(
                    width: widget.width,
                    height: MediaQuery.of(context).size.height * 43/100,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20))
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 60),
                        Container(
                          padding: EdgeInsets.all(widget.padding),
                          child: Column(
                            children: [
                              Container(
                                width: widget.width - 2 * widget.padding,
                                alignment: Alignment.center,
                                child: Text("forgot_password".trans(context),
                                    textAlign: TextAlign.center,
                                    style: blackFontStyle.copyWith(fontSize: 20, fontWeight: FontWeight.w700)),
                              ),
                              SizedBox(
                                  height: 10
                              ),
                              Container(
                                width: widget.width - 2 * widget.padding,
                                alignment: Alignment.centerLeft,
                                child: Text("a_verification_code".trans(context),
                                    textAlign: TextAlign.start,
                                    style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400)),
                              ),
                              SizedBox(height: 10),
                              FormWithLabelCard(
                                  outerLabelText: "email".trans(context),
                                  hintText: "my_mail".trans(context),
                                  controller: emailC,
                                  inputType: TextInputType.emailAddress,
                                  prefixSvg: "${prefixIcons}ic_email.svg",
                                  onSaved: (e) {
                                    emailC.text = e ?? "";
                                  },
                                  validator: (e) {
                                    return emailValidator(e, null);
                                  },
                                  filled: true),
                              SizedBox(height: 20),
                              ButtonCard("send_verification".trans(context), widget.width - 2 * widget.padding, mainColor, colorGradient: buttonGradient, onPressed: () async {

                                await UserServices.forgot_password(emailC.text,).then((result) async {

                                  if(result != null && result.value != null && result.value == true){
                                    setState(() {
                                      isLoading = false;
                                    });

                                    Fluttertoast.showToast(
                                        msg: "${result.message}",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.green,
                                        textColor: Colors.white,
                                        fontSize: 16.0
                                    );

                                    Navigator.of(context).pop(false);
                                    modalBottomSheetForgot(context, widget.token);

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

                              }),
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              width: 100,
              height: 100,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: mainColor),
                    boxShadow: boxShadowBlue,
                    image: DecorationImage(
                        image: AssetImage("${prefixImages}img_security.png")
                    )
                ),
              ),
            ),
          ]
      )
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
          return ModalForgotPasswordPinCard(token, emailC.text, fullWidth, 16);
        });
  }

}

class ModalForgotPasswordPinCard extends StatefulWidget {
  final String token;
  final String email;
  final double width;
  final double padding;

  ModalForgotPasswordPinCard(this.token, this.email, this.width, this.padding);

  @override
  State<ModalForgotPasswordPinCard> createState() => _ModalForgotPasswordPinCardState();
}

class _ModalForgotPasswordPinCardState extends State<ModalForgotPasswordPinCard> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  bool isLoading = false;

  String? token, token_haha;

  @override
  Widget build(BuildContext context) {

    const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
    const fillColor = Color.fromRGBO(243, 246, 249, 0);

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: mainColor),
      ),
    );

    return Container(
      height: MediaQuery.of(context).size.height * 49/100 + MediaQuery.of(context).viewInsets.bottom,
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      color: Colors.transparent,
      child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [

                  Container(
                    width: widget.width,
                    height: MediaQuery.of(context).size.height * 43/100,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20))
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 35),
                        Container(
                          padding: EdgeInsets.all(widget.padding),
                          child: Column(
                            children: [
                              Container(
                                width: widget.width - 2 * widget.padding,
                                alignment: Alignment.center,
                                child: Text("forgot_assword".trans(context),
                                    textAlign: TextAlign.center,
                                    style: blackFontStyle.copyWith(fontSize: 20, fontWeight: FontWeight.w700)),
                              ),
                              SizedBox(
                                  height: 10
                              ),
                              Container(
                                width: widget.width - 2 * widget.padding,
                                alignment: Alignment.centerLeft,
                                child: Text("${"a_reset_code".trans(context)}${widget.email}, ${"check_email".trans(context)}",
                                    textAlign: TextAlign.start,
                                    style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400)),
                              ),
                              SizedBox(height: 10),
                              Container(
                                width: widget.width - 2 * widget.padding,
                                child: Pinput(
                                  length: 6,
                                  controller: pinController,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  focusNode: focusNode,
                                  androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
                                  listenForMultipleSmsOnAndroid: true,
                                  defaultPinTheme: defaultPinTheme,
                                    keyboardType: TextInputType.text,
                                  validator: (value) {

                                  },
                                  // onClipboardFound: (value) {
                                  //   debugPrint('onClipboardFound: $value');
                                  //   pinController.setText(value);
                                  // },
                                  hapticFeedbackType: HapticFeedbackType.lightImpact,
                                  onCompleted: (pin) {
                                    debugPrint('onCompleted: $pin');
                                  },
                                  onChanged: (value) {
                                    debugPrint('onChanged: $value');
                                  },
                                  cursor: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(bottom: 5),
                                        width: 22,
                                        height: 1,
                                        color: Colors.green.shade600,
                                      ),
                                    ],
                                  ),
                                  focusedPinTheme: defaultPinTheme.copyWith(
                                    decoration: defaultPinTheme.decoration!.copyWith(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(color: focusedBorderColor),
                                    ),
                                  ),
                                  submittedPinTheme: defaultPinTheme.copyWith(
                                    decoration: defaultPinTheme.decoration!.copyWith(
                                      color: fillColor,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(color: focusedBorderColor),
                                    ),
                                  ),
                                  errorPinTheme: defaultPinTheme.copyBorderWith(
                                    border: Border.all(color: Colors.redAccent),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                width: widget.width - 2 * widget.padding,
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    Text("havent_received".trans(context),
                                        textAlign: TextAlign.start,
                                        style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400)),
                                    InkWell(
                                      onTap: () async {
                                        await UserServices.forgot_password(widget.email).then((result) async {

                                          if(result != null && result.value != null && result.value == true){
                                            setState(() {
                                              isLoading = false;
                                            });

                                            Fluttertoast.showToast(
                                                msg: "${result.message}",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.green,
                                                textColor: Colors.white,
                                                fontSize: 16.0
                                            );

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
                                      },
                                      child: Text("resend_it".trans(context),
                                          textAlign: TextAlign.start,
                                          style: blackFontStyle.copyWith(fontSize: 12, color: mainColor, fontWeight: FontWeight.w400)),
                                    ),
                                  ]
                                )
                              ),
                              SizedBox(height: 20),
                              ButtonCard("submit".trans(context), widget.width - 2 * widget.padding, mainColor, colorGradient: buttonGradient, onPressed: () async {

                                await UserServices.check_token(widget.email, pinController.text).then((result) async {

                                  if(result != null && result.value != null && result.value == true){
                                    setState(() {
                                      isLoading = false;
                                    });

                                    Fluttertoast.showToast(
                                        msg: "${result.message}",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.green,
                                        textColor: Colors.white,
                                        fontSize: 16.0
                                    );

                                    Navigator.of(context).pop(false);
                                    modalBottomSheetForgot(context, widget.token, pinController.text);

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


                              }),
                              SizedBox(height: 5),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              width: 100,
              height: 100,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: mainColor),
                    boxShadow: boxShadowBlue,
                    image: DecorationImage(
                        image: AssetImage("${prefixImages}img_security.png")
                    )
                ),
              ),
            ),
          ]
      ),
    );
  }

  void modalBottomSheetForgot(contexts, String token, String pin){
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
          return ModalForgotPasswordNewCard(token, widget.email, fullWidth, 16, pin);
        });
  }

}

class ModalForgotPasswordNewCard extends StatefulWidget {
  final String token;
  final String email;
  final double width;
  final double padding;
  final String pin;

  ModalForgotPasswordNewCard(this.token, this.email, this.width, this.padding, this.pin);

  @override
  State<ModalForgotPasswordNewCard> createState() => _ModalForgotPasswordNewCardState();
}

class _ModalForgotPasswordNewCardState extends State<ModalForgotPasswordNewCard> {
  TextEditingController passwordC = TextEditingController();
  TextEditingController passwordConfirmC = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 59/100 + MediaQuery.of(context).viewInsets.bottom,
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      color: Colors.transparent,
      child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [

                  Container(
                    width: widget.width,
                    height: MediaQuery.of(context).size.height * 52/100,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20))
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 50),
                        Container(
                          padding: EdgeInsets.all(widget.padding),
                          child: Column(
                            children: [
                              Container(
                                width: widget.width - 2 * widget.padding,
                                alignment: Alignment.center,
                                child: Text("set_new_password".trans(context),
                                    textAlign: TextAlign.center,
                                    style: blackFontStyle.copyWith(fontSize: 20, fontWeight: FontWeight.w700)),
                              ),
                              SizedBox(
                                  height: 10
                              ),
                              Container(
                                width: widget.width - 2 * widget.padding,
                                alignment: Alignment.centerLeft,
                                child: Text("please_set_password".trans(context),
                                    textAlign: TextAlign.start,
                                    style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400)),
                              ),
                              SizedBox(
                                  height: 10
                              ),
                              FormWithLabelCard(
                                  outerLabelText: "password".trans(context),
                                  hintText: "new_password".trans(context),
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
                              SizedBox(height: 10),
                              FormWithLabelCard(
                                  outerLabelText: "confirm_password".trans(context),
                                  hintText: "reenter".trans(context),
                                  controller: passwordConfirmC,
                                  prefixSvg: "${prefixIcons}ic_password.svg",
                                  obscure: true,
                                  onSaved: (e) {
                                    passwordConfirmC.text = e ?? "";
                                  },
                                  validator: (e) {
                                    return passwordValidator(e, null);
                                  },
                                  filled: true),
                              SizedBox(height: 20),
                              ButtonCard("submit".trans(context), widget.width - 2 * widget.padding, mainColor, colorGradient: buttonGradient, onPressed: () async {
                                if(passwordC.text.isNotEmpty && passwordConfirmC.text.isNotEmpty){
                                  if(passwordC.text == passwordConfirmC.text){
                                    await UserServices.reset_password( widget.pin, widget.email, passwordC.text, passwordConfirmC.text, ).then((result) async {

                                      if(result != null && result.value != null && result.value == true){
                                        setState(() {
                                          isLoading = false;
                                        });

                                        Fluttertoast.showToast(
                                            msg: "${result.message}",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.green,
                                            textColor: Colors.white,
                                            fontSize: 16.0
                                        );

                                        Navigator.of(context).pop(false);
                                        modalBottomSheetForgot(context, widget.token);

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

                              }),
                              SizedBox(height: 5),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              width: 100,
              height: 100,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: mainColor),
                    boxShadow: boxShadowBlue,
                    image: DecorationImage(
                        image: AssetImage("${prefixImages}img_security.png")
                    )
                ),
              ),
            ),
          ]
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
          return ModalForgotPasswordSuccessCard(token, fullWidth, 16);
        });
  }

}

class ModalForgotPasswordSuccessCard extends StatefulWidget {
  final String token;
  final double width;
  final double padding;

  ModalForgotPasswordSuccessCard(this.token, this.width, this.padding);

  @override
  State<ModalForgotPasswordSuccessCard> createState() => _ModalForgotPasswordSuccessCardState();
}

class _ModalForgotPasswordSuccessCardState extends State<ModalForgotPasswordSuccessCard> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 38/100 + MediaQuery.of(context).viewInsets.bottom,
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      color: Colors.transparent,
      child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [

                  Container(
                    width: widget.width,
                    height: MediaQuery.of(context).size.height * 32/100,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20))
                    ),
                    child: Column(

                      children: [
                        SizedBox(height: 60),
                        Container(
                          padding: EdgeInsets.all(widget.padding),
                          child: Column(
                            children: [
                              Container(
                                width: widget.width - 2 * widget.padding,
                                alignment: Alignment.center,
                                child: Text("password_created".trans(context),
                                    textAlign: TextAlign.center,
                                    style: blackFontStyle.copyWith(fontSize: 20, fontWeight: FontWeight.w700)),
                              ),
                              SizedBox(
                                  height: 10
                              ),
                              Container(
                                width: widget.width - 2 * widget.padding,
                                alignment: Alignment.centerLeft,
                                child: Text("to_login".trans(context),
                                    textAlign: TextAlign.start,
                                    style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400)),
                              ),
                              SizedBox(height: 20),
                              ButtonCard("signin".trans(context), widget.width - 2 * widget.padding, mainColor, colorGradient: buttonGradient, onPressed: () async {
                                Navigator.of(context).pop(false);
                              }),
                              SizedBox(height: 5),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              width: 100,
              height: 100,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: mainColor),
                    boxShadow: boxShadowBlue,
                    image: DecorationImage(
                        image: AssetImage("${prefixImages}img_security.png")
                    )
                ),
              ),
            ),
          ]
      ),
    );
  }

}

class ModalClockInSuccessCard extends StatefulWidget {
  final String token;
  final double width;
  final double padding;

  ModalClockInSuccessCard(this.token, this.width, this.padding);

  @override
  State<ModalClockInSuccessCard> createState() => _ModalClockInSuccessCardState();
}

class _ModalClockInSuccessCardState extends State<ModalClockInSuccessCard> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 38/100 + MediaQuery.of(context).viewInsets.bottom,
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      color: Colors.transparent,
      child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Container(
                    width: widget.width,
                    height: MediaQuery.of(context).size.height * 32/100,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20))
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 60),
                        Container(
                          padding: EdgeInsets.all(widget.padding),
                          child: Column(
                            children: [
                              Container(
                                width: widget.width - 2 * widget.padding,
                                alignment: Alignment.center,
                                child: Text("clockin_success".trans(context),
                                    textAlign: TextAlign.center,
                                    style: blackFontStyle.copyWith(fontSize: 20, fontWeight: FontWeight.w700)),
                              ),
                              SizedBox(
                                  height: 10
                              ),
                              Container(
                                width: widget.width - 2 * widget.padding,
                                alignment: Alignment.centerLeft,
                                child: Text("clockin_success_notes".trans(context),
                                    textAlign: TextAlign.start,
                                    style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400)),
                              ),
                              SizedBox(height: 20),
                              ButtonCard("goto_attendance".trans(context), widget.width - 2 * widget.padding, mainColor, colorGradient: buttonGradient, onPressed: () async {
                                Get.to(MainPage(token: widget.token, index_: 2));
                              }),
                              SizedBox(height: 5),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              width: 100,
              height: 100,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: mainColor),
                    boxShadow: boxShadowBlue,
                    image: DecorationImage(
                        image: AssetImage("${prefixImages}img_clock_in.png")
                    )
                ),
              ),
            ),
          ]
      ),
    );
  }

}

class ModalClockOutSuccessCard extends StatefulWidget {
  final String token;
  final double width;
  final double padding;

  ModalClockOutSuccessCard(this.token, this.width, this.padding);

  @override
  State<ModalClockOutSuccessCard> createState() => _ModalClockOutSuccessCardState();
}

class _ModalClockOutSuccessCardState extends State<ModalClockOutSuccessCard> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 38/100 + MediaQuery.of(context).viewInsets.bottom,
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      color: Colors.transparent,
      child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Container(
                    width: widget.width,
                    height: MediaQuery.of(context).size.height * 32/100,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20))
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 60),
                        Container(
                          padding: EdgeInsets.all(widget.padding),
                          child: Column(
                            children: [
                              Container(
                                width: widget.width - 2 * widget.padding,
                                alignment: Alignment.center,
                                child: Text("clockout_success".trans(context),
                                    textAlign: TextAlign.center,
                                    style: blackFontStyle.copyWith(fontSize: 20, fontWeight: FontWeight.w700)),
                              ),
                              SizedBox(
                                  height: 10
                              ),
                              Container(
                                width: widget.width - 2 * widget.padding,
                                alignment: Alignment.centerLeft,
                                child: Text("clockout_success_notes".trans(context),
                                    textAlign: TextAlign.start,
                                    style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400)),
                              ),
                              SizedBox(height: 20),
                              ButtonCard("close_message".trans(context), widget.width - 2 * widget.padding, mainColor, colorGradient: buttonGradient, onPressed: () async {
                                Get.to(MainPage(token: widget.token));
                              }),
                              SizedBox(height: 5),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              width: 100,
              height: 100,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: mainColor),
                    boxShadow: boxShadowBlue,
                    image: DecorationImage(
                        image: AssetImage("${prefixImages}img_clock_out.png")
                    )
                ),
              ),
            ),
          ]
      ),
    );
  }

}

class ModalExportPDFSuccessCard extends StatefulWidget {
  final String token;
  final double width;
  final double padding;

  ModalExportPDFSuccessCard(this.token, this.width, this.padding);

  @override
  State<ModalExportPDFSuccessCard> createState() => _ModalExportPDFSuccessCardState();
}

class _ModalExportPDFSuccessCardState extends State<ModalExportPDFSuccessCard> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 37/100 + MediaQuery.of(context).viewInsets.bottom,
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      color: Colors.transparent,
      child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Container(
                    width: widget.width,
                    height: MediaQuery.of(context).size.height * 31/100,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20))
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 60),
                        Container(
                          padding: EdgeInsets.all(widget.padding),
                          child: Column(
                            children: [
                              Container(
                                width: widget.width - 2 * widget.padding,
                                alignment: Alignment.center,
                                child: Text("export_pdf_success".trans(context),
                                    textAlign: TextAlign.center,
                                    style: blackFontStyle.copyWith(fontSize: 20, fontWeight: FontWeight.w700)),
                              ),
                              SizedBox(
                                  height: 10
                              ),
                              Container(
                                width: widget.width - 2 * widget.padding,
                                alignment: Alignment.centerLeft,
                                child: Text("export_pdf_success_notes".trans(context),
                                    textAlign: TextAlign.start,
                                    style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400)),
                              ),
                              SizedBox(height: 20),
                              ButtonCard("close_message".trans(context), widget.width - 2 * widget.padding, mainColor, colorGradient: buttonGradient, onPressed: () async {
                                Get.to(MainPage(token: widget.token, index_: 2));
                              }),
                              SizedBox(height: 5),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              width: 100,
              height: 100,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: mainColor),
                    boxShadow: boxShadowBlue,
                    image: DecorationImage(
                        image: AssetImage("${prefixImages}img_export.png")
                    )
                ),
              ),
            ),
          ]
      ),
    );
  }

}

class ModalClockOutCard extends StatefulWidget {
  final String token;
  final String clockin;
  final double width;
  final double padding;

  ModalClockOutCard(this.token, this.clockin, this.width, this.padding);

  @override
  State<ModalClockOutCard> createState() => _ModalClockOutCardState();
}

class _ModalClockOutCardState extends State<ModalClockOutCard> {

  bool isLoading = false;

  String? _timeString;
  String? _hoursString;

  @override
  void initState() {

    _timeString = _formatDateTime(DateTime.now());
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    super.initState();
  }

  void _getTime() async {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    final String formattedDateTime2 = _formatDateTime2(now);


    if(widget.clockin != null){
      var clockin_temp = widget.clockin.split(":");
      double hours = double.parse(clockin_temp[0]);
      double minutes = double.parse(clockin_temp[1]);
      double seconds = double.parse(clockin_temp[2]);

      var timeHehe = formattedDateTime2.split(":");
      double hours_ = double.parse(timeHehe[0]);
      double minutes_ = double.parse(timeHehe[1]);
      double seconds_ = double.parse(timeHehe[2]);

      double fixHours = hours_ - hours;
      double fixMinutes = minutes_ - minutes;
      double fixSeconds = seconds_ - seconds;

      setState(() {
        _hoursString = "${(fixHours > 9) ? fixHours.toStringAsFixed(0) : "0${fixHours.toStringAsFixed(0)}"}:${(fixMinutes < 0) ? "00" : ((fixMinutes > 9) ? fixMinutes.toStringAsFixed(0) : "0${fixMinutes.toStringAsFixed(0)}")}:${(fixSeconds < 0) ? "00" : ((fixSeconds > 9) ? fixSeconds.toStringAsFixed(0) : "0${fixSeconds.toStringAsFixed(0)}")}";
      });
    }

    setState(() {
      _timeString = formattedDateTime;
    });
  }

  String _formatDateTime(DateTime dateTime) {
    return intl.DateFormat('HH:mm:ss').format(dateTime);
  }

  String _formatDateTime2(DateTime dateTime) {
    return intl.DateFormat('HH:mm:ss').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 59/100 + MediaQuery.of(context).viewInsets.bottom,
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      color: Colors.transparent,
      child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Container(
                    width: widget.width,
                    height: MediaQuery.of(context).size.height * 53/100,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20))
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 50),
                        Container(
                          padding: EdgeInsets.all(widget.padding),
                          child: Column(
                            children: [
                              Container(
                                width: widget.width - 2 * widget.padding,
                                alignment: Alignment.center,
                                child: Text("confirm_clockout".trans(context),
                                    textAlign: TextAlign.center,
                                    style: blackFontStyle.copyWith(fontSize: 20, fontWeight: FontWeight.w700)),
                              ),
                              SizedBox(
                                  height: 10
                              ),
                              Container(
                                width: widget.width - 2 * widget.padding,
                                alignment: Alignment.centerLeft,
                                child: Text("confirm_clockout_notes".trans(context),
                                    textAlign: TextAlign.start,
                                    style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400)),
                              ),
                              SizedBox(
                                  height: 10
                              ),
                              Container(
                                width: widget.width - 2 * widget.padding,
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    TimeCard((widget.width - 2*16)/2 - 5, "clock_out".trans(context), "${_timeString}"),
                                    TimeCard((widget.width - 2*16)/2 - 5, "total_hours".trans(context), "${_hoursString ?? '-'}"),
                                  ],
                                ),
                              ),
                              SizedBox(
                                  height: 10
                              ),
                              SizedBox(height: 20),
                              ButtonCard("yes_clockout".trans(context), widget.width - 2 * widget.padding, mainColor, colorGradient: buttonGradient, onPressed: () async {
                                if (await Permission.location.isGranted) {
                                  if(await Permission.locationWhenInUse.serviceStatus.isEnabled || await Permission.locationAlways.serviceStatus.isEnabled || await Permission.location.serviceStatus.isEnabled){
                                    // Use location.
                                    var position = await Geolocator.getCurrentPosition(
                                        forceAndroidLocationManager: false,
                                        desiredAccuracy: LocationAccuracy.best);

                                    try {
                                      List<Placemark> placemarks = await placemarkFromCoordinates(
                                          position!.latitude,
                                          position!.longitude,
                                          localeIdentifier: "id"
                                      );

                                      print("LOKASI " + placemarks[0].toString());

                                      List<String> jj = placemarks[0].subAdministrativeArea!.split(' ');

                                      String kota = placemarks[0].subAdministrativeArea!.replaceAll('Kota ', '').replaceAll(' City', '');

                                      String cc = placemarks[0]!.administrativeArea!;

                                      String provinsi = cc;

                                      String jalan = placemarks[0].street ?? "";
                                      String country = placemarks[0].country ?? "";

                                      String location = "${jalan} ${kota}, ${provinsi}, ${country}";

                                      Get.to(ClockOutCameraPage(widget.token, "${position!.latitude}", "${position!.longitude}", location));

                                    } catch(err){

                                      // await context.read<PrayerCubit>().getPrayer("", "");

                                    }
                                  }
                                }
                              }),
                              SizedBox(height: 15),
                              ButtonCard("no_letme".trans(context), widget.width - 2 * widget.padding, mainColor, isActive: true, onPressed: () async {
                                Navigator.of(context).pop(false);
                              }),
                              SizedBox(height: 5),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              width: 100,
              height: 100,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: mainColor),
                    boxShadow: boxShadowBlue,
                    image: DecorationImage(
                        image: AssetImage("${prefixImages}img_clock_in.png")
                    )
                ),
              ),
            ),
          ]
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
          return ModalForgotPasswordSuccessCard(token, fullWidth, 16);
        });
  }

}

class ModalDefaultInfoCard extends StatefulWidget {
  final String token;
  final double width;
  final double padding;
  final String title;
  final String description;
  final String imagePath;

  ModalDefaultInfoCard(this.token, this.width, this.padding, this.title,
      this.description, this.imagePath);

  @override
  State<ModalDefaultInfoCard> createState() => _ModalDefaultInfoCardState();
}

class _ModalDefaultInfoCardState extends State<ModalDefaultInfoCard> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 38/100 + MediaQuery.of(context).viewInsets.bottom,
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      color: Colors.transparent,
      child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Container(
                    width: widget.width,
                    height: MediaQuery.of(context).size.height * 32/100,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20))
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 60),
                        Container(
                          padding: EdgeInsets.all(widget.padding),
                          child: Column(
                            children: [
                              Container(
                                width: widget.width - 2 * widget.padding,
                                alignment: Alignment.center,
                                child: Text("${widget.title}",
                                    textAlign: TextAlign.center,
                                    style: blackFontStyle.copyWith(fontSize: 20, fontWeight: FontWeight.w700)),
                              ),
                              SizedBox(
                                  height: 10
                              ),
                              Container(
                                width: widget.width - 2 * widget.padding,
                                alignment: Alignment.centerLeft,
                                child: Text("${widget.description}",
                                    textAlign: TextAlign.start,
                                    style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400)),
                              ),
                              SizedBox(height: 20),
                              ButtonCard("close_message".trans(context), widget.width - 2 * widget.padding, mainColor, colorGradient: buttonGradient, onPressed: () async {
                                Navigator.of(context).pop(false);
                              }),
                              SizedBox(height: 5),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              width: 100,
              height: 100,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: mainColor),
                    boxShadow: boxShadowBlue,
                    image: DecorationImage(
                        image: AssetImage("${prefixImages}${widget.imagePath}")
                    )
                ),
              ),
            ),
          ]
      ),
    );
  }

}

class ModalDefaultSubmitCard extends StatefulWidget {
  final String token;
  final double width;
  final double padding;
  final String title;
  final String description;
  final String imagePath;
  final Function? onSubmit;

  ModalDefaultSubmitCard(this.token, this.width, this.padding, this.title,
      this.description, this.imagePath, {this.onSubmit});

  @override
  State<ModalDefaultSubmitCard> createState() => _ModalDefaultSubmitCardState();
}

class _ModalDefaultSubmitCardState extends State<ModalDefaultSubmitCard> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 45/100 + MediaQuery.of(context).viewInsets.bottom,
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      color: Colors.transparent,
      child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Container(
                    width: widget.width,
                    height: MediaQuery.of(context).size.height * 40/100,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20))
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 60),
                        Container(
                          padding: EdgeInsets.all(widget.padding),
                          child: Column(
                            children: [
                              Container(
                                width: widget.width - 2 * widget.padding,
                                alignment: Alignment.center,
                                child: Text("${widget.title}",
                                    textAlign: TextAlign.center,
                                    style: blackFontStyle.copyWith(fontSize: 20, fontWeight: FontWeight.w700)),
                              ),
                              SizedBox(
                                  height: 10
                              ),
                              Container(
                                width: widget.width - 2 * widget.padding,
                                alignment: Alignment.centerLeft,
                                child: Text("${widget.description}",
                                    textAlign: TextAlign.center,
                                    style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400)),
                              ),
                              SizedBox(height: 20),
                              ButtonCard("yes_submit".trans(context), widget.width - 2 * widget.padding, mainColor, colorGradient: buttonGradient, onPressed: () async {
                                widget.onSubmit!();
                              }),
                              SizedBox(height: 15),
                              ButtonCard("no_letme".trans(context), widget.width - 2 * widget.padding, mainColor, isActive: true, onPressed: () async {
                                Navigator.of(context).pop(false);
                              }),
                              SizedBox(height: 5),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              width: 100,
              height: 100,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: mainColor),
                    boxShadow: boxShadowBlue,
                    image: DecorationImage(
                        image: AssetImage("${prefixImages}${widget.imagePath}")
                    )
                ),
              ),
            ),
          ]
      ),
    );
  }

}

class ModalLeaveCategoryCard extends StatefulWidget {
  final String token;
  final double width;
  final double padding;
  final ValueChanged<List<String>>? onSelected;

  ModalLeaveCategoryCard(this.token, this.width, this.padding, {this.onSelected});

  @override
  State<ModalLeaveCategoryCard> createState() => _ModalLeaveCategoryCardState();
}

class _ModalLeaveCategoryCardState extends State<ModalLeaveCategoryCard> {
  bool isLoading = false;

  List<String> listData = [
    "Sick",
    "Personal Purpose",
    "Personal Purpose",
    "Personal Purpose",
  ];

  @override
  void initState() {
    context.read<LeavesTypesCubit>().getLeavesTypes(widget.token);
    super.initState();
  }

  List<String>? selectedData;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: MediaQuery.of(context).size.height * 40/100,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))
      ),
      child: Column(
        children: [
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(widget.padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "leave_category".trans(context),
                  textAlign: TextAlign.start,
                  style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 3),
                Text(
                  "select_category".trans(context),
                  textAlign: TextAlign.start,
                  style: greyFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 15),
                BlocBuilder<LeavesTypesCubit, LeavesTypesState>(
                    builder: (context, state) => (state is LeavesTypesLoaded) ? (state.data != null && state.data!.isNotEmpty) ? Column(
                        children: state.data!.map((e) => itemCategory(e, ((selectedData != null) && selectedData!.contains("${e.id}")), onSelected: (){
                          setState((){
                            selectedData = ["${e.id}", "${e.title}"];
                          });
                        })).toList()
                    ) : SizedBox() : loadingIndicator
                ),
                SizedBox(height: 15),
                ButtonCard("submit".trans(context), widget.width - 2 * widget.padding, mainColor, colorGradient: buttonGradient, onPressed: () async {
                  if(selectedData != null){
                    widget.onSelected!(selectedData!);
                    Navigator.of(context).pop(false);
                  }

                }),
                SizedBox(height: 5),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget itemCategory(LeavesTypes data, bool isSelected, {Function? onSelected}){
    return InkWell(
      onTap: (){
        onSelected!();
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        width: widget.width,
        padding: EdgeInsets.symmetric(vertical: 18, horizontal: 12),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: (isSelected) ? mainColor : greyColor)
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${data.title}",
                textAlign: TextAlign.start,
                style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
              ),
              Icon((isSelected) ? Icons.check_circle : Icons.circle_outlined, size: 24, color: (isSelected) ? mainColor : greyColor)
            ]
        ),
      )
    );
  }

}

class ModalLeaveCalendarCard extends StatefulWidget {
  final String token;
  final double width;
  final double padding;
  final ValueChanged<List<String>>? onSelected;

  ModalLeaveCalendarCard(this.token, this.width, this.padding, {this.onSelected});

  @override
  State<ModalLeaveCalendarCard> createState() => _ModalLeaveCalendarCardState();
}

class _ModalLeaveCalendarCardState extends State<ModalLeaveCalendarCard> {
  bool isBeginActive = false;
  bool isEndActive = false;

  String? selectedData;

  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';

  String? startDate, endDate, startDay, endDay, selectedStartDate, selectedEndDate;

  /// The method for [DateRangePickerSelectionChanged] callback, which will be
  /// called whenever a selection changed on the date picker widget.
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    /// The argument value will return the changed date as [DateTime] when the
    /// widget [SfDateRangeSelectionMode] set as single.
    ///
    /// The argument value will return the changed dates as [List<DateTime>]
    /// when the widget [SfDateRangeSelectionMode] set as multiple.
    ///
    /// The argument value will return the changed range as [PickerDateRange]
    /// when the widget [SfDateRangeSelectionMode] set as range.
    ///
    /// The argument value will return the changed ranges as
    /// [List<PickerDateRange] when the widget [SfDateRangeSelectionMode] set as
    /// multi range.
    setState(() {
      if (args.value is PickerDateRange) {
        _range = '${intl.DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
        // ignore: lines_longer_than_80_chars
            ' ${intl.DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
        startDate = '${intl.DateFormat('dd MMMM').format(args.value.startDate)}';
        endDate = '${intl.DateFormat('dd MMMM').format(args.value.endDate)}';

        startDay = '${intl.DateFormat('EEEE').format(args.value.startDate)}';
        endDay = '${intl.DateFormat('EEEE').format(args.value.endDate)}';

        selectedStartDate = '${intl.DateFormat('yyyy-MM-dd').format(args.value.startDate)}';
        selectedEndDate = '${intl.DateFormat('yyyy-MM-dd').format(args.value.endDate)}';
      } else if (args.value is DateTime) {
        _selectedDate = args.value.toString();
      } else if (args.value is List<DateTime>) {
        _dateCount = args.value.length.toString();
      } else {
        _rangeCount = args.value.length.toString();
      }
    });
  }


  @override
  void initState() {
    startDate = intl.DateFormat('dd MMMM').format(DateTime.now().subtract(const Duration(days: 1)));
    endDate = intl.DateFormat('dd MMMM').format(DateTime.now().add(const Duration(days: 1)));

    startDay = intl.DateFormat('EEEE').format(DateTime.now().subtract(const Duration(days: 1)));
    endDay = intl.DateFormat('EEEE').format(DateTime.now().add(const Duration(days: 1)));

    selectedStartDate = '${intl.DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(const Duration(days: 1)))}';
    selectedEndDate = '${intl.DateFormat('yyyy-MM-dd').format(DateTime.now().add(const Duration(days: 1)))}';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: MediaQuery.of(context).size.height * 70/100,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))
      ),
      child: Column(
        children: [
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(widget.padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "leave_duration".trans(context),
                  textAlign: TextAlign.start,
                  style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 3),
                Text(
                  "choose_date".trans(context),
                  textAlign: TextAlign.start,
                  style: greyFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 15),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      width: widget.width/2 - 2*16 - 15,
                      padding: EdgeInsets.symmetric(vertical: 18, horizontal: 25),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: (isBeginActive) ? mainColor : greyColor)
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "${startDate ?? '-'}",
                              textAlign: TextAlign.center,
                              style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 3),
                            Text(
                              "${startDay ?? '-'}",
                              textAlign: TextAlign.center,
                              style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                            ),
                          ]
                      ),
                    ),
                    Text(
                      "-",
                      textAlign: TextAlign.center,
                      style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      width: widget.width/2 - 2*16 - 15,
                      padding: EdgeInsets.symmetric(vertical: 18, horizontal: 25),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: (isEndActive) ? mainColor : greyColor)
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "${endDate ?? '-'}",
                              textAlign: TextAlign.center,
                              style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 3),
                            Text(
                              "${endDay ?? '-'}",
                              textAlign: TextAlign.center,
                              style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                            ),
                          ]
                      ),
                    ),
                  ]
                ),
                SizedBox(height: 5),
                SfDateRangePicker(
                  backgroundColor: Colors.white,
                  selectionColor: mainColor.withOpacity(0.5),
                  startRangeSelectionColor: mainColor,
                  endRangeSelectionColor: mainColor,
                  rangeSelectionColor: mainColor.withOpacity(0.2),
                  todayHighlightColor: mainColor,
                  headerStyle: DateRangePickerHeaderStyle(
                    backgroundColor: Colors.white,
                  ),
                  onSelectionChanged: _onSelectionChanged,
                  selectionMode: DateRangePickerSelectionMode.range,
                  initialSelectedRange: PickerDateRange(
                      DateTime.now().subtract(const Duration(days: 1)),
                      DateTime.now().add(const Duration(days: 1))
                  ),
                ),
                // CalendarCard(),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ButtonCard("reset".trans(context), (widget.width - 2 * widget.padding)/2 - 15, mainColor, isActive: true, onPressed: () async {

                    }),
                    ButtonCard("show".trans(context), (widget.width - 2 * widget.padding)/2 - 15, mainColor, colorGradient: buttonGradient, onPressed: () async {
                      widget.onSelected!(["${selectedStartDate}", "${selectedEndDate}"]);
                      Navigator.of(context).pop(false);
                    }),
                  ]
                ),
                SizedBox(height: 5),
              ],
            ),
          ),
        ],
      ),
    );
  }

}

class ModalReimburseCategoryCard extends StatefulWidget {
  final String token;
  final double width;
  final double padding;
  final List<ReimbursementCategory> category;
  final ValueChanged<ReimbursementCategory>? onSelected;

  ModalReimburseCategoryCard(this.token, this.width, this.padding, this.category, {this.onSelected});

  @override
  State<ModalReimburseCategoryCard> createState() => _ModalReimburseCategoryCardState();
}

class _ModalReimburseCategoryCardState extends State<ModalReimburseCategoryCard> {
  bool isLoading = false;

  ReimbursementCategory? selectedData;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: MediaQuery.of(context).size.height * 60/100,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))
      ),
      child: Column(
        children: [
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(widget.padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "leave_category".trans(context),
                  textAlign: TextAlign.start,
                  style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 3),
                Text(
                  "select_category".trans(context),
                  textAlign: TextAlign.start,
                  style: greyFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 15),
                Column(
                    children: widget.category.map((e) => itemCategory(e, (selectedData == e), onSelected: (){
                      setState((){
                        selectedData = e;
                      });
                    })).toList()
                ),
                SizedBox(height: 15),
                ButtonCard("submit".trans(context), widget.width - 2 * widget.padding, mainColor, colorGradient: buttonGradient, onPressed: () async {
                  if(selectedData != null){
                    widget.onSelected!(selectedData!);
                    Navigator.of(context).pop(false);
                  }

                }),
                SizedBox(height: 5),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget itemCategory(ReimbursementCategory data, bool isSelected, {Function? onSelected}){
    return InkWell(
        onTap: (){
          onSelected!();
        },
        child: Container(
          margin: EdgeInsets.only(bottom: 10),
          width: widget.width,
          padding: EdgeInsets.symmetric(vertical: 18, horizontal: 12),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: (isSelected) ? mainColor : greyColor)
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${data.name}",
                  textAlign: TextAlign.start,
                  style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                ),
                Icon((isSelected) ? Icons.check_circle : Icons.circle_outlined, size: 24, color: (isSelected) ? mainColor : greyColor)
              ]
          ),
        )
    );
  }

}

class ModalOvertimeCategoryCard extends StatefulWidget {
  final String token;
  final double width;
  final double padding;
  final ValueChanged<String>? onSelected;

  ModalOvertimeCategoryCard(this.token, this.width, this.padding, {this.onSelected});

  @override
  State<ModalOvertimeCategoryCard> createState() => _ModalOvertimeCategoryCardState();
}

class _ModalOvertimeCategoryCardState extends State<ModalOvertimeCategoryCard> {
  bool isLoading = false;

  List<String> listData = [
    "Many Jobs",
    "Deadline",
    "Other",
  ];

  String? selectedData;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: MediaQuery.of(context).size.height * 50/100,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))
      ),
      child: Column(
        children: [
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(widget.padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "overtime_category".trans(context),
                  textAlign: TextAlign.start,
                  style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 3),
                Text(
                  "select_category".trans(context),
                  textAlign: TextAlign.start,
                  style: greyFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 15),
                Column(
                    children: listData.map((e) => itemCategory(e, (selectedData == e), onSelected: (){
                      setState((){
                        selectedData = e;
                      });
                    })).toList()
                ),
                SizedBox(height: 15),
                ButtonCard("submit".trans(context), widget.width - 2 * widget.padding, mainColor, colorGradient: buttonGradient, onPressed: () async {
                  if(selectedData != null){
                    widget.onSelected!(selectedData!);
                    Navigator.of(context).pop(false);
                  }

                }),
                SizedBox(height: 5),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget itemCategory(String title, bool isSelected, {Function? onSelected}){
    return InkWell(
        onTap: (){
          onSelected!();
        },
        child: Container(
          margin: EdgeInsets.only(bottom: 10),
          width: widget.width,
          padding: EdgeInsets.symmetric(vertical: 18, horizontal: 12),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: (isSelected) ? mainColor : greyColor)
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${title}",
                  textAlign: TextAlign.start,
                  style: greyFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                ),
                Icon((isSelected) ? Icons.check_circle : Icons.circle_outlined, size: 24, color: (isSelected) ? mainColor : greyColor)
              ]
          ),
        )
    );
  }

}

class ModalOvertimeCalendarCard extends StatefulWidget {
  final String token;
  final double width;
  final double padding;
  final ValueChanged<List<String>>? onSelected;

  ModalOvertimeCalendarCard(this.token, this.width, this.padding, {this.onSelected});

  @override
  State<ModalOvertimeCalendarCard> createState() => _ModalOvertimeCalendarCardState();
}

class _ModalOvertimeCalendarCardState extends State<ModalOvertimeCalendarCard> {
  bool isBeginActive = false;
  bool isEndActive = false;

  String? selectedData;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      // height: MediaQuery.of(context).size.height * 82/100,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))
      ),
      child: Column(
        children: [
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(widget.padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "overtime_duration".trans(context),
                  textAlign: TextAlign.start,
                  style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 3),
                Text(
                  "choose_date".trans(context),
                  textAlign: TextAlign.start,
                  style: greyFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 15),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        width: widget.width/2 - 2*16 - 15,
                        padding: EdgeInsets.symmetric(vertical: 18, horizontal: 25),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: (isBeginActive) ? mainColor : greyColor)
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "01 Desember",
                                textAlign: TextAlign.center,
                                style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 3),
                              Text(
                                "Monday",
                                textAlign: TextAlign.center,
                                style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                              ),
                            ]
                        ),
                      ),
                      Text(
                        "-",
                        textAlign: TextAlign.center,
                        style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        width: widget.width/2 - 2*16 - 15,
                        padding: EdgeInsets.symmetric(vertical: 18, horizontal: 25),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: (isEndActive) ? mainColor : greyColor)
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "07 Desember",
                                textAlign: TextAlign.center,
                                style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 3),
                              Text(
                                "Sunday",
                                textAlign: TextAlign.center,
                                style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                              ),
                            ]
                        ),
                      ),
                    ]
                ),
                SizedBox(height: 5),
                CalendarCard(),
                SizedBox(height: 25),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ButtonCard("Reset", (widget.width - 2 * widget.padding)/2 - 15, mainColor, isActive: true, onPressed: () async {

                      }),
                      ButtonCard("Show", (widget.width - 2 * widget.padding)/2 - 15, mainColor, colorGradient: buttonGradient, onPressed: () async {
                        Navigator.of(context).pop(false);
                      }),
                    ]
                ),
                SizedBox(height: 5),
              ],
            ),
          ),
        ],
      ),
    );
  }

}

class ModalUpdatePasswordCard extends StatefulWidget {
  final String token;
  final double width;
  final double padding;
  final Function? onSubmit;

  ModalUpdatePasswordCard(this.token, this.width, this.padding, {this.onSubmit});

  @override
  State<ModalUpdatePasswordCard> createState() => _ModalUpdatePasswordCardState();
}

class _ModalUpdatePasswordCardState extends State<ModalUpdatePasswordCard> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 43/100 + MediaQuery.of(context).viewInsets.bottom,
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      color: Colors.transparent,
      child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Container(
                    width: widget.width,
                    height: MediaQuery.of(context).size.height * 38/100,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20))
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 60),
                        Container(
                          padding: EdgeInsets.all(widget.padding),
                          child: Column(
                            children: [
                              Container(
                                width: widget.width - 2 * widget.padding,
                                alignment: Alignment.center,
                                child: Text("update_password".trans(context),
                                    textAlign: TextAlign.center,
                                    style: blackFontStyle.copyWith(fontSize: 20, fontWeight: FontWeight.w700)),
                              ),
                              SizedBox(
                                  height: 10
                              ),
                              Container(
                                width: widget.width - 2 * widget.padding,
                                alignment: Alignment.centerLeft,
                                child: Text("are_you_sure_update_password".trans(context),
                                    textAlign: TextAlign.start,
                                    style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400)),
                              ),
                              SizedBox(height: 20),
                              ButtonCard("yes_update".trans(context), widget.width - 2 * widget.padding, mainColor, colorGradient: buttonGradient, onPressed: () async {
                                widget.onSubmit!();
                              }),
                              SizedBox(height: 20),
                              ButtonCard("no_letme".trans(context), widget.width - 2 * widget.padding, mainColor, isActive: true, colorGradient: buttonGradient, onPressed: () async {
                                Navigator.of(context).pop(false);
                              }),
                              SizedBox(height: 5),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              width: 100,
              height: 100,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: mainColor),
                    boxShadow: boxShadowBlue,
                    image: DecorationImage(
                        image: AssetImage("${prefixImages}img_password.png")
                    )
                ),
              ),
            ),
          ]
      ),
    );
  }

}

class ModalPasswordSuccessCard extends StatefulWidget {
  final String token;
  final double width;
  final double padding;

  ModalPasswordSuccessCard(this.token, this.width, this.padding);

  @override
  State<ModalPasswordSuccessCard> createState() => _ModalPasswordSuccessCardState();
}

class _ModalPasswordSuccessCardState extends State<ModalPasswordSuccessCard> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 37/100 + MediaQuery.of(context).viewInsets.bottom,
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      color: Colors.transparent,
      child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [

                  Container(
                    width: widget.width,
                    height: MediaQuery.of(context).size.height * 31/100,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20))
                    ),
                    child: Column(

                      children: [
                        SizedBox(height: 60),
                        Container(
                          padding: EdgeInsets.all(widget.padding),
                          child: Column(
                            children: [
                              Container(
                                width: widget.width - 2 * widget.padding,
                                alignment: Alignment.center,
                                child: Text("password_has_created".trans(context),
                                    textAlign: TextAlign.center,
                                    style: blackFontStyle.copyWith(fontSize: 20, fontWeight: FontWeight.w700)),
                              ),
                              SizedBox(
                                  height: 10
                              ),
                              Container(
                                width: widget.width - 2 * widget.padding,
                                alignment: Alignment.centerLeft,
                                child: Text("password_has_created_notes".trans(context),
                                    textAlign: TextAlign.start,
                                    style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400)),
                              ),
                              SizedBox(height: 20),
                              ButtonCard("signin".trans(context), widget.width - 2 * widget.padding, mainColor, colorGradient: buttonGradient, onPressed: () async {
                                Navigator.of(context).pop(false);
                              }),
                              SizedBox(height: 5),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              width: 100,
              height: 100,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: mainColor),
                    boxShadow: boxShadowBlue,
                    image: DecorationImage(
                        image: AssetImage("${prefixImages}img_password.png")
                    )
                ),
              ),
            ),
          ]
      ),
    );
  }

}

class ModalTerminationCard extends StatefulWidget {
  final String token;
  final double width;
  final double padding;

  ModalTerminationCard(this.token, this.width, this.padding);

  @override
  State<ModalTerminationCard> createState() => _ModalTerminationCardState();
}

class _ModalTerminationCardState extends State<ModalTerminationCard> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 40/100 + MediaQuery.of(context).viewInsets.bottom,
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      color: Colors.transparent,
      child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [

                  Container(
                    width: widget.width,
                    height: MediaQuery.of(context).size.height * 34/100,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20))
                    ),
                    child: Column(

                      children: [
                        SizedBox(height: 60),
                        Container(
                          padding: EdgeInsets.all(widget.padding),
                          child: Column(
                            children: [
                              Container(
                                width: widget.width - 2 * widget.padding,
                                alignment: Alignment.center,
                                child: Text("termination_info".trans(context),
                                    textAlign: TextAlign.center,
                                    style: blackFontStyle.copyWith(fontSize: 20, fontWeight: FontWeight.w700)),
                              ),
                              SizedBox(
                                  height: 10
                              ),
                              Container(
                                width: widget.width - 2 * widget.padding,
                                alignment: Alignment.centerLeft,
                                child: Text("termination_info_notes".trans(context),
                                    textAlign: TextAlign.start,
                                    style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400)),
                              ),
                              SizedBox(height: 20),
                              ButtonCard("close_message".trans(context), widget.width - 2 * widget.padding, mainColor, colorGradient: buttonGradient, onPressed: () async {
                                Navigator.of(context).pop(false);
                              }),
                              SizedBox(height: 5),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              width: 100,
              height: 100,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: mainColor),
                    boxShadow: boxShadowBlue,
                    image: DecorationImage(
                        image: AssetImage("${prefixImages}img_security.png")
                    )
                ),
              ),
            ),
          ]
      ),
    );
  }

}