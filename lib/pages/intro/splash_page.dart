part of '../pages.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  var connectivityResult;

  Future<void> checkConnectivity() async {
    connectivityResult = await (Connectivity().checkConnectivity());
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: mainColor,
      body: Center(
          child: Container(
              height: MediaQuery.of(context).size.height - 40,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width - 2*100,
                    height: MediaQuery.of(context).size.width - 2*100,
                    margin: EdgeInsets.only(top: 0),
                    decoration: BoxDecoration(image: DecorationImage(
                      fit: BoxFit.fitWidth,
                      image: AssetImage('assets/images/img_logo_white.png'),
                    )),
                  ),
                ],
              )
          )
      ),
    );
  }

  String? token;
  String? token_haha;

  Future<void> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getString('token') != null && prefs.getString('token') != '') {
      setState(() {
        token = prefs.getString('token') ;
        token_haha = prefs.getString('token_message') ?? "";
      });

      var connectivityResult = await (Connectivity().checkConnectivity());

      if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

        // I am connected to a mobile network.
        new Future.delayed(const Duration(milliseconds: 100), () =>
            Navigator.push(
              context, MaterialPageRoute(builder: (context) => LanguagePage()),
            ));
      } else {
        Get.snackbar('', '',
            backgroundColor: Colors.red,
            icon: Icon(Icons.close, color: Colors.white,),
            titleText: Text('Koneksi Internet Terputus', style: blackFontStyle.copyWith(color: Colors.white)),
            messageText: Text('Terjadi Kesalahan Jaringan, Silahkan Cek Koneksi Anda', style: blackFontStyle.copyWith(color: Colors.white))
        );
      }

    } else {
      token = null;
      new Future.delayed(const Duration(milliseconds: 100), () =>
          Navigator.push(
            context, MaterialPageRoute(builder: (context) => LanguagePage()),
          ));
    }

  }

  @override
  void initState() {
    super.initState();
    // context.read<SettingCubit>().getSetting();

    getToken();
  }
}