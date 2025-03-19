part of "../pages.dart";

class OfficeAssetPage extends StatefulWidget {

  @override
  State<OfficeAssetPage> createState() => _OfficeAssetPageState();
}

class _OfficeAssetPageState extends State<OfficeAssetPage> {
  TextEditingController assetsC = TextEditingController();
  TextEditingController brandC = TextEditingController();
  TextEditingController warrantyC = TextEditingController();
  TextEditingController descriptionC = TextEditingController();
  TextEditingController phoneC = TextEditingController();

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
      title: "office_assets".trans(context),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "assets_information".trans(context),
                        textAlign: TextAlign.start,
                        style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 3),
                      Text(
                        "your_office".trans(context),
                        textAlign: TextAlign.start,
                        style: greyFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(height: 15),
                      Container(
                        width: defaultWidth - 2*defaultMargin3,
                        height: defaultWidth - 2*defaultMargin3 - 75,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                              image: AssetImage("${prefixImages}img_laptop.png"))
                        ),
                      ),
                      SizedBox(height: 15),
                      FormWithLabelCard(
                          outerLabelText: "asset_name".trans(context),
                          hintText: "Enter ${"asset_name".trans(context)}",
                          controller: assetsC,
                          prefixSvg: "${prefixIcons}ic_form_assets.svg",
                          onSaved: (e) {
                            assetsC.text = e ?? "";
                          },
                          validator: (e) {
                            return simpleValidator(e, null);
                          },
                          filled: true),
                      SizedBox(height: 20),
                      FormWithLabelCard(
                          outerLabelText: "brand".trans(context),
                          hintText: "Enter ${"brand".trans(context)}",
                          controller: brandC,
                          prefixSvg: "${prefixIcons}ic_form_brand.svg",
                          onSaved: (e) {
                            brandC.text = e ?? "";
                          },
                          validator: (e) {
                            return simpleValidator(e, null);
                          },
                          filled: true),
                      SizedBox(height: 20),
                      FormWithLabelCard(
                          outerLabelText: "warranty".trans(context),
                          hintText: "Enter ${"warranty".trans(context)}",
                          controller: warrantyC,
                          prefixSvg: "${prefixIcons}ic_form_status.svg",
                          onSaved: (e) {
                            warrantyC.text = e ?? "";
                          },
                          validator: (e) {
                            return simpleValidator(e, null);
                          },
                          filled: true),
                      SizedBox(height: 20),
                      FormWithLabelCard(
                          outerLabelText: "buying".trans(context),
                          hintText: "Enter ${"buying".trans(context)}",
                          controller: warrantyC,
                          prefixSvg: "${prefixIcons}ic_form_buying.svg",
                          onSaved: (e) {
                            warrantyC.text = e ?? "";
                          },
                          validator: (e) {
                            return simpleValidator(e, null);
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
        child: ButtonCard("save".trans(context), defaultWidth - 2*24, mainColor, colorGradient: buttonGradient, onPressed: () async {

        }),
      ),
    );
  }
}
