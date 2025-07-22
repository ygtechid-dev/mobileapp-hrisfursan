part of 'shared.dart';

Color mainColor = "0066EB".toColor();
Color primaryColor = "01CCAA".toColor();
Color primaryUnactiveColor = "ECE2D0".toColor();
Color secondaryColor = "01CCAA".toColor();
Color tersierColor = "5882CA".toColor();
Color greyColor = "A4A4A4".toColor();
Color greyColor2 = "F1F1F1".toColor();
Color blueFBColor = "3B5998".toColor();
Color blackColor = "101828".toColor();
Color lightYellowColor = "F9D1D1".toColor();
Color greyYellowColor = "F7F7F7".toColor();
Color lightMainColor = "D8E4FD".toColor();
Color lightDashboardColor = "F8F9FE".toColor();
Color lightGreyColor = "F2F2F2".toColor();
Color lightMainColor2 = "E5D7F6".toColor();
Color orangeColor = "D67F2F".toColor();
Color dangerColor = "DD7070".toColor();

Gradient backgroundGradient = LinearGradient(
  colors: [
    Color(0xFF01CCAA),
    Color(0xFF0066EB),
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  tileMode: TileMode.clamp,
);

Gradient buttonGradient = LinearGradient(
  colors: [
    Color(0xFF5F9EF3),
    Color(0xFF0066EB),
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  tileMode: TileMode.clamp,
);

Gradient buttonGradientGrey = LinearGradient(
  colors: [
    Color(0xFF9D9D9D),
    Color(0xFFA9A9A9),
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  tileMode: TileMode.clamp,
);

// Color mainColor = "E3B626".toColor();
// Color lightYellowColor = "F9EFD1".toColor();
Color bcgGreyColor = "F8F8F8".toColor();
Color bcgPrimaryBlackColor = "FAFAFF".toColor();
Color bcgSecondaryBlackColor = "221E1C".toColor();
Color bcgGreyColor2 = "E0E0E0".toColor();

Color bcgRedColor = "F8F8F8".toColor();
Widget loadingIndicator = CircularProgressIndicator(
    color: mainColor
);

Widget loadingIndicatorButton = SizedBox(
  height: 20,
  width: 20,
  child: CircularProgressIndicator(
      color: mainColor
  )
);

Widget loadingIndicatorButtonWhite = SizedBox(
    height: 20,
    width: 20,
    child: CircularProgressIndicator(
        color: Colors.white
    )
);

Widget loadingIndicatorWhite = CircularProgressIndicator(
    color: Colors.white
);

TextStyle greyFontStyle = GoogleFonts.inter().copyWith(color: greyColor);
TextStyle blackFontStyle = GoogleFonts.inter().copyWith(color: blackColor, fontSize: 12, fontWeight: FontWeight.w400);
TextStyle blackFontStyle2 = GoogleFonts.inter().copyWith(color: blackColor, fontSize: 14, fontWeight: FontWeight.w500);
TextStyle blackFontStyle3 = GoogleFonts.inter().copyWith(color: blackColor, fontSize: 18, fontWeight: FontWeight.w600);

TextStyle whiteFontStyle = GoogleFonts.inter().copyWith( fontSize: 14, fontWeight: FontWeight.w500);

TextStyle yellowFontStyle = GoogleFonts.inter().copyWith(color: mainColor, fontSize: 12, fontWeight: FontWeight.w400);

const double defaultMargin = 32;
const double defaultMargin2 = 16;
const double defaultMargin3 = 12;

String? token_message_flutter;

List<BoxShadow> boxShadowBlue = [
  BoxShadow(
    color: Colors.blue.withOpacity(0.2),
    spreadRadius: 0,
    blurRadius: 2,
    offset: Offset(0, -2),
  )
];

List<BoxShadow> boxShadow = [
  BoxShadow(
    color: Colors.grey.withOpacity(0.2),
    spreadRadius: 0,
    blurRadius: 2,
    offset: Offset(0, 0),
  )
];

List<BoxShadow> boxShadowTextField = [
  BoxShadow(
    color: Colors.grey.withOpacity(0.5),
    spreadRadius: 0,
    blurRadius: 5,
    offset: Offset(0, 5),
  )
];

List<BoxShadow> boxShadowButtonDefault = [
  BoxShadow(
    color: "D32626".toColor().withOpacity(0.25),
    spreadRadius: 0,
    blurRadius: 8,
    offset: Offset(0, 4),
  )
];

const _shimmerGradient = LinearGradient(
  colors: [
    Color(0xFFEBEBF4),
    Color(0xFFF4F4F4),
    Color(0xFFEBEBF4),
  ],
  stops: [
    0.1,
    0.3,
    0.4,
  ],
  begin: Alignment(-1.0, -0.3),
  end: Alignment(1.0, 0.3),
  tileMode: TileMode.clamp,
);

List<String> listTemp = ['','','','',''];
