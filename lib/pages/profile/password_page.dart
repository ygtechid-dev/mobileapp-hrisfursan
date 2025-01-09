part of "../pages.dart";

class PasswordPage extends StatefulWidget {
  const PasswordPage({super.key});

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  TextEditingController passwordC = TextEditingController();
  TextEditingController passwordNewC = TextEditingController();
  TextEditingController passwordNewConfirmC = TextEditingController();

  bool isAgree = false;

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
      title: "Change Password",
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
                    children: [
                      Text(
                        "Set a New Password",
                        textAlign: TextAlign.start,
                        style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 3),
                      Text(
                        "Fill information to change your password.",
                        textAlign: TextAlign.start,
                        style: greyFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(height: 20),
                      FormWithLabelCard(
                          outerLabelText: "Current Password",
                          hintText: "Current Password",
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
                          outerLabelText: "New Password",
                          hintText: "New Password",
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
                          outerLabelText: "Confirm New Password",
                          hintText: "Confirm New Password",
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
        child: ButtonCard("Save", defaultWidth - 2*24, mainColor, colorGradient: buttonGradient, onPressed: () async {
          modalBottomSheet(context, "");
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
          return ModalUpdatePasswordCard(token, fullWidth, 16, onSubmit: (){
            modalBottomSheetSuccess(contexts, token);
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
