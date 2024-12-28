part of '../pages.dart';

class PersonalDataPage extends StatefulWidget {
  const PersonalDataPage({super.key});

  @override
  State<PersonalDataPage> createState() => _PersonalDataPageState();
}

class _PersonalDataPageState extends State<PersonalDataPage> {
  TextEditingController firstNameC = TextEditingController();
  TextEditingController lastNameC = TextEditingController();
  TextEditingController dateC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  TextEditingController positionC = TextEditingController();
  TextEditingController addressC = TextEditingController();


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
      title: "Personal Data",
        onBackButtonPressed: (){
          Get.back();
        },
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
                        Container(
                          width: itemWidth,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "My Personal Data",
                            textAlign: TextAlign.start,
                            style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(height: 3),
                        Container(
                          width: itemWidth,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Details about my personal data",
                            textAlign: TextAlign.start,
                            style: greyFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                          ),
                        ),
                        SizedBox(height: 5),
                        Container(
                          height: 116,
                            width: 116,
                          margin: EdgeInsets.only(left: 16),
                          child: Stack(
                            children: [
                              Positioned(
                                bottom: 0,
                                  left: 0,
                                  child: Container(
                                    width: 100,
                                    height: 100,
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
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: SvgPicture.asset("${prefixIcons}ic_suffle.svg", width: 32, height: 32,),
                              )

                            ],
                          )
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Upload Photo",
                          textAlign: TextAlign.center,
                          style: greyFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Format should be in .jpeg .png atleast\n800x800px and less than 5MB",
                          textAlign: TextAlign.center,
                          style: greyFontStyle.copyWith(fontSize: 10, fontWeight: FontWeight.w400),
                        ),

                        FormWithLabelCard(
                            outerLabelText: "First Name",
                            hintText: "Input First Name",
                            controller: firstNameC,
                            prefixSvg: "${prefixIcons}ic_user.svg",
                            onSaved: (e) {
                              firstNameC.text = e ?? "";
                            },
                            validator: (e) {
                              return simpleValidator(e, null);
                            },
                            filled: true),
                        SizedBox(height: 20),
                        FormWithLabelCard(
                            outerLabelText: "Last Name",
                            hintText: "Input Last Name",
                            controller: lastNameC,
                            prefixSvg: "${prefixIcons}ic_user.svg",
                            onSaved: (e) {
                              lastNameC.text = e ?? "";
                            },
                            validator: (e) {
                              return simpleValidator(e, null);
                            },
                            filled: true),
                        SizedBox(height: 20),
                        FormWithLabelCard(
                            outerLabelText: "Phone Number",
                            hintText: "+62 0000 0000 0000",
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
                            outerLabelText: "Date of Birth",
                            hintText: "Input Date of Birth",
                            controller: dateC,
                            prefixSvg: "${prefixIcons}ic_calendar.svg",
                            onSaved: (e) {
                              dateC.text = e ?? "";
                            },
                            validator: (e) {
                              return simpleValidator(e, null);
                            },
                            filled: true),
                        SizedBox(height: 20),
                        FormDropdownCard(
                            outerLabelText: "Position",
                            hintText: "Enter Position",
                            listItem: [],
                            prefixSvg: "${prefixIcons}ic_position.svg",
                            onSaved: (e) {

                            },
                            validator: (e) {
                              return simpleValidator(e, null);
                            },
                            filled: true),
                      ],
                    )
                ),
                SizedBox(height: 20),
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
                        Container(
                          width: itemWidth,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Address",
                            textAlign: TextAlign.start,
                            style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(height: 3),
                        Container(
                          width: itemWidth,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Your current domicile",
                            textAlign: TextAlign.start,
                            style: greyFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                          ),
                        ),
                        SizedBox(height: 20),
                        FormDropdownCard(
                            outerLabelText: "Country",
                            hintText: "Enter Country",
                            listItem: [],
                            prefixSvg: "${prefixIcons}ic_location.svg",
                            onSaved: (e) {

                            },
                            validator: (e) {
                              return simpleValidator(e, null);
                            },
                            filled: true),
                        SizedBox(height: 20),
                        FormDropdownCard(
                            outerLabelText: "State",
                            hintText: "Enter State",
                            listItem: [],
                            prefixSvg: "${prefixIcons}ic_location.svg",
                            onSaved: (e) {

                            },
                            validator: (e) {
                              return simpleValidator(e, null);
                            },
                            filled: true),
                        SizedBox(height: 20),
                        FormDropdownCard(
                            outerLabelText: "City",
                            hintText: "Enter City",
                            listItem: [],
                            prefixSvg: "${prefixIcons}ic_location.svg",
                            onSaved: (e) {

                            },
                            validator: (e) {
                              return simpleValidator(e, null);
                            },
                            filled: true),
                        SizedBox(height: 20),
                        FormWithLabelCard(
                            outerLabelText: "Full Address",
                            hintText: "Input Full Address",
                            controller: addressC,
                            minLines: 6,
                            maxLines: 6,
                            onSaved: (e) {
                              addressC.text = e ?? "";
                            },
                            validator: (e) {
                              return simpleValidator(e, null);
                            },
                            filled: true),
                        SizedBox(height: 60,)
                      ],
                    )
                ),
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
          Get.to(MainPage());
        }),
      ),
    );
  }
}
