part of '../../pages.dart';

class ClockOutCameraPage extends StatefulWidget {
  final String token;
  final String latitude;
  final String longitude;
  final String location;

  ClockOutCameraPage(this.token, this.latitude, this.longitude, this.location);

  @override
  State<ClockOutCameraPage> createState() => _ClockOutCameraPageState();
}

class _ClockOutCameraPageState extends State<ClockOutCameraPage> {
  TextEditingController noteC = TextEditingController();
  late FaceCameraController controller;

  @override
  void initState() {
    controller = FaceCameraController(
      autoCapture: true,
      defaultCameraLens: CameraLens.front,
      onCapture: (File? image) {
        controller.dispose();

        Get.to(ClockOutDetailPage(widget.token, widget.latitude, widget.longitude, widget.location, image!));
      },
    );
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
      title: "selfie_to_out".trans(context),
      onBackButtonPressed: (){
        Get.back();
      },
      appBarColor: Colors.white,
      child: SmartFaceCamera(
        controller: controller,
        showControls: false,
        message: 'center_your'.trans(context),
      )
    );
  }
}
