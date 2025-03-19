part of '../../pages.dart';

class ClockInPage extends StatefulWidget {
  final String token;

  ClockInPage(this.token);

  @override
  State<ClockInPage> createState() => _ClockInPageState();
}

class _ClockInPageState extends State<ClockInPage> {

  MapController mapController = MapController(
    // initMapWithUserPosition: UserTrackingOption(
    //   enableTracking: true
    // ),
    initPosition: GeoPoint(latitude: 47.4358055, longitude: 8.4737324),
    // areaLimit: BoundingBox( east: 10.4922941, north: 47.8084648, south: 45.817995, west: 5.9559113,),
  );

  GeoPoint? selectedPoint;

  Future<void> getPoint() async {
    selectedPoint = await mapController.myLocation();
  }

  String? _timeString;

  @override
  void initState() {
    getPoint();

    _timeString = _formatDateTime(DateTime.now());
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    super.initState();
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    setState(() {
      _timeString = formattedDateTime;
    });
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('h:mm:ss a').format(dateTime);
  }

  Future<bool> _onWillPop() async {
    Get.to(MainPage(token: widget.token));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    double defaultWidth = MediaQuery.of(context).size.width - 2*defaultMargin2;
    double defaultHeight = MediaQuery.of(context).size.width + 100;
    double itemWidth = MediaQuery.of(context).size.width - 2*defaultMargin3;
    double fullWidth = MediaQuery.of(context).size.width;

    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd MMMM yyyy').format(now);

    return WillPopScope(
      onWillPop: _onWillPop,
      child: GeneralPage(
        statusBarColor: Colors.white,
        isBackInvert: false,
        isFrontAppBar: true,
        marginAppBar: 0,
        title: "clockin_area".trans(context),
        onBackButtonPressed: (){
          Get.to(MainPage(token: widget.token));
        },
        appBarColor: Colors.white.withOpacity(0.5),
        child: Container(
          width: fullWidth,
          height: defaultHeight,
          child: OSMFlutter(
              controller: mapController,
              onLocationChanged: (value){
                setState(() {
                  selectedPoint = value;
                });
              },
              osmOption: OSMOption(
                userTrackingOption: UserTrackingOption(
                  enableTracking: true,
                  unFollowUser: false,
                ),
                zoomOption: ZoomOption(
                  initZoom: 17,
                  minZoomLevel: 3,
                  maxZoomLevel: 19,
                  stepZoom: 1.0,
                ),
                userLocationMarker: UserLocationMaker(
                  personMarker: MarkerIcon(
                    iconWidget: Image.asset("${prefixImages}img_radius.png", width: 300, height: 300,),
                    // icon: Icon(
                    //   Icons.location_history_rounded,
                    //   color: mainColor,
                    //   size: 48,
                    // ),
                  ),
                  directionArrowMarker: MarkerIcon(
                    iconWidget: Image.asset("${prefixImages}img_radius.png", width: 300, height: 300,),
                  ),
                ),
                roadConfiguration: RoadOption(
                  roadColor: Colors.yellowAccent,
                ),
                // markerOption: MarkerOption(
                //     defaultMarker: MarkerIcon(
                //       icon: Icon(
                //         Icons.person_pin_circle,
                //         color: Colors.blue,
                //         size: 56,
                //       ),
                //     )
                // ),
              )
          )
          ,
        ),
        navBar: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
                width: fullWidth,
                padding: EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 100),
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
                          "my_profile".trans(context),
                          textAlign: TextAlign.start,
                          style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                          width: fullWidth - 2*15,
                          padding: EdgeInsets.symmetric(vertical: 11, horizontal: 12),
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
                              BlocBuilder<UserCubit, UserState>(
                                  builder: (context, state) => (state is UserLoaded) ? (state.user != null) ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${state.user!.first_name} ${state.user!.last_name}",
                                        textAlign: TextAlign.start,
                                        style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(height: 2),
                                      Text(
                                        "${formattedDate}",
                                        textAlign: TextAlign.start,
                                        style: blackFontStyle.copyWith(fontSize: 12, color: mainColor, fontWeight: FontWeight.w400),
                                      ),
                                      SizedBox(height: 7),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Icon(Icons.location_on_rounded, color: mainColor, size: 12),
                                            SizedBox(width: 5),
                                            Container(
                                              width: fullWidth - 2*15 - 2*12 - 100 - 5 - 15 - 10,
                                              child: Text(
                                                (selectedPoint != null) ? "Lat ${selectedPoint!.latitude} Long ${selectedPoint!.longitude}" : "-",
                                                textAlign: TextAlign.start,
                                                style: blackFontStyle.copyWith(fontSize: 11, fontWeight: FontWeight.w600),
                                              ),
                                            )
                                          ]
                                      )
                                    ],
                                  ) : SizedBox() : loadingIndicator
                              ),

                            ],
                          )
                      ),
                      SizedBox(height: 15),
                      Container(
                        width: fullWidth - 2*15,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "schedule".trans(context),
                          textAlign: TextAlign.start,
                          style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                          width: fullWidth - 2*15,
                          padding: EdgeInsets.symmetric(vertical: 11, horizontal: 12),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: "F9FAFB".toColor(),
                            border: Border.all(color: "EAECF0".toColor()),
                            borderRadius: BorderRadius.vertical(top: Radius.circular(5)),
                          ),
                          child: Column(
                              children: [
                                Text(
                                  "clockin".trans(context),
                                  textAlign: TextAlign.center,
                                  style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  "${_timeString}",
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
              child: ButtonCard("selfie_to".trans(context), defaultWidth - 2*24, mainColor, colorGradient: buttonGradient, onPressed: () async {

                if(selectedPoint != null){
                  try {
                    List<Placemark> placemarks = await placemarkFromCoordinates(
                        selectedPoint!.latitude,
                        selectedPoint!.longitude,
                        localeIdentifier: "id"
                    );

                    print("LOKASI " + placemarks[0].toString());

                    List<String> jj = placemarks[0].subAdministrativeArea!.split(' ');

                    String kota = placemarks[0].subAdministrativeArea!.replaceAll('Kota ', '').replaceAll(' City', '');

                    String cc = placemarks[0]!.administrativeArea!;

                    String provinsi = cc;

                    String jalan = placemarks[0].street ?? "";
                    String country = placemarks[0].country ?? "";

                    String location = "${jalan} ${kota}, ${provinsi}, ${country}";

                    Get.to(ClockInCameraPage(widget.token, "${selectedPoint!.latitude}", "${selectedPoint!.longitude}", location));

                  } catch(err){

                    // await context.read<PrayerCubit>().getPrayer("", "");

                  }


                }


              }),
            )
          ],
        ),
      )
    );
  }
}
