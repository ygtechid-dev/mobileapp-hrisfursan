part of '../pages.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    double defaultWidth = MediaQuery.of(context).size.width - 2*defaultMargin2;
    double fullWidth = MediaQuery.of(context).size.width;

    return GeneralPage(
      title: "",
      isAppBarCircular: true,
      appBarColorGradient: backgroundGradient,
      heightAppBar: 210,
      backColor: "F1F3F8".toColor(),
      child: Container(
        height: MediaQuery.of(context).size.height - 80,
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
                                  "CONTACT",
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
                                      ButtonHorizontalProfileCard(defaultWidth-2*defaultMargin2, "AdamS@work.com", "ic_mail_fill.svg", mainColor),
                                      ButtonHorizontalProfileCard(defaultWidth-2*defaultMargin2, "Indonesia, Jakarta Selatan", "ic_location_fill.svg", mainColor),
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
                                  "ACCOUNT",
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
                                      ButtonHorizontalProfileCard(defaultWidth-2*defaultMargin2, "Personal Data", "ic_user_fill.svg", mainColor),
                                      ButtonHorizontalProfileCard(defaultWidth-2*defaultMargin2, "Office Assets", "ic_folder_fill.svg", mainColor),
                                      ButtonHorizontalProfileCard(defaultWidth-2*defaultMargin2, "Payroll & Tax", "ic_payroll_fill.svg", mainColor),
                                      ButtonHorizontalProfileCard(defaultWidth-2*defaultMargin2, "Change Password", "ic_setting_fill.svg", mainColor),
                                      ButtonHorizontalProfileCard(defaultWidth-2*defaultMargin2, "Resign", "ic_note_fill.svg", mainColor),
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
                                      ButtonHorizontalProfileCard(defaultWidth-2*defaultMargin2, "Versioning", "ic_version_fill.svg", mainColor),
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
                  child: Column(
                    children: [
                      Text(
                        "My Profile",
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
                        "Adam Sudjana",
                        textAlign: TextAlign.center,
                        style: blackFontStyle.copyWith(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "Graphic Design",
                        textAlign: TextAlign.center,
                        style: blackFontStyle.copyWith(fontSize: 13, color: mainColor, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              ]
          )
      ),
    );
  }
}
