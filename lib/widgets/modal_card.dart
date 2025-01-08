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
        height: MediaQuery.of(context).size.height * 47/100 + MediaQuery.of(context).viewInsets.bottom,
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
                    height: MediaQuery.of(context).size.height * 41/100,
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
                                child: Text("Forgot Password",
                                    textAlign: TextAlign.center,
                                    style: blackFontStyle.copyWith(fontSize: 20, fontWeight: FontWeight.w700)),
                              ),
                              SizedBox(
                                  height: 10
                              ),
                              Container(
                                width: widget.width - 2 * widget.padding,
                                alignment: Alignment.centerLeft,
                                child: Text("A verification code will be sent to your email to reset your password.",
                                    textAlign: TextAlign.start,
                                    style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400)),
                              ),
                              SizedBox(height: 10),
                              FormWithLabelCard(
                                  outerLabelText: "Email",
                                  hintText: "My Mail",
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
                              ButtonCard("Send Verification Code", widget.width - 2 * widget.padding, mainColor, colorGradient: buttonGradient, onPressed: () async {
                                Navigator.of(context).pop(false);
                                modalBottomSheetForgot(context, "");
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
          return ModalForgotPasswordPinCard(token, fullWidth, 16);
        });
  }

}

class ModalForgotPasswordPinCard extends StatefulWidget {
  final String token;
  final double width;
  final double padding;

  ModalForgotPasswordPinCard(this.token, this.width, this.padding);

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
      height: MediaQuery.of(context).size.height * 47/100 + MediaQuery.of(context).viewInsets.bottom,
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
                    height: MediaQuery.of(context).size.height * 41/100,
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
                                child: Text("Forgot Password",
                                    textAlign: TextAlign.center,
                                    style: blackFontStyle.copyWith(fontSize: 20, fontWeight: FontWeight.w700)),
                              ),
                              SizedBox(
                                  height: 10
                              ),
                              Container(
                                width: widget.width - 2 * widget.padding,
                                alignment: Alignment.centerLeft,
                                child: Text("A reset code has been sent to Adam@work.com, check your email to continue the password reset process.",
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
                                    Text("Haven't received the verification code? ",
                                        textAlign: TextAlign.start,
                                        style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400)),
                                    Text(" Resend it.",
                                        textAlign: TextAlign.start,
                                        style: blackFontStyle.copyWith(fontSize: 12, color: mainColor, fontWeight: FontWeight.w400)),
                                  ]
                                )
                              ),
                              SizedBox(height: 20),
                              ButtonCard("Submit", widget.width - 2 * widget.padding, mainColor, colorGradient: buttonGradient, onPressed: () async {
                                Navigator.of(context).pop(false);
                                modalBottomSheetForgot(context, "");
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
          return ModalForgotPasswordNewCard(token, fullWidth, 16);
        });
  }

}

class ModalForgotPasswordNewCard extends StatefulWidget {
  final String token;
  final double width;
  final double padding;

