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
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
            child: Column(
              children: [
                SizedBox(height: 50),
                Container(
                  width: widget.width,
                  height: MediaQuery.of(context).size.height * 65/100,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20))
                  ),
                  child: Stack(
                    children: [
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
                              modalBottomSheetForgot(context, "");
                            }),
                            SizedBox(height: 20),
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
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
                color: mainColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: mainColor),
                boxShadow: boxShadowBlue,
                image: DecorationImage(
                  image: AssetImage("${prefixImages}img_secuurity.png")
                )
            ),
          ),
        ),
      ]
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

    return Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                SizedBox(height: 50),
                Container(
                  width: widget.width,
                  height: MediaQuery.of(context).size.height * 65/100,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20))
                  ),
                  child: Stack(
                    children: [
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
                              modalBottomSheetForgot(context, "");
                            }),
                            SizedBox(height: 20),
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
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: mainColor),
                  boxShadow: boxShadowBlue,
                  image: DecorationImage(
                      image: AssetImage("${prefixImages}img_secuurity.png")
                  )
              ),
            ),
          ),
        ]
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
    return Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                SizedBox(height: 50),
                Container(
                  width: widget.width,
                  height: MediaQuery.of(context).size.height * 65/100,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20))
                  ),
                  child: Stack(
                    children: [
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
                            SizedBox(height: 20),
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
                              modalBottomSheetForgot(context, "");
                            }),
                            SizedBox(height: 20),
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
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: mainColor),
                  boxShadow: boxShadowBlue,
                  image: DecorationImage(
                      image: AssetImage("${prefixImages}img_secuurity.png")
                  )
              ),
            ),
          ),
        ]
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
    return Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                SizedBox(height: 50),
                Container(
                  width: widget.width,
                  height: MediaQuery.of(context).size.height * 65/100,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20))
                  ),
                  child: Stack(
                    children: [
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
                            ButtonCard("Sign In", widget.width - 2 * widget.padding, mainColor, colorGradient: buttonGradient, onPressed: () async {}),
                            SizedBox(height: 20),
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
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: mainColor),
                  boxShadow: boxShadowBlue,
                  image: DecorationImage(
                      image: AssetImage("${prefixImages}img_secuurity.png")
                  )
              ),
            ),
          ),
        ]
    );
  }

}