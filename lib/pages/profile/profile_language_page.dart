part of "../pages.dart";

class ProfileLanguagePage extends StatefulWidget {
  final String token;

  ProfileLanguagePage(this.token);

  @override
  State<ProfileLanguagePage> createState() => _ProfileLanguagePageState();
}

class _ProfileLanguagePageState extends State<ProfileLanguagePage> {

  List<List<String>> listData = [
    ["en", "English", "ic_language_english.png"],
    ["id", "Indonesian", "ic_language_indonesian.png"],
    ["ms", "Melayu", "ic_language_melayu.png"],
    ["ar", "Arabic", "ic_language_arabic.png"],
  ];

  String? selectedData;

  @override
  void initState() {
    if(context.read<LocalCubit>().currentLanguage == "en"){
      selectedData = listData[0][0];
    }

    if(context.read<LocalCubit>().currentLanguage == "id"){
      selectedData = listData[1][0];
    }

    if(context.read<LocalCubit>().currentLanguage == "ms"){
      selectedData = listData[2][0];
    }

    if(context.read<LocalCubit>().currentLanguage == "ar"){
      selectedData = listData[3][0];
    }

    super.initState();
  }

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
      title: "language".trans(context),
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
                        "choose_language".trans(context),
                        textAlign: TextAlign.start,
                        style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 3),
                      Text(
                        "select_language".trans(context),
                        textAlign: TextAlign.start,
                        style: greyFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(height: 20),
                      Column(
                        children: listData.map((e) => LanguageCard2(defaultWidth, e[1], e[2], isSelected: (selectedData == e[0]), onSelected: (value){
                          setState((){
                            selectedData = e[0];
                          });


                        })).toList(),
                      ),
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
          await context.read<LocalCubit>().changeLanguage("${selectedData}");
          Get.to(MainPage(token: widget.token, index_: 4,));
        }),
      ),
    );
  }
}