  ModalForgotPasswordNewCard(this.token, this.width, this.padding);

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
      height: MediaQuery.of(context).size.height * 57/100 + MediaQuery.of(context).viewInsets.bottom,
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
                    height: MediaQuery.of(context).size.height * 50/100,
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
                                child: Text("Set a New Password",
                                    textAlign: TextAlign.center,
                                    style: blackFontStyle.copyWith(fontSize: 20, fontWeight: FontWeight.w700)),
                              ),
                              SizedBox(
                                  height: 10
                              ),
                              Container(
                                width: widget.width - 2 * widget.padding,
                                alignment: Alignment.centerLeft,
                                child: Text("Please set a new password to secure your Work Mate account.",
                                    textAlign: TextAlign.start,
                                    style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400)),
                              ),
                              SizedBox(
                                  height: 10
                              ),
                              FormWithLabelCard(
                                  outerLabelText: "Password",
                                  hintText: "New Password",
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
                                  outerLabelText: "Confirm Password",
                                  hintText: "Re Enter Your Password",
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
                              ButtonCard("Submit", widget.width - 2 * widget.padding, mainColor, colorGradient: buttonGradient, onPressed: () async {
                                Navigator.of(context).pop(false);
                                modalBottomSheetForgot(context, "");
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
                                child: Text("Password Has Been Created",
                                    textAlign: TextAlign.center,
                                    style: blackFontStyle.copyWith(fontSize: 20, fontWeight: FontWeight.w700)),
                              ),
                              SizedBox(
                                  height: 10
                              ),
                              Container(
                                width: widget.width - 2 * widget.padding,
                                alignment: Alignment.centerLeft,
                                child: Text("To log in to your account, click the Sign in button and enter your email along with your new password.",
                                    textAlign: TextAlign.start,
                                    style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400)),
                              ),
                              SizedBox(height: 20),
                              ButtonCard("Sign In", widget.width - 2 * widget.padding, mainColor, colorGradient: buttonGradient, onPressed: () async {
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
                                child: Text("Clock-In Successful!",
                                    textAlign: TextAlign.center,
                                    style: blackFontStyle.copyWith(fontSize: 20, fontWeight: FontWeight.w700)),
                              ),
                              SizedBox(
                                  height: 10
                              ),
                              Container(
                                width: widget.width - 2 * widget.padding,
                                alignment: Alignment.centerLeft,
                                child: Text("You’re all set! Your clock-in was successful. Head over to your dashboard to see your assigned tasks.",
                                    textAlign: TextAlign.start,
                                    style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400)),
                              ),
                              SizedBox(height: 20),
                              ButtonCard("Go To Attendance Page", widget.width - 2 * widget.padding, mainColor, colorGradient: buttonGradient, onPressed: () async {
                                Get.to(MainPage(index_: 2));
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
                                child: Text("Clock-Out Successful!",
                                    textAlign: TextAlign.center,
                                    style: blackFontStyle.copyWith(fontSize: 20, fontWeight: FontWeight.w700)),
                              ),
                              SizedBox(
                                  height: 10
                              ),
                              Container(
                                width: widget.width - 2 * widget.padding,
                                alignment: Alignment.centerLeft,
                                child: Text("You’ve officially clocked out for the day. Thank you for your hard work! Time to relax and enjoy your break.",
                                    textAlign: TextAlign.start,
                                    style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400)),
                              ),
                              SizedBox(height: 20),
                              ButtonCard("Close Message", widget.width - 2 * widget.padding, mainColor, colorGradient: buttonGradient, onPressed: () async {
                                Get.to(MainPage());
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
                                child: Text("Export As PDF Successful!",
                                    textAlign: TextAlign.center,
                                    style: blackFontStyle.copyWith(fontSize: 20, fontWeight: FontWeight.w700)),
                              ),
                              SizedBox(
                                  height: 10
                              ),
                              Container(
                                width: widget.width - 2 * widget.padding,
                                alignment: Alignment.centerLeft,
                                child: Text("Your data has been exported as a PDF. Download it now!",
                                    textAlign: TextAlign.start,
                                    style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400)),
                              ),
                              SizedBox(height: 20),
                              ButtonCard("Close Message", widget.width - 2 * widget.padding, mainColor, colorGradient: buttonGradient, onPressed: () async {
                                Get.to(MainPage(index_: 2));
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
  final double width;
  final double padding;

  ModalClockOutCard(this.token, this.width, this.padding);

  @override
  State<ModalClockOutCard> createState() => _ModalClockOutCardState();
}

class _ModalClockOutCardState extends State<ModalClockOutCard> {

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 57/100 + MediaQuery.of(context).viewInsets.bottom,
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
                    height: MediaQuery.of(context).size.height * 50/100,
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
                                child: Text("Confirm Clockout",
                                    textAlign: TextAlign.center,
                                    style: blackFontStyle.copyWith(fontSize: 20, fontWeight: FontWeight.w700)),
                              ),
                              SizedBox(
                                  height: 10
                              ),
                              Container(
                                width: widget.width - 2 * widget.padding,
                                alignment: Alignment.centerLeft,
                                child: Text("Once you clock out, you won’t be able to edit this time. Please double-check your hours before proceeding.",
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
                                    TimeCard((widget.width - 2*16)/2 - 5, "Clock In", "00:00"),
                                    TimeCard((widget.width - 2*16)/2 - 5, "Clock Out", "00:00"),
                                  ],
                                ),
                              ),
                              SizedBox(
                                  height: 10
                              ),
                              SizedBox(height: 20),
                              ButtonCard("Yes, Clock Out", widget.width - 2 * widget.padding, mainColor, colorGradient: buttonGradient, onPressed: () async {
                                Get.to(ClockOutCameraPage());
                              }),
                              SizedBox(height: 15),
                              ButtonCard("No, Let me check", widget.width - 2 * widget.padding, mainColor, isActive: true, onPressed: () async {
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
                        image: AssetImage("${prefixImages}img_clock.png")
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
                              ButtonCard("Close Message", widget.width - 2 * widget.padding, mainColor, colorGradient: buttonGradient, onPressed: () async {
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
                              ButtonCard("Yes, Submit", widget.width - 2 * widget.padding, mainColor, colorGradient: buttonGradient, onPressed: () async {
                                widget.onSubmit!();
                              }),
                              SizedBox(height: 20),
                              ButtonCard("No, Let me check", widget.width - 2 * widget.padding, mainColor, isActive: true, colorGradient: buttonGradient, onPressed: () async {
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
  final ValueChanged<String>? onSelected;

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

  String? selectedData;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      // height: MediaQuery.of(context).size.height * 45/100,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))
      ),
      child: Column(
        children: [
          SizedBox(height: 30),
          Container(
            padding: EdgeInsets.all(widget.padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Leave Category",
                  textAlign: TextAlign.start,
                  style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 3),
                Text(
                  "Select Leave Category",
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
                ButtonCard("Submit", widget.width - 2 * widget.padding, mainColor, colorGradient: buttonGradient, onPressed: () async {
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

class ModalLeaveCalendarCard extends StatefulWidget {
  final String token;
  final double width;
  final double padding;
  final ValueChanged<String>? onSelected;

  ModalLeaveCalendarCard(this.token, this.width, this.padding, {this.onSelected});

  @override
  State<ModalLeaveCalendarCard> createState() => _ModalLeaveCalendarCardState();
}

class _ModalLeaveCalendarCardState extends State<ModalLeaveCalendarCard> {
  bool isBeginActive = false;
  bool isEndActive = false;

  String? selectedData;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      // height: MediaQuery.of(context).size.height * 45/100,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))
      ),
      child: Column(
        children: [
          SizedBox(height: 30),
          Container(
            padding: EdgeInsets.all(widget.padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Leave Duration",
                  textAlign: TextAlign.start,
                  style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 3),
                Text(
                  "Choose a date of duration",
                  textAlign: TextAlign.start,
                  style: greyFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 15),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      width: widget.width,
                      padding: EdgeInsets.symmetric(vertical: 21, horizontal: 30),
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
                              style: greyFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 3),
                            Text(
                              "Monday",
                              textAlign: TextAlign.center,
                              style: greyFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
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
                      width: widget.width,
                      padding: EdgeInsets.symmetric(vertical: 21, horizontal: 30),
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
                              style: greyFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 3),
                            Text(
                              "Sunday",
                              textAlign: TextAlign.center,
                              style: greyFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                            ),
                          ]
                      ),
                    ),
                  ]
                ),
                SizedBox(height: 15),
                CalendarCard(),
                SizedBox(height: 25),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ButtonCard("Reset", (widget.width - 2 * widget.padding)/2 - 15, mainColor, isActive: true, colorGradient: buttonGradient, onPressed: () async {

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