part of '../pages.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  TextEditingController companyC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  TextEditingController passwordConfirmC = TextEditingController();

  bool isLoading = false;

  bool isAgree = false;

  @override
  Widget build(BuildContext context) {
    double defaultWidth = MediaQuery.of(context).size.width - 2*defaultMargin;
    double fullWidth = MediaQuery.of(context).size.width;

    return GeneralPage(
      statusBarColor: mainColor,
      child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: defaultMargin),
          alignment: Alignment.center,
          child: Column(
            children: [
              SizedBox(height: 50),
              Container(
                width: defaultWidth,
                alignment: Alignment.center,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: mainColor),
                      boxShadow: boxShadowBlue
                  ),
                  child: Image.asset("${prefixImages}img_logo.png", width: 60, height: 60,),
                ),
              ),
              SizedBox(height: 15),
              Text(
                "Sign Up",
                textAlign: TextAlign.center,
                style: blackFontStyle.copyWith(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 5),
              Text(
                "Register Using Your Credentials",
                textAlign: TextAlign.center,
                style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 15),
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
                  outerLabelText: "Phone Number",
                  hintText: "0813456890",
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
                  outerLabelText: "Company ID",
                  hintText: "Enter Company ID",
                  controller: companyC,
                  prefixSvg: "${prefixIcons}ic_company.svg",
                  onSaved: (e) {
                    companyC.text = e ?? "";
                  },
                  validator: (e) {
                    return simpleValidator(e, null);
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
              SizedBox(height: 20),
              FormWithLabelCard(
                  outerLabelText: "Confirm Password",
                  hintText: "Confirm My Password",
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
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: (){
                      setState(() {
                        isAgree = !isAgree;
                      });
                    },
                    child: Icon((isAgree) ? Icons.check_box : Icons.check_box_outline_blank, color: mainColor, size: 16),
                  ),
                  SizedBox(width: 6),
                  Row(
                    children: [
                      Text(
                        "I agree with ",
                        textAlign: TextAlign.start,
                        style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                      ),
                      InkWell(
                        child: Text(
                          "terms & conditions",
                          textAlign: TextAlign.start,
                          style: blackFontStyle.copyWith(fontSize: 12, color: mainColor, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Text(
                        " and ",
                        textAlign: TextAlign.start,
                        style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                      ),
                      InkWell(
                        child: Text(
                          "privacy policy",
                          textAlign: TextAlign.start,
                          style: blackFontStyle.copyWith(fontSize: 12, color: mainColor, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ]
                  )
                ],
              ),
              SizedBox(height: 25),
              ButtonCard("Sign Up", defaultWidth, (isAgree == true && emailC.text.isNotEmpty && phoneC.text.isNotEmpty && companyC.text.isNotEmpty && passwordC.text.isNotEmpty && passwordConfirmC.text.isNotEmpty) ? mainColor : greyColor, isLoading: isLoading, colorGradient: buttonGradient, onPressed: () async {
                if(isAgree == true && emailC.text.isNotEmpty && phoneC.text.isNotEmpty && companyC.text.isNotEmpty && passwordC.text.isNotEmpty && passwordConfirmC.text.isNotEmpty){


                  if(passwordC.text == passwordConfirmC.text){
                    User user = User(
                        email: emailC.text,
                        phone: phoneC.text,
                        company_id: companyC.text,
                        first_name: "h",
                        last_name: "h"
                    );

                    setState(() {
                      isLoading = true;
                    });

                    await UserServices.register(user, passwordC.text).then((result) async {

                      if(result != null && result.value != null){

                        await context.read<UserCubit>().login(
                            emailC.text,
                            passwordC.text).then((result2) async {

                          SharedPreferences prefs = await SharedPreferences.getInstance().whenComplete(() async {

                          });

                          if (prefs.getString('token') != null) {
                            setState(() {
                              isLoading = false;
                            });

                            Fluttertoast.showToast(
                                msg: "Berhasil Registrasi",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );

                            Get.to(PersonalDataPage(prefs.getString('token')!, result.value!));
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
                        msg: "Password konfirmasi tidak cocok",
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
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?  ",
                    style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                    textAlign: TextAlign.start,
                  ),
                  InkWell(
                    onTap: (){
                      Get.to(SignInPage());
                    },
                    child: Text(
                      "Sign In Here",
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
    );
  }
}
