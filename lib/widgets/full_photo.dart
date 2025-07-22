part of 'widgets.dart';

class FullPhoto extends StatelessWidget {
  final String? url;

  FullPhoto({Key? key, @required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FullPhotoScreen(url: url!),
    );
  }
}

class FullPhotoScreen extends StatefulWidget {
  final String? url;

  FullPhotoScreen({Key? key, @required this.url}) : super(key: key);

  @override
  State createState() => FullPhotoScreenState(url: url);
}

class FullPhotoScreenState extends State<FullPhotoScreen> {
  final String? url;

  FullPhotoScreenState({Key? key, @required this.url});

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PhotoView(imageProvider: CachedNetworkImageProvider(url!)),
    );
    // child: PhotoView(imageProvider: CachedNetworkImageProvider(url)));
  }
}