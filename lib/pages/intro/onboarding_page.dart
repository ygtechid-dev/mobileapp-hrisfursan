part of "../pages.dart";

class OnboardingPage extends StatefulWidget {

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    double defaultWidth = MediaQuery.of(context).size.width - 2*defaultMargin2;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: false,
        bottom: false,
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      alignment: Alignment.topCenter,
                      fit: BoxFit.fitWidth,
                      image: AssetImage("${prefixImages}bcg_onboarding.png")
                  )
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 55),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      width: 210,
                      height: 50,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.contain,
                            image: AssetImage("${prefixImages}img_logo_horizontal.png")
                        ),
                      )
                  ),
                  SvgPicture.asset("${prefixIcons}img_illustration_intro.svg", width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.width),
                  Column(
                      children: [
                        Text(
                          "Human Resource\nIntergrated System",
                          textAlign: TextAlign.center,
                          style: blackFontStyle.copyWith(fontSize: 24, fontWeight: FontWeight.w600),
                        ),
                        // SizedBox(height: 3),
                        // Text(
                        //   "lorem ipsum",
                        //   textAlign: TextAlign.start,
                        //   style: greyFontStyle.copyWith(fontSize: 13, fontWeight: FontWeight.w400),
                        // ),
                      ]
                  ),
                  ButtonCard("next".trans(context), defaultWidth, mainColor, colorGradient: buttonGradient, onPressed: () async {
                    Get.to(LanguagePage());
                  }),
                ],
              )
            )
          ]
        ),
      ),
    );
  }
}
