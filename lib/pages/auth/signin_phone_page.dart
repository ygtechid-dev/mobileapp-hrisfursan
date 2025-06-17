part of '../pages.dart';

class SignInPhonePage extends StatefulWidget {
  const SignInPhonePage({super.key});

  @override
  State<SignInPhonePage> createState() => _SignInPhonePageState();
}

class _SignInPhonePageState extends State<SignInPhonePage> {
  TextEditingController phoneC = TextEditingController();
  TextEditingController passwordC = TextEditingController();

  bool isRemember = false;
  bool isLoading = false;

  String? token;

  @override
  Widget build(BuildContext context) {
    double defaultWidth = MediaQuery.of(context).size.width - 2*defaultMargin;
    double fullWidth = MediaQuery.of(context).size.width;

    return GeneralPage(
      title: "",
      isAppBarCircular: true,
      isFrontAppBar: false,
      appBarColorGradient: backgroundGradient,
      marginAppBar: 0,
      child: Container(
        height: MediaQuery.of(context).size.height - 20,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: SvgPicture.asset("${prefixImages}bcg_intro.svg", width: MediaQuery.of(context).size.width),
              ),
            ),
            Positioned(
              top: 70,
              left: 0,
              right: 0,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: defaultMargin),
                decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    SizedBox(height: 60),
                    Text(
                      "signin".trans(context),
                      textAlign: TextAlign.center,
                      style: blackFontStyle.copyWith(fontSize: 22, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "signin_myaccount".trans(context),
                      textAlign: TextAlign.center,
                      style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(height: 20),
                    FormWithLabelCard(
                        outerLabelText: "phone_number".trans(context),
                        hintText: "${"phone_number".trans(context)}",
                        controller: phoneC,
                        inputType: TextInputType.name,
                        prefixSvg: "${prefixIcons}ic_phone.svg",
                        onSaved: (e) {
                          phoneC.text = e ?? "";
                        },
                        validator: (e) {
                          return simpleValidator(e, null);
                        },
                        filled: true),
                    SizedBox(height: 20),
                    FormWithLabelCard(
                        outerLabelText: "password".trans(context),
                        hintText: "my_password".trans(context),
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
                              "remember_me".trans(context),
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
                            "forgot_password".trans(context),
                            textAlign: TextAlign.end,
                            style: blackFontStyle.copyWith(fontSize: 12, color: mainColor, fontWeight: FontWeight.w400),
                          ),
                        ),

                      ],
                    ),
                    SizedBox(height: 20),
                    ButtonCard("signin".trans(context), defaultWidth, mainColor, isLoading: isLoading, colorGradient: buttonGradient, onPressed: () async {
                      String? uid;

                      if (phoneC.text.isNotEmpty && passwordC.text.isNotEmpty){

                        setState(() {
                          isLoading = true;
                        });

                        await context.read<UserCubit>().login(
                            phoneC.text,
                            passwordC.text, login_type: "phone").then((result) {
                        });

                        UserState state = context.read<UserCubit>().state;
                        if(state is UserLoaded){
                          SharedPreferences prefs = await SharedPreferences.getInstance().whenComplete(() async {

                          });
                          if(state.user != null){
                            if (prefs.getString('token') != null) {
                              setState(() {
                                token = prefs.getString('token');
                                // ignore: deprecated_member_use
                              });

                              await context.read<UserCubit>().getProfile(token!);

                              Fluttertoast.showToast(
                                  msg: "success_login".trans(context),
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );

                              Get.to(MainPage(token: token!));

                              setState(() {
                                isLoading = false;
                              });

                            } else {
                              token = "";
                              Get.snackbar('', '',
                                  backgroundColor: Colors.red,
                                  icon: Icon(Icons.close, color: Colors.white,),
                                  titleText: Text('account_not_register'.trans(context), style: blackFontStyle.copyWith(color: Colors.white),)
                              );
                              setState(() {
                                isLoading = false;
                              });
                            }
                          } else {
                            Get.snackbar('', '',
                                backgroundColor: Colors.red,
                                icon: Icon(Icons.close, color: Colors.white,),
                                titleText: Text('account_not_register'.trans(context), style: blackFontStyle.copyWith(color: Colors.white),)
                            );
                            setState(() {
                              isLoading = false;
                            });
                          }
                        } else {
                          Get.snackbar('', '',
                              backgroundColor: Colors.red,
                              icon: Icon(Icons.close, color: Colors.white,),
                              titleText: Text('account_not_register'.trans(context), style: blackFontStyle.copyWith(color: Colors.white),)
                          );
                          setState(() {
                            isLoading = false;
                          });
                        }
                      }
                    }),
                    SizedBox(height: 160),
                  ],
                )
              )
            ),
            Positioned(
              top: 20,
              width: 100,
              height: 100,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: mainColor),
                    boxShadow: boxShadowBlue
                ),
                child: Image.asset("${prefixImages}img_logo.png", width: 88, height: 88,),
              ),
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
        backgroundColor: Colors.transparent,
        builder: (bc){
          return ModalForgotPasswordCard("6|5ijdhiXsWTY0jxumalFAiYap99uULaKucJtmnI4V3c79bfeb", fullWidth, 16);
        });
  }
}
