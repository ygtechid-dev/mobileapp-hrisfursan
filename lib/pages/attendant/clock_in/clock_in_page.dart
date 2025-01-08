part of '../../pages.dart';

class ClockInPage extends StatefulWidget {
  const ClockInPage({super.key});

  @override
  State<ClockInPage> createState() => _ClockInPageState();
}

class _ClockInPageState extends State<ClockInPage> {

  MapController mapController = MapController(
    initMapWithUserPosition: true,
    initPosition: GeoPoint(latitude: 47.4358055, longitude: 8.4737324),
    areaLimit: BoundingBox( east: 10.4922941, north: 47.8084648, south: 45.817995, west: 5.9559113,),
  );


  @override
  Widget build(BuildContext context) {
    double defaultWidth = MediaQuery.of(context).size.width - 2*defaultMargin2;
    double defaultHeight = MediaQuery.of(context).size.width - 200;
    double itemWidth = MediaQuery.of(context).size.width - 2*defaultMargin3;
    double fullWidth = MediaQuery.of(context).size.width;

    return GeneralPage(
      statusBarColor: mainColor,
      isBackInvert: false,
      isFrontAppBar: true,
      marginAppBar: 65,
      title: "Clock In Area",
      onBackButtonPressed: (){
        Get.back();
      },
      appBarColor: Colors.transparent,
      child: Container(
          width: fullWidth,
          height: defaultHeight,
          child: OSMFlutter(
            controller: mapController,
            trackMyPosition: true,
            initZoom: 12,
            minZoomLevel: 8,
            maxZoomLevel: 14,
            stepZoom: 1.0,
            userLocationMarker: UserLocationMaker(
              personMarker: MarkerIcon(
                icon: Icon(
                  Icons.location_history_rounded,
                  color: Colors.red,
                  size: 48,
                ),
              ),
              directionArrowMarker: MarkerIcon(
                icon: Icon(
                  Icons.double_arrow,
                  size: 48,
                ),
              ),
            ),
            road: Road(
              startIcon: MarkerIcon(
                icon: Icon(
                  Icons.person,
                  size: 64,
                  color: Colors.brown,
                ),
              ),
              roadColor: Colors.yellowAccent,
            ),
            markerOption: MarkerOption(
                defaultMarker: MarkerIcon(
                  icon: Icon(
                    Icons.person_pin_circle,
                    color: Colors.blue,
                    size: 56,
                  ),
                )
            ),
          )
        ,
      ),
      navBar: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: fullWidth,
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                boxShadow: boxShadow,
            ),
            child: Column(
              children: [
                Container(
                  width: fullWidth - 2*15,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "MY PROFILE",
                    textAlign: TextAlign.start,
                    style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                    width: fullWidth - 2*15,
                    padding: EdgeInsets.symmetric(vertical: 10.5, horizontal: 12),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: "F9FAFB".toColor(),
                      border: Border.all(color: "EAECF0".toColor()),
                      borderRadius: BorderRadius.vertical(top: Radius.circular(5)),
                    ),
                    child: Row(
                      children: [
                        Container(
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
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Adam Sudjana",
                              textAlign: TextAlign.start,
                              style: blackFontStyle.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 2),
                            Text(
                              "22 December 2024",
                              textAlign: TextAlign.start,
                              style: blackFontStyle.copyWith(fontSize: 12, color: mainColor, fontWeight: FontWeight.w400),
                            ),
                            SizedBox(height: 7),
                            Row(
                              children: [
                                Icon(Icons.location_on_rounded, color: mainColor, size: 12),
                                SizedBox(width: 5),
                                Text(
                                  "Lat 45.43534 Long 97897.576",
                                  textAlign: TextAlign.start,
                                  style: blackFontStyle.copyWith(fontSize: 11, fontWeight: FontWeight.w600),
                                ),
                              ]
                            )
                          ],
                        )
                      ],
                    )
                ),
                SizedBox(height: 15),
                Container(
                  width: fullWidth - 2*15,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "SCHEDULE",
                    textAlign: TextAlign.start,
                    style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                    width: fullWidth - 2*15,
                    padding: EdgeInsets.symmetric(vertical: 10.5, horizontal: 12),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: "F9FAFB".toColor(),
                      border: Border.all(color: "EAECF0".toColor()),
                      borderRadius: BorderRadius.vertical(top: Radius.circular(5)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "CLOCK IN",
                          textAlign: TextAlign.center,
                          style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          "09:00:02 AM",
                          textAlign: TextAlign.center,
                          style: blackFontStyle.copyWith(fontSize: 24, fontWeight: FontWeight.w600),
                        ),
                      ]
                    )
                ),
              ]
            )
          ),
          Container(
            width: fullWidth,
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: boxShadow
            ),
            child: ButtonCard("Selfie To Clock In", defaultWidth - 2*24, mainColor, colorGradient: buttonGradient, onPressed: () async {
                Get.to(ClockInCameraPage());
            }),
          )
        ],
      ),
    );
  }
}
