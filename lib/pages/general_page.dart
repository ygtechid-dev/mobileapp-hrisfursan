part of 'pages.dart';

class GeneralPage extends StatefulWidget {
  final String? title;
  final String? subtitle;
  final Function? onBackButtonPressed;
  final Widget? child;
  final Widget? navBar;
  final double? marginNavBar;
  final double? marginAppBar;
  final double? heightAppBar;
  final String? bcgImage;
  final bool? isCoverBcgImage;
  final bool? isReverse;
  final Color? backColor;
  final Color? statusBarColor;
  final Gradient? appBarColorGradient;
  final Color? appBarColor;
  final bool? shadow;
  final bool? isBordered;
  final bool? isBackInvert;
  final double? imageSize;
  final Widget? image;
  final bool? invert;
  final Widget? widgetAppBar;
  final Function? refresh;
  final Function? refreshFooter;
  final bool? scrollable;
  final bool? isCenterTitle;
  final bool? isBackgroundDefault;
  final bool? isAppBarCircular;
  final bool? isFrontAppBar;
  final Widget? drawer;
  final GlobalKey<ScaffoldState>? key;

  GeneralPage(
      {this.title,
      this.subtitle,
        this.key,
        this.isReverse = false,
        this.widgetAppBar,
      this.onBackButtonPressed,
        this.bcgImage,
      this.isBackInvert = true,
        this.isFrontAppBar = false,
        this.isCoverBcgImage = true,
        this.isBackgroundDefault = false,
      this.child,
      this.backColor,
      this.shadow = false,
        this.isBordered,
        this.heightAppBar = 170,
      this.image,
      this.imageSize,
      this.navBar,
        this.scrollable = true,
        this.statusBarColor,
        this.appBarColorGradient,
      this.marginNavBar = 0,
        this.isCenterTitle = true,
        this.isAppBarCircular = false,
        this.marginAppBar = 40,
      this.appBarColor,
        this.refreshFooter,
        this.drawer,
        this.refresh,
      this.invert = false});

  @override
  _GeneralPageState createState() => _GeneralPageState();
}

class _GeneralPageState extends State<GeneralPage>  {

  // _handleDeepLinks() async {
  //   final PendingDynamicLinkData initialLink =
  //   await FirebaseDynamicLinks.instance.getInitialLink();
  //   if (initialLink != null) {
  //     final Uri deepLink = initialLink.link;
  //     print('Deeplinks uri:${deepLink.path}');
  //
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     String token_data = await prefs.getString('token');
  //     await prefs.setString('referral', deepLink.path.replaceAll("/", ""));
  //
  //     if(token_data != null){
  //       UserServices.updateReferralCode(token_data, deepLink.path.replaceAll("/", ""));
  //     }
  //
  //     if (deepLink.path == '/ShowApiDataScreen') {
  //
  //     }
  //   }
  // }
  //
  // _handleTempDeepLink() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String token_data = await prefs.getString('token');
  //   String referral_code =  prefs.getString('referral');
  //
  //   if(token_data != null && prefs.getString('referral') != null){
  //     UserServices.updateReferralCode(token_data, referral_code);
  //   }
  //
  // }
  //
  // final List<AppLifecycleState> _stateHistoryList = <AppLifecycleState>[];
  //
  // @override
  // Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
  //   switch (state) {
  //     case AppLifecycleState.resumed:
  //
  //       _handleDeepLinks();
  //       _handleTempDeepLink();
  //
  //       break;
  //     case AppLifecycleState.inactive:
  //     case AppLifecycleState.paused:
  //     case AppLifecycleState.detached:
  //       _handleDeepLinks();
  //       _handleTempDeepLink();
  //       break;
  //   }
  // }
  //

  // @override
  // void initState() {
  //   super.initState();
  //
  //   WidgetsBinding.instance.addObserver(this);
  //
  //   if (WidgetsBinding.instance.lifecycleState != null) {
  //     _stateHistoryList.add(WidgetsBinding.instance.lifecycleState);
  //   }
  //
  //   _handleTempDeepLink();
  //   _handleDeepLinks();
  // }
  //
  // @override
  // void dispose() {
  //   WidgetsBinding.instance.removeObserver(this);
  //   super.dispose();
  // }

