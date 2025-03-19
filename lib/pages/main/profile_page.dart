part of '../pages.dart';

class ProfilePage extends StatefulWidget {
  final String token;

  ProfilePage(this.token);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  bool isLoading = false;

  Future<bool> logout() async {
    return (kIsWeb) ? true : (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('are_you_sure'.trans(context)),
        content: new Text('doyouwantlogout'.trans(context)),
        actions: <Widget>[
          new MaterialButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('no'.trans(context)),
          ),
          new MaterialButton(
            onPressed: () async {

              setState(() {
                isLoading = true;
              });

              await UserServices.logout(widget.token).then((result) async {

                Fluttertoast.showToast(
                    msg: "${result.value}",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0
                );

                SharedPreferences prefs = await SharedPreferences.getInstance().whenComplete(() async {

                });

                if (prefs.getString('token') != null) {
                  await prefs.setString('token', "").whenComplete(() {
                    Navigator.of(context)
                        .pop(false);
                    Get.to(SignInPage());

                    setState(() {
                      isLoading = false;
                    });
                  });
                }
              });
            },
            child: new Text('yes'.trans(context)),
          ),
        ],
      ),
    )) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    double defaultWidth = MediaQuery.of(context).size.width - 2*defaultMargin2;
    double fullWidth = MediaQuery.of(context).size.width;

    return LoadingOverlay(
        progressIndicator: loadingIndicator,
        isLoading: isLoading,
        child: GeneralPage(
      title: "",
      isAppBarCircular: true,
      appBarColorGradient: backgroundGradient,
      heightAppBar: 210,
      backColor: "F1F3F8".toColor(),
      child: Container(
          height: MediaQuery.of(context).size.height + 110,
          child: Stack(
              children: [
                Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                        width: fullWidth,
                        padding: EdgeInsets.symmetric(vertical: 0, horizontal: defaultMargin2),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                        ),
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 120),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "contact".trans(context),
                                  textAlign: TextAlign.start,
                                  style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w600),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  width: defaultWidth,
                                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: defaultMargin2),
                                  decoration: BoxDecoration(
                                    color: "F6F6F6".toColor(),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: BlocBuilder<UserCubit, UserState>(
                                      builder: (context, state) => (state is UserLoaded) ? (state.user != null) ? Column(
                                        children: [
                                          ButtonHorizontalProfileCard(defaultWidth-2*defaultMargin2, "${state.user!.email}", "ic_mail_fill.svg", mainColor),
                                          ButtonHorizontalProfileCard(defaultWidth-2*defaultMargin2, "Indonesia, Jakarta Selatan", "ic_location_fill.svg", mainColor),
                                        ],
                                      ) : SizedBox() : loadingIndicator
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "account_caps".trans(context),
                                  textAlign: TextAlign.start,
                                  style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w600),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  width: defaultWidth,
                                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: defaultMargin2),
                                  decoration: BoxDecoration(
                                    color: "F6F6F6".toColor(),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    children: [
                                      ButtonHorizontalProfileCard(defaultWidth-2*defaultMargin2, "personal_data".trans(context), "ic_user_fill.svg", mainColor, onTap: (){
                                        Get.to(ProfileEditPage(widget.token));
                                      }),
                                      ButtonHorizontalProfileCard(defaultWidth-2*defaultMargin2, "office_assets".trans(context), "ic_folder_fill.svg", mainColor, onTap: (){
                                        Get.to(OfficeAssetPage());
                                      }),
                                      ButtonHorizontalProfileCard(defaultWidth-2*defaultMargin2, "payroll_tax".trans(context), "ic_payroll_fill.svg", mainColor, onTap: (){
                                        // Get.to(ProfileEditPage());
                                      }),
                                      ButtonHorizontalProfileCard(defaultWidth-2*defaultMargin2, "resign".trans(context), "ic_resign.svg", mainColor, onTap: (){
                                        Get.to(FormResignPage());
                                      }),
                                      ButtonHorizontalProfileCard(defaultWidth-2*defaultMargin2, "language".trans(context), "ic_language.svg", mainColor, onTap: (){
                                        Get.to(ProfileLanguagePage(widget.token));
                                      }),
                                      ButtonHorizontalProfileCard(defaultWidth-2*defaultMargin2, "change_password".trans(context), "ic_setting_fill.svg", mainColor, onTap: (){
                                        Get.to(PasswordPage());
                                      }),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "SETTINGS",
                                  textAlign: TextAlign.start,
                                  style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w600),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  width: defaultWidth,
                                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: defaultMargin2),
                                  decoration: BoxDecoration(
                                    color: "F6F6F6".toColor(),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    children: [
                                      ButtonHorizontalProfileCard(defaultWidth-2*defaultMargin2, "versioning".trans(context), "ic_version_fill.svg", mainColor),
                                      ButtonHorizontalProfileCard(defaultWidth-2*defaultMargin2, "faq_help".trans(context), "ic_faq.svg", mainColor),
                                      ButtonHorizontalProfileCard(defaultWidth-2*defaultMargin2, "logout".trans(context), "ic_logout.svg", Colors.red, onTap: () async {
                                        await logout();
                                      },),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 40),
                          ],
                        )
                    )
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: BlocBuilder<UserCubit, UserState>(
                      builder: (context, state) => (state is UserLoaded) ? (state.user != null) ? Column(
                        children: [
                          Text(
                            "my_profile".trans(context),
                            textAlign: TextAlign.center,
                            style: blackFontStyle.copyWith(fontSize: 22, color: Colors.white, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 15),
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                                color: CupertinoColors.systemGrey2,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: mainColor),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage("${prefixImages}img_avatar_dummy.png")
                                )
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "${state.user!.first_name} ${state.user!.last_name}",
                            textAlign: TextAlign.center,
                            style: blackFontStyle.copyWith(fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "Graphic Design",
                            textAlign: TextAlign.center,
                            style: blackFontStyle.copyWith(fontSize: 13, color: mainColor, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ) : SizedBox() : loadingIndicator
                  ),
                ),
              ]
          )
      ),
    )
    );
  }
}
