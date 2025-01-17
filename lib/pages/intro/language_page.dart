part of '../pages.dart';

class LanguagePage extends StatefulWidget {

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {

  List<List<String>> listData = [
    ["English", "ic_language_english.png"],
    ["Indonesian", "ic_language_indonesian.png"],
    ["Melayu", "ic_language_melayu.png"],
    ["Arabic", "ic_language_arabic.png"],
  ];

  String? selectedData;

  @override
  Widget build(BuildContext context) {
    double defaultWidth = MediaQuery.of(context).size.width - 2*defaultMargin;
    double fullWidth = MediaQuery.of(context).size.width;

    return GeneralPage(
      title: "",
      isAppBarCircular: true,
      appBarColorGradient: backgroundGradient,
      heightAppBar: 500,
      marginAppBar: 0,
      child: Container(
          height: MediaQuery.of(context).size.height - 10,
          child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: 20,
                  child: Container(
                    width: 300,
                    height: 300,
                    alignment: Alignment.topCenter,
                    child: SvgPicture.asset("${prefixIcons}img_illustration_language.svg", width: 300, height: 300,),
                  ),
                ),
                Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height - 300,
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
                              "Welcome",
                              textAlign: TextAlign.center,
                              style: blackFontStyle.copyWith(fontSize: 22, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 2),
                            Text(
                              "Choose your Language",
                              textAlign: TextAlign.center,
                              style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w400),
                            ),
                            SizedBox(height: 20),
                            Column(
                              children: listData.map((e) => LanguageCard(defaultWidth, e[0], e[1], isSelected: (selectedData == e[0]), onSelected: (value){
                                setState((){
                                  selectedData = value;
                                });

                              })).toList(),
                            ),
                            SizedBox(height: 10),
                            ButtonCard("Next", defaultWidth, mainColor, colorGradient: buttonGradient, onPressed: () async {
                              Get.to(SignInPage());
                            }),
                            SizedBox(height: 20),
                          ],
                        )
                    )
                ),
                Positioned(
                  top: 230,
                  width: 100,
                  height: 100,
                  child: Container(
                    width: 100,
                    height: 100,
                    padding: EdgeInsets.all(4),
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
}
