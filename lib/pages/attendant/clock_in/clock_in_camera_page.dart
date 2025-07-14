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

  final picker = ImagePicker();
  final cropperData = FaceCropper();
  final cropperData2 = FaceCropper();
  final recognizer = FaceRecognizer();

  String status = '';
  File? _croppedFace1;
  File? _croppedFace2;

  List<double>? savedEmbedding;

  bool autoCapture = true;

  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('assets/$path');
    final buffer = byteData.buffer;
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    var filePath =
        tempPath + '/file_01.tmp'; // file_01.tmp is dump file, can be anything
    return File(filePath)
        .writeAsBytes(buffer.asUint8List(byteData.offsetInBytes,
        byteData.lengthInBytes));
  }

  @override
  void initState() {

    recognizer.loadModel();

    controller = FaceCameraController(
      autoCapture: autoCapture,
      defaultCameraLens: CameraLens.front,
      onCapture: (File? image) async {
        controller.dispose();
        Get.to(ClockInDetailPage(widget.token, widget.latitude, widget.longitude, widget.location, image!));
        // File fileData = await getImageFileFromAssets("images/img_photo_sample.jpg");
        //
        // await pickAndRecognize(image!, fileData).then((value){
        //   if(value == true){
        //     controller.dispose();
        //     Get.to(ClockInDetailPage(widget.token, widget.latitude, widget.longitude, widget.location, image!));
        //   } else {
        //     Fluttertoast.showToast(
        //         msg: "${status}",
        //         toastLength: Toast.LENGTH_SHORT,
        //         gravity: ToastGravity.BOTTOM,
        //         timeInSecForIosWeb: 1,
        //         backgroundColor: Colors.green,
        //         textColor: Colors.white,
        //         fontSize: 16.0
        //     );
        //   }
        // });
      },
    );

    super.initState();
  }

  Future<bool> pickAndRecognize(File imageData1, File imageData2) async {

    File file1 = File(imageData1.path);
    File file2 = File(imageData2.path);
    setState(() => status = 'Mendeteksi wajah...');

    final cropped1 = await cropperData.cropFaceFromFile(file1);
    final cropped2 = await cropperData2.cropFaceFromFile(file2);
    if (cropped1 == null) {
      setState(() => status = 'face_not_found'.trans(context));
      return false;
    }

    if (cropped2 == null) {
      setState(() => status = 'face_not_found'.trans(context));
      return false;
    }

    setState(() {
      _croppedFace1 = cropped1;
      _croppedFace2 = cropped2;
    });

    final embedding1 = await recognizer.getEmbeddingFromFile(cropped1);
    final embedding2 = await recognizer.getEmbeddingFromFile(cropped2);
    final sim = recognizer.cosineSimilarity(embedding1, embedding2);

    setState(() {
      status = sim > 0.5
          ? '✅ ${"face_match".trans(context)} (similarity: ${sim.toStringAsFixed(2)})'
          : '❌ ${"face_not_match".trans(context)} (similarity: ${sim.toStringAsFixed(2)})';
    });

    print("SIMILARITY ${sim} | ${status}");

    if(sim > 0.5){
      return true;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    controller.dispose();
    cropperData.dispose();
    cropperData2.dispose();
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
