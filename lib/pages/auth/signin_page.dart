part of '../pages.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();

  bool isRemember = false;

  @override
  Widget build(BuildContext context) {
    double defaultWidth = MediaQuery.of(context).size.width - 2*defaultMargin;
    double fullWidth = MediaQuery.of(context).size.width;

    return GeneralPage(
      title: "",
      isAppBarCircular: true,
      appBarColorGradient: backgroundGradient,
      child: Container(
        child: Stack(
          children: [
            Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: mainColor),
                      boxShadow: boxShadowBlue
                  ),
                ),
            ),
            Positioned(
              top: 50,
              left: 0,
              right: 0,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: defaultMargin),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    SizedBox(height: 55),
                    Text(
                      "Sign In",
                      textAlign: TextAlign.center,
                      style: blackFontStyle.copyWith(fontSize: 24, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Sign in to my account",
                      textAlign: TextAlign.center,
                      style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 20),
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
                    FormWithLabelCard(
                        outerLabelText: "Password",
                        hintText: "My Password",
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: (){
                                setState(() {
                                  isRemember = !isRemember;
                                });
                              },
                              child: Icon((isRemember) ? Icons.check_box : Icons.check_box_outline_blank, color: mainColor, size: 16),
                            ),
                            SizedBox(width: 6),
                            Text(
                              "Remember Me",
                              textAlign: TextAlign.start,
                              style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: (){
                            modalBottomSheetForgot(context, "");
                          },
                          child: Text(
                            "Forgot Password",
                            textAlign: TextAlign.end,
                            style: blackFontStyle.copyWith(fontSize: 12, color: mainColor, fontWeight: FontWeight.w400),
                          ),
                        ),

                      ],
                    ),
                    SizedBox(height: 20),
                    ButtonCard("Sign In", defaultWidth, mainColor, colorGradient: buttonGradient, onPressed: () async {}),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: defaultWidth/2 - 15 - 20,
                          child: Divider(color: greyColor, thickness: 1,)
                        ),
                        SizedBox(width: 15),
                        Text(
                          "OR",
                          textAlign: TextAlign.center,
                          style: blackFontStyle.copyWith(fontSize: 12, color: greyColor, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(width: 15),
                        Container(
                            width: defaultWidth/2 - 15 - 20,
                            child: Divider(color: greyColor, thickness: 1,)
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    ButtonCard("Sign in With Google", defaultWidth, mainColor, isActive: true, iconPath: "${prefixIcons}ic_google.svg", onPressed: () async {}),
                    SizedBox(height: 15),
                    ButtonCard("Sign in With Employee ID", defaultWidth, mainColor, isActive: true, iconPath: "${prefixIcons}ic_employee.svg", onPressed: () async {}),
                    SizedBox(height: 15),
                    ButtonCard("Sign In With Phone", defaultWidth, mainColor, isActive: true, iconPath: "${prefixIcons}ic_phone.svg", onPressed: () async {}),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don’t have account?  ",
                          style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                          textAlign: TextAlign.start,
                        ),
                        InkWell(
                          onTap: (){
                            Get.to(SignUpPage());
                          },
                          child: Text(
                            "Sign Up Here",
                            style: blackFontStyle.copyWith(fontSize: 12, color: mainColor, fontWeight: FontWeight.w600),
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 40),
                  ],
                )
              )
            ),
          ]
        )
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
        builder: (bc){
          return ModalForgotPasswordCard(token, fullWidth, 16);
        });
  }
}
