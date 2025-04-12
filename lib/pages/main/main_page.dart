part of '../pages.dart';

class MainPage extends StatefulWidget {
  final int? index_;
  final String? token;
  final int? index_transaction;

  MainPage({this.index_, this.index_transaction, this.token});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int navbarIndex = 0;
  PageController? pageController;
  String? token;
  String? id_chat, token_admin, myId;

  bool isTask = true;

  Future<bool> _onWillPop() async {
    return (kIsWeb) ? true : (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('are_you_sure'.trans(context)),
        content: new Text('doyouwantexit'.trans(context)),
        actions: <Widget>[
          new MaterialButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('no'.trans(context)),
          ),
          new MaterialButton(
            onPressed: () => SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
            child: new Text('yes'.trans(context)),
          ),
        ],
      ),
    )) ?? false;
  }

  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    navbarIndex = 0;
    pageController = PageController(initialPage: navbarIndex);

    if (widget.index_ != null) {
      navbarIndex = widget.index_ ?? 0;
      pageController = PageController(initialPage: navbarIndex);
    }

    if(widget.token != null) {

    }

  }

  @override
  Widget build(BuildContext context) {

    print("TOKEN SERVER" + widget.token.toString());

    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
            body: Stack(
              children: [
                Container(
                  color: Colors.white,
                ),
                SafeArea(
                  child: Container(
                    color: bcgGreyColor2,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: (kIsWeb) ? ((navbarIndex == 1) ? 90 : 40) : ((Platform.isIOS) ? (navbarIndex == 1) ? 35 : 35 : 45)),
                  child: PageView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: pageController,
                    onPageChanged: (index) {
                      setState(() {
                        navbarIndex = index;
                      });
                    },
                    children: [
                      HomePage(widget.token!),
                      ActivityPage(widget.token!),
                      AttendancePage(widget.token!),
                      (isTask) ? TaskPage(widget.token!) : AnalyticsPage(widget.token!),
                      ProfilePage(widget.token ?? ""),
                    ],
                  ),
                ),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: (kIsWeb) ? (MediaQuery.of(context).size.height * 0.069) + 60 : ((Platform.isIOS) ? (MediaQuery.of(context).size.height * 0.110) + 90 : (MediaQuery.of(context).size.height * 0.074) + 70),
                      child: Stack(
                          children: [
                            Positioned(
                              bottom: MediaQuery.of(context).viewInsets.top,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: (kIsWeb) ? (MediaQuery.of(context).size.height * 0.069) : ((Platform.isIOS) ? MediaQuery.of(context).size.height * 0.11 : MediaQuery.of(context).size.height * 0.074),
                                padding: EdgeInsets.only(top: 0),
                                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 0,
                                    blurRadius: 0,
                                    offset: Offset(0, 0),
                                  )
                                ]),
                                child: BottomNavigationBar(
                                  elevation: 0,
                                  backgroundColor: Colors.transparent,
                                  selectedItemColor: mainColor,
                                  unselectedItemColor: greyColor,
                                  showUnselectedLabels: true,
                                  type: BottomNavigationBarType.fixed,
                                  currentIndex: navbarIndex,
                                  onTap: (index) async {

                                    setState(() {
                                      navbarIndex = index;
                                      pageController!.jumpToPage(index);
                                    });

                                  },
                                  items: [
                                    BottomNavigationBarItem(
                                      label: "home".trans(context),
                                      icon: (kIsWeb) ? Container(
                                          width: 24,
                                          height: 24,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage("assets/icons/ic_home_unactive.png"),
                                                fit: BoxFit.fill,
                                              )
                                          )
                                      ) : Container(
                                        width: 24,
                                        height: 24,
                                        child: SvgPicture.asset("assets/icons/ic_home_unactive.svg"),
                                      ),
                                      activeIcon: (kIsWeb) ? Container(
                                          width: 24,
                                          height: 24,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage("assets/icons/ic_home_active.png"),
                                                fit: BoxFit.fill,
                                              )
                                          )
                                      ) : Container(
                                        width: 24,
                                        height: 24,
                                        child: SvgPicture.asset("assets/icons/ic_home_active.svg"),
                                      ),
                                    ),
                                    BottomNavigationBarItem(
                                      label: "activity".trans(context),
                                      icon: (kIsWeb) ? Container(
                                          width: 24,
                                          height: 24,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage("assets/icons/ic_activity_unactive.png"),
                                                fit: BoxFit.fill,
                                              )
                                          )
                                      ) : Container(
                                        width: 24,
                                        height: 24,
                                        child: SvgPicture.asset("assets/icons/ic_activity_unactive.svg"),
                                      ),
                                      activeIcon: (kIsWeb) ? Container(
                                          width: 24,
                                          height: 24,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage("assets/icons/ic_activity_active.png"),
                                                fit: BoxFit.fill,
                                              )
                                          )
                                      ) : Container(
                                        width: 24,
                                        height: 24,
                                        child: SvgPicture.asset("assets/icons/ic_activity_active.svg"),
                                      ),
                                    ),
                                    BottomNavigationBarItem(
                                      label: "attendance".trans(context),
                                      icon: (kIsWeb) ? Container(
                                          width: 24,
                                          height: 24,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage("assets/icons/ic_eye_unactive.png"),
                                                fit: BoxFit.fill,
                                              )
                                          )
                                      ) : Container(
                                        width: 24,
                                        height: 24,
                                        child: SvgPicture.asset("assets/icons/ic_eye_unactive.svg", color: Colors.white),
                                      ),
                                      activeIcon: (kIsWeb) ? Container(
                                          width: 24,
                                          height: 24,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage("assets/icons/ic_eye_active.png"),
                                                fit: BoxFit.fill,
                                              )
                                          )
                                      ) : Container(
                                        width: 24,
                                        height: 24,
                                        child: SvgPicture.asset("assets/icons/ic_eye_active.svg", color: Colors.white),
                                      ),
                                    ),
                                    (isTask) ? BottomNavigationBarItem(
                                      label: "task".trans(context),
                                      icon: (kIsWeb) ? Container(
                                          width: 24,
                                          height: 24,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage("assets/icons/ic_task_unactive.png"),
                                                fit: BoxFit.fill,
                                              )
                                          )
                                      ) : Container(
                                        width: 24,
                                        height: 24,
                                        child:
                                        SvgPicture.asset("assets/icons/ic_task_unactive.svg"),
                                      ),
                                      activeIcon: (kIsWeb) ? Container(
                                          width: 24,
                                          height: 24,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage("assets/icons/ic_task_active.png"),
                                                fit: BoxFit.fill,
                                              )
                                          )
                                      ) : Container(
                                        width: 24,
                                        height: 24,
                                        child: SvgPicture.asset("assets/icons/ic_task_active.svg"),
                                      ),
                                    ) : BottomNavigationBarItem(
                                      label: "analytics".trans(context),
                                      icon: (kIsWeb) ? Container(
                                          width: 24,
                                          height: 24,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage("assets/icons/ic_graph_unactive.png"),
                                                fit: BoxFit.fill,
                                              )
                                          )
                                      ) : Container(
                                        width: 24,
                                        height: 24,
                                        child:
                                        SvgPicture.asset("assets/icons/ic_graph_unactive.svg"),
                                      ),
                                      activeIcon: (kIsWeb) ? Container(
                                          width: 24,
                                          height: 24,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage("assets/icons/ic_graph_active.png"),
                                                fit: BoxFit.fill,
                                              )
                                          )
                                      ) : Container(
                                        width: 24,
                                        height: 24,
                                        child: SvgPicture.asset("assets/icons/ic_graph_active.svg"),
                                      ),
                                    ),
                                    BottomNavigationBarItem(
                                      label: "account".trans(context),
                                      icon: (kIsWeb) ? Container(
                                          width: 24,
                                          height: 24,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage("assets/icons/ic_user_unactive.png"),
                                                fit: BoxFit.fill,
                                              )
                                          )
                                      ) : Container(
                                        width: 24,
                                        height: 24,
                                        child: SvgPicture.asset("assets/icons/ic_user_unactive.svg"),
                                      ),
                                      activeIcon: (kIsWeb) ? Container(
                                          width: 24,
                                          height: 24,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage("assets/icons/ic_user_active.png"),
                                                fit: BoxFit.fill,
                                              )
                                          )
                                      ) : Container(
                                        width: 24,
                                        height: 24,
                                        child: SvgPicture.asset("assets/icons/ic_user_active.svg"),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                                top: (kIsWeb) ? 45 : ((Platform.isIOS) ? 65 : 45),
                                bottom: (kIsWeb) ? 24 : ((Platform.isIOS) ? 60 : 28),
                                left: 0,
                                right: 0,
                                child: Container(
                                    width: 70,
                                    height: 70,
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.only(top: (kIsWeb) ? 10 : ((Platform.isIOS) ? 13 : 14), left: 1),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: (navbarIndex == 2) ? mainColor : Colors.white, width: 1.5),
                                        color: (navbarIndex == 2) ? Colors.white : mainColor,
                                        shape: BoxShape.circle,
                                        // boxShadow: boxShadow
                                    ),
                                    child: InkWell(
                                      onTap: () async {
                                        setState(() {
                                          navbarIndex = 2;
                                          pageController!.jumpToPage(2);
                                        });
                                      },
                                      child: Column(
                                        children: [
                                          Container(
                                            child: SvgPicture.asset("${prefixIcons}ic_scan.svg", color: (navbarIndex == 2) ? mainColor : Colors.white,),
                                          ),
                                          SizedBox(height: 3),
                                        ],
                                      ),
                                    )
                                )
                            ),
                          ]
                      ),
                    )),
              ],
            )
        )
    );
  }

  SliverGridDelegateWithFixedCrossAxisCount _sliverGrid3Delegate() {
    return const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      crossAxisSpacing: 1.7,
      mainAxisSpacing: 1.5,
      childAspectRatio: .5,
    );
  }
}
