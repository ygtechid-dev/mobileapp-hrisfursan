part of '../../pages.dart';

class ClockInCameraPage extends StatefulWidget {
  final String token;
  final String latitude;
  final String longitude;
  final String location;

  ClockInCameraPage(this.token, this.latitude, this.longitude, this.location);

  @override
  State<ClockInCameraPage> createState() => _ClockInCameraPageState();
}

class _ClockInCameraPageState extends State<ClockInCameraPage> {
  TextEditingController noteC = TextEditingController();
  late FaceCameraController controller;

  @override
  void initState() {

    controller = FaceCameraController(
      autoCapture: true,
      defaultCameraLens: CameraLens.front,
      onCapture: (File? image) {
        Get.to(ClockInDetailPage(widget.token, widget.latitude, widget.longitude, widget.location, image!));
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
      title: "selfie_to".trans(context),
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
