part of '../../pages.dart';

class ClockInCameraPage extends StatefulWidget {

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
        Get.to(ClockInDetailPage(image!));
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
      title: "Selfie To Clock In",
      onBackButtonPressed: (){
        Get.back();
      },
      appBarColor: Colors.white,
      child: SmartFaceCamera(
        controller: controller,
        showControls: false,
        message: 'Center your face in the square',
      )
    );
  }
}