  var connectivityResult;
  Widget? child_refresh;
  String? title_refresh, subtitle_refresh;

  Future<void> checkConnectivity() async {
    connectivityResult = await (Connectivity().checkConnectivity());
  }

  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  void _onRefresh() async{
    // monitor network fetch

    await Future.delayed(Duration(milliseconds: 1000));

    if(widget.refresh != null){
      // ignore: unnecessary_statements

      widget.refresh!();
    }

    // widget.refresh();

    setState((){
      child_refresh = widget.child;
      title_refresh = widget.title;
      subtitle_refresh = widget.subtitle;
    });

    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onRefreshFooter() async{
    // monitor network fetch

    await Future.delayed(Duration(milliseconds: 1000));

    if(widget.refreshFooter != null){
      // ignore: unnecessary_statements

      widget.refreshFooter!();
    }

    // widget.refresh();

    setState((){
      child_refresh = widget.child;
      title_refresh = widget.title;
      subtitle_refresh = widget.subtitle;
    });

    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    // if(mounted)
    //   setState(() {
    //
    //   });
    _refreshController.loadComplete();
  }
  //
  // GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    // if (connectivityResult == ConnectivityResult.mobile) {
    //   // I am connected to a mobile network.
    // } else if (connectivityResult == ConnectivityResult.wifi) {
    //   // I am connected to a wifi network.
    // }



    setState((){
      child_refresh = widget.child;
      title_refresh = widget.title;
      subtitle_refresh = widget.subtitle;
    });

    // if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi){}
    return AnnotatedRegion<SystemUiOverlayStyle>(
        // key: (widget.key != null) ? widget.key : _scaffoldKey,
        value: SystemUiOverlayStyle(
          statusBarColor: (widget.statusBarColor != null) ? widget.appBarColor : Colors.transparent,
          statusBarBrightness: (widget.statusBarColor != null) ? Brightness.dark : Brightness.light, // For iOS: (dark icons)
          statusBarIconBrightness: (widget.statusBarColor != null) ? Brightness.dark : Brightness.light
        ),

        child: Scaffold(
          key: (widget.key != null) ? widget.key : null,
          drawerScrimColor: Colors.black54,
          resizeToAvoidBottomInset: true,
          drawerEnableOpenDragGesture: false, endDrawerEnableOpenDragGesture: false,
          // drawerEdgeDragWidth: MediaQuery.of(context).size.width - 40,
          drawer: (widget.drawer != null) ? Container(
            // color: bcgPrimaryBlackColor,
            // padding: EdgeInsets.symmetric(vertical: 25, horizontal: defaultMargin),
            width: MediaQuery.of(context).size.width - 40,
            child: Drawer(
              elevation: 0,
              child: widget.drawer,
            ),
          ) : SizedBox(),
          body: Stack(
            children: [
              Container(
                color: (kIsWeb) ? (widget.statusBarColor ?? mainColor) : ((Platform.isIOS) ? mainColor : widget.statusBarColor ?? Colors.transparent),
              ),
              (widget.bcgImage != null)
                  ? SafeArea(
                top: false,
                bottom: false,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: double.infinity,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          alignment: Alignment.center,
                          fit: (widget.isCoverBcgImage == true) ? BoxFit.cover : BoxFit.fill,
                          image: AssetImage("${widget.bcgImage}")
                      )
                  ),
                ),
              )
                  : SafeArea(
                bottom: false,
                child: Container(
                  color: widget.backColor ?? bcgPrimaryBlackColor,
                ),
              ),
              SafeArea(
                  top: (widget.statusBarColor != null) ? false : false,
                  bottom: true,
                  child: Stack(
                    children: [
                      (widget.isFrontAppBar == false) ? Positioned(
                        top: MediaQuery.of(context).viewInsets.top,
                        left: 0,
                        right: 0,
                        child: Container(
                          child: (widget.title != null) ? (widget.widgetAppBar != null) ? Container(
                            margin: EdgeInsets.only(bottom: 0),
                            padding: EdgeInsets.only(left: defaultMargin, right: defaultMargin, top: 40, bottom: (widget.isAppBarCircular == true) ? 80 : 0),
                            width: double.infinity,
                            height: (Platform.isIOS) ? ((widget.isAppBarCircular == true) ? 90 : 170) : ((widget.isAppBarCircular == true) ? 170 : 90),
                            decoration: BoxDecoration(
                                color: (widget.isAppBarCircular == true) ? widget.appBarColor : Colors.white,
                                gradient: widget.appBarColorGradient,
                                borderRadius: BorderRadius.vertical(bottom: Radius.circular((widget.isAppBarCircular == true) ? 24 : 0))
                            ),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      widget.onBackButtonPressed != null
                                          ? Container(
                                          margin: EdgeInsets.only(right: 4),
                                          width: 30,
                                          height: 30,
                                          child: Material(
                                              type: MaterialType.transparency,
                                              elevation: 6.0,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)
                                              ),
                                              color: Colors.transparent,
                                              shadowColor: Colors.grey[80],
                                              child: InkWell(
                                                  onTap: () {
                                                    if (widget.onBackButtonPressed != null) {
                                                      widget.onBackButtonPressed!();
                                                    }
                                                  },
                                                  child: Container(
                                                      width: 24,
                                                      height: 24,
                                                      decoration: BoxDecoration(
                                                          color: widget.isBackInvert != null &&
                                                              widget.isBackInvert == true ? Colors.white : Colors.blue.shade100,
                                                          shape: BoxShape.circle
                                                      ),
                                                      child: widget.invert != null &&
                                                          widget.invert == true
                                                          ? Icon(Icons.arrow_back_ios_new, size: 16, color: Colors.white)
                                                          : Icon(Icons.arrow_back_ios_new, size: 16, color: mainColor)
                                                  )
                                              )
                                          )
                                      )
                                          : SizedBox(),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          widget.widgetAppBar != null
                                              ? widget.widgetAppBar!
                                              : SizedBox(),
                                          SizedBox(height: (subtitle_refresh != null) ? 5 : 0),
                                          subtitle_refresh != null
                                              ? Text(
                                            subtitle_refresh ?? widget.subtitle!,
                                            style: GoogleFonts.inter(
                                                color: widget.invert != null &&
                                                    widget.invert == true
                                                    ? Colors.white
                                                    : greyColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400),
                                          )
                                              : SizedBox(),
                                        ],
                                      ),
                                    ],
                                  ),
                                  widget.image != null
                                      ? Container(
                                    width: widget.imageSize,
                                    height: widget.imageSize,
                                    alignment: Alignment.centerRight,
                                    child: widget.image,
                                  )
                                      : SizedBox(),
                                ]),
                          ) : Container(
                            margin: EdgeInsets.only(bottom: 0),
                            padding: EdgeInsets.only(left: defaultMargin, right: defaultMargin, top: 40, bottom: (widget.isAppBarCircular == true) ? 80 : 0),
                            width: double.infinity,
                            height: (Platform.isIOS) ? ((widget.isAppBarCircular == true) ? widget.heightAppBar! : 90) : ((widget.isAppBarCircular == true) ? widget.heightAppBar! : 90),
                            decoration: BoxDecoration(
                                color: (widget.isAppBarCircular == true) ? widget.appBarColor : Colors.white,
                                gradient: widget.appBarColorGradient,
                                borderRadius: BorderRadius.vertical(bottom: Radius.circular((widget.isAppBarCircular == true) ? 24 : 0))
                            ),
                            child: (widget.isCenterTitle == false) ? Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      widget.onBackButtonPressed != null
                                          ? Container(
                                          margin: EdgeInsets.only(right: 15),
                                          width: 30,
                                          height: 30,
                                          child: Material(
                                              type: MaterialType.transparency,
                                              elevation: 6.0,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)
                                              ),
                                              color: Colors.transparent,
                                              shadowColor: Colors.grey[80],
                                              child: InkWell(
                                                onTap: () {
                                                  if (widget.onBackButtonPressed != null) {
                                                    widget.onBackButtonPressed!();
                                                  }
                                                },
                                                child: Container(
                                                    width: 24,
                                                    height: 24,
                                                    decoration: BoxDecoration(
                                                        color: widget.isBackInvert != null &&
                                                            widget.isBackInvert == true ? Colors.white : Colors.blue.shade100,
                                                        shape: BoxShape.circle
                                                    ),
                                                    child: widget.invert != null &&
                                                        widget.invert == true
                                                        ? Icon(Icons.arrow_back_ios_new, size: 16, color: mainColor)
                                                        : Icon(Icons.arrow_back_ios_new, size: 16, color: mainColor)
                                                ),
                                              )
                                          )
                                      )
                                          : SizedBox(),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          widget.widgetAppBar != null
                                              ? widget.widgetAppBar!
                                              : SizedBox(),
                                          title_refresh != null
                                              ? Text(
                                            title_refresh ?? widget.title!,
                                            style: GoogleFonts.inter(
                                                color: widget.invert != null &&
                                                    widget.invert == true
                                                    ? Colors.white
                                                    : blackColor,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500),
                                          )
                                              : SizedBox(),
                                          SizedBox(height: (subtitle_refresh != null) ? 5 : 0),
                                          subtitle_refresh != null
                                              ? Text(
                                            subtitle_refresh ?? widget.subtitle!,
                                            style: GoogleFonts.inter(
                                                color: widget.invert != null &&
                                                    widget.invert == true
                                                    ? Colors.white
                                                    : greyColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400),
                                          )
                                              : SizedBox(),
                                        ],
                                      ),
                                    ],
                                  ),
                                  widget.image != null
                                      ? Container(
                                    width: widget.imageSize,
                                    height: widget.imageSize,
                                    alignment: Alignment.centerRight,
                                    child: widget.image,
                                  )
                                      : SizedBox(),
                                ]) : Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  widget.onBackButtonPressed != null
                                      ? Container(
                                      margin: EdgeInsets.only(right: 15),
                                      width: 30,
                                      height: 30,
                                      child: Material(
                                          type: MaterialType.transparency,
                                          elevation: 6.0,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)
                                          ),
                                          color: Colors.transparent,
                                          shadowColor: Colors.grey[80],
                                          child: InkWell(
                                              onTap: () {
                                                if (widget.onBackButtonPressed != null) {
                                                  widget.onBackButtonPressed!();
                                                }
                                              },
                                              child: Container(
                                                  width: 24,
                                                  height: 24,
                                                  decoration: BoxDecoration(
                                                      color: widget.isBackInvert != null &&
                                                          widget.isBackInvert == true ? Colors.white : Colors.blue.shade100,
                                                      shape: BoxShape.circle
                                                  ),
                                                  child: widget.invert != null &&
                                                      widget.invert == true
                                                      ? Icon(Icons.arrow_back_ios_new, size: 16, color: Colors.white)
                                                      : Icon(Icons.arrow_back_ios_new, size: 16, color: mainColor)
                                              )
                                          )
                                      )
                                  )
                                      : SizedBox(width: 30,),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      widget.widgetAppBar != null
                                          ? widget.widgetAppBar!
                                          : SizedBox(),
                                      title_refresh != null
                                          ? Text(
                                        title_refresh ?? widget.title!,
                                        style: GoogleFonts.inter(
                                            color: widget.invert != null &&
                                                widget.invert == true
                                                ? Colors.white
                                                : blackColor,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      )
                                          : SizedBox(),
                                      SizedBox(height: (subtitle_refresh != null) ? 5 : 0),
                                      subtitle_refresh != null
                                          ? Text(
                                        subtitle_refresh ?? widget.subtitle!,
                                        style: GoogleFonts.inter(
                                            color: widget.invert != null &&
                                                widget.invert == true
                                                ? Colors.white
                                                : greyColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                      )
                                          : SizedBox(),
                                    ],
                                  ),
                                  widget.image != null
                                      ? Container(
                                    width: widget.imageSize,
                                    height: widget.imageSize,
                                    alignment: Alignment.centerRight,
                                    child: widget.image,
                                  )
                                      : SizedBox(width: 30,),
                                ]),
                          ) : SizedBox(),
                        ),
                      ) : SizedBox(),
                      (widget.scrollable == true) ? SmartRefresher(
                        enablePullUp: false,
                        header: WaterDropHeader(),
                        footer: CustomFooter(
                          builder: (BuildContext? context, LoadStatus? mode){
                            Widget? body ;



                            if(mode==LoadStatus.idle){

                            }
                            else if(mode==LoadStatus.loading){
                              body =  CupertinoActivityIndicator();

                              _onRefreshFooter();
                            }
                            else if(mode == LoadStatus.failed){

                            }
                            else if(mode == LoadStatus.canLoading){

                            }
                            else{

                            }
                            return Container(
                              height: 55.0,
                              child: Center(child:body),
                            );
                          },
                        ),
                        controller: _refreshController,
                        onRefresh: _onRefresh,
                        onLoading: _onLoading,
                        child: ListView(
                          reverse: widget.isReverse ?? false,
                          dragStartBehavior: DragStartBehavior.start,
                          children: [
                            Column(
                              children: [
                                FutureBuilder(
                                  future: checkConnectivity(),
                                  builder: (context, snapshot)
                                  => ((connectivityResult != null && connectivityResult.contains(ConnectivityResult.mobile)) || (connectivityResult != null && connectivityResult.contains(ConnectivityResult.wifi)))
                                      ? Container(
                                      margin: EdgeInsets.only(top: (widget.title != null) ? (widget.marginAppBar! + 20) : 0),
                                      child: child_refresh
                                  ) ?? SizedBox()
                                      : FutureBuilder(
                                      future: Future.delayed(Duration(seconds: 1)),
                                      builder: (c, s) => s.connectionState == ConnectionState.done
                                          ? Container(
                                          child: Text('Koneksi Internet Terputus')
                                      ) : loadingIndicator),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ) : Column(
                        children: [
                          FutureBuilder(
                            future: checkConnectivity(),
                            builder: (context, snapshot) => (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi)
                                ? Container(
                                margin: EdgeInsets.only(top: (widget.title != null) ? (widget.marginAppBar! + 20) : 0),
                                child: child_refresh
                            ) ?? SizedBox()
                                : FutureBuilder(
                                future: Future.delayed(Duration(seconds: 1)),
                                builder: (c, s) => s.connectionState == ConnectionState.done
                                    ? Container(
                                    child: Text('Koneksi Internet Terputus')
                                ) : loadingIndicator),
                          ),
                        ],
                      ),
                      (widget.isFrontAppBar == true) ? Positioned(
                        top: MediaQuery.of(context).viewInsets.top,
                        left: 0,
                        right: 0,
                        child: Container(
                          child: (widget.title != null) ? (widget.widgetAppBar != null) ? Container(
                            margin: EdgeInsets.only(bottom: 0),
                            padding: EdgeInsets.only(left: defaultMargin, right: defaultMargin, top: 40, bottom: (widget.isAppBarCircular == true) ? 80 : 0),
                            width: double.infinity,
                            height: (Platform.isIOS) ? ((widget.isAppBarCircular == true) ? 90 : 170) : ((widget.isAppBarCircular == true) ? 170 : 90),
                            decoration: BoxDecoration(
                                color: (widget.isAppBarCircular == true) ? widget.appBarColor : Colors.white,
                                gradient: widget.appBarColorGradient,
                                borderRadius: BorderRadius.vertical(bottom: Radius.circular((widget.isAppBarCircular == true) ? 24 : 0))
                            ),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      widget.onBackButtonPressed != null
                                          ? Container(
                                          margin: EdgeInsets.only(right: 4),
                                          width: 30,
                                          height: 30,
                                          child: Material(
                                              type: MaterialType.transparency,
                                              elevation: 6.0,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)
                                              ),
                                              color: Colors.transparent,
                                              shadowColor: Colors.grey[80],
                                              child: InkWell(
                                                  onTap: () {
                                                    if (widget.onBackButtonPressed != null) {
                                                      widget.onBackButtonPressed!();
                                                    }
                                                  },
                                                  child: Container(
                                                      width: 24,
                                                      height: 24,
                                                      decoration: BoxDecoration(
                                                          color: widget.isBackInvert != null &&
                                                              widget.isBackInvert == true ? Colors.white : Colors.blue.shade100,
                                                          shape: BoxShape.circle
                                                      ),
                                                      child: widget.invert != null &&
                                                          widget.invert == true
                                                          ? Icon(Icons.arrow_back_ios_new, size: 16, color: Colors.white)
                                                          : Icon(Icons.arrow_back_ios_new, size: 16, color: mainColor)
                                                  )
                                              )
                                          )
                                      )
                                          : SizedBox(),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          widget.widgetAppBar != null
                                              ? widget.widgetAppBar!
                                              : SizedBox(),
                                          SizedBox(height: (subtitle_refresh != null) ? 5 : 0),
                                          subtitle_refresh != null
                                              ? Text(
                                            subtitle_refresh ?? widget.subtitle!,
                                            style: GoogleFonts.inter(
                                                color: widget.invert != null &&
                                                    widget.invert == true
                                                    ? Colors.white
                                                    : greyColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400),
                                          )
                                              : SizedBox(),
                                        ],
                                      ),
                                    ],
                                  ),
                                  widget.image != null
                                      ? Container(
                                    width: widget.imageSize,
                                    height: widget.imageSize,
                                    alignment: Alignment.centerRight,
                                    child: widget.image,
                                  )
                                      : SizedBox(),
                                ]),
                          ) : Container(
                            margin: EdgeInsets.only(bottom: 0),
                            padding: EdgeInsets.only(left: defaultMargin, right: defaultMargin, top: 40, bottom: (widget.isAppBarCircular == true) ? 80 : 0),
                            width: double.infinity,
                            height: (Platform.isIOS) ? ((widget.isAppBarCircular == true) ? 170 : 90) : ((widget.isAppBarCircular == true) ? 170 : 90),
                            decoration: BoxDecoration(
                                color: (widget.isAppBarCircular == true) ? widget.appBarColor : (widget.appBarColor != null) ? widget.appBarColor : Colors.white,
                                gradient: widget.appBarColorGradient,
                                borderRadius: BorderRadius.vertical(bottom: Radius.circular((widget.isAppBarCircular == true) ? 24 : 0))
                            ),
                            child: (widget.isCenterTitle == false) ? Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      widget.onBackButtonPressed != null
                                          ? Container(
                                          margin: EdgeInsets.only(right: 15),
                                          width: 30,
                                          height: 30,
                                          child: Material(
                                              type: MaterialType.transparency,
                                              elevation: 6.0,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)
                                              ),
                                              color: Colors.transparent,
                                              shadowColor: Colors.grey[80],
                                              child: InkWell(
                                                onTap: () {
                                                  if (widget.onBackButtonPressed != null) {
                                                    widget.onBackButtonPressed!();
                                                  }
                                                },
                                                child: Container(
                                                    width: 24,
                                                    height: 24,
                                                    decoration: BoxDecoration(
                                                        color: widget.isBackInvert != null &&
                                                            widget.isBackInvert == true ? Colors.white : Colors.blue.shade100,
                                                        shape: BoxShape.circle
                                                    ),
                                                    child: widget.invert != null &&
                                                        widget.invert == true
                                                        ? Icon(Icons.arrow_back_ios_new, size: 16, color: mainColor)
                                                        : Icon(Icons.arrow_back_ios_new, size: 16, color: mainColor)
                                                ),
                                              )
                                          )
                                      )
                                          : SizedBox(),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          widget.widgetAppBar != null
                                              ? widget.widgetAppBar!
                                              : SizedBox(),
                                          title_refresh != null
                                              ? Text(
                                            title_refresh ?? widget.title!,
                                            style: GoogleFonts.inter(
                                                color: widget.invert != null &&
                                                    widget.invert == true
                                                    ? Colors.white
                                                    : blackColor,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500),
                                          )
                                              : SizedBox(),
                                          SizedBox(height: (subtitle_refresh != null) ? 5 : 0),
                                          subtitle_refresh != null
                                              ? Text(
                                            subtitle_refresh ?? widget.subtitle!,
                                            style: GoogleFonts.inter(
                                                color: widget.invert != null &&
                                                    widget.invert == true
                                                    ? Colors.white
                                                    : greyColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400),
                                          )
                                              : SizedBox(),
                                        ],
                                      ),
                                    ],
                                  ),
                                  widget.image != null
                                      ? Container(
                                    width: widget.imageSize,
                                    height: widget.imageSize,
                                    alignment: Alignment.centerRight,
                                    child: widget.image,
                                  )
                                      : SizedBox(),
                                ]) : Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  widget.onBackButtonPressed != null
                                      ? Container(
                                      margin: EdgeInsets.only(right: 15),
                                      width: 30,
                                      height: 30,
                                      child: Material(
                                          type: MaterialType.transparency,
                                          elevation: 6.0,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)
                                          ),
                                          color: Colors.transparent,
                                          shadowColor: Colors.grey[80],
                                          child: InkWell(
                                              onTap: () {
                                                if (widget.onBackButtonPressed != null) {
                                                  widget.onBackButtonPressed!();
                                                }
                                              },
                                              child: Container(
                                                  width: 24,
                                                  height: 24,
                                                  decoration: BoxDecoration(
                                                      color: widget.isBackInvert != null &&
                                                          widget.isBackInvert == true ? Colors.white : Colors.blue.shade100,
                                                      shape: BoxShape.circle
                                                  ),
                                                  child: widget.invert != null &&
                                                      widget.invert == true
                                                      ? Icon(Icons.arrow_back_ios_new, size: 16, color: Colors.white)
                                                      : Icon(Icons.arrow_back_ios_new, size: 16, color: mainColor)
                                              )
                                          )
                                      )
                                  )
                                      : SizedBox(width: 30,),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      widget.widgetAppBar != null
                                          ? widget.widgetAppBar!
                                          : SizedBox(),
                                      title_refresh != null
                                          ? Text(
                                        title_refresh ?? widget.title!,
                                        style: GoogleFonts.inter(
                                            color: widget.invert != null &&
                                                widget.invert == true
                                                ? Colors.white
                                                : blackColor,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      )
                                          : SizedBox(),
                                      SizedBox(height: (subtitle_refresh != null) ? 5 : 0),
                                      subtitle_refresh != null
                                          ? Text(
                                        subtitle_refresh ?? widget.subtitle!,
                                        style: GoogleFonts.inter(
                                            color: widget.invert != null &&
                                                widget.invert == true
                                                ? Colors.white
                                                : greyColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                      )
                                          : SizedBox(),
                                    ],
                                  ),
                                  widget.image != null
                                      ? Container(
                                    width: widget.imageSize,
                                    height: widget.imageSize,
                                    alignment: Alignment.centerRight,
                                    child: widget.image,
                                  )
                                      : SizedBox(width: 30,),
                                ]),
                          ) : SizedBox(),
                        ),
                      ) : SizedBox(),
                      Positioned(
                        bottom: MediaQuery.of(context).viewInsets.top,
                        left: 0,
                        right: 0,
                        child: Container(
                            margin: EdgeInsets.only(bottom: widget.marginNavBar!),
                            child: widget.navBar ?? SizedBox()),
                      ),
                    ],
                  )),
            ],
          ),
        )
    );
  }
}
