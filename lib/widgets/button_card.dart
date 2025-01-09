part of 'widgets.dart';

class ButtonCard extends StatefulWidget {
  final String text;
  final Color color;
  final bool isActive;
  final double? width;
  final double padding;
  final double paddingHorizontal;
  final double radius;
  final Function? onPressed;
  final ValueChanged<String>? onChanged;
  final String? iconPath;
  final double fontSize;
  final Color? fontColor;
  final Color? backColor;
  final double iconSize;
  final bool isBordered;
  final IconData? iconData;
  final Color? borderColor;
  final bool isBold;
  final double marginIcon;
  final bool isReadable;
  final bool isHover;
  final bool isLoading;
  final int factorial;
  final Gradient? colorGradient;
  final List<BoxShadow>? boxShadow;

  ButtonCard(this.text, this.width, this.color, {this.factorial = 7,
    this.boxShadow, this.padding = 15, this.paddingHorizontal = 0, this.isLoading = false, this.isHover = true, this.fontSize = 13,
    this.fontColor, this.isReadable = true, this.marginIcon = 12, this.iconSize = 20,
    this.backColor, this.isBold = true, this.radius = 100,
    this.onPressed, this.onChanged, this.borderColor, this.iconData, this.iconPath, this.colorGradient,
    this.isActive = false, this.isBordered = true});

  @override
  _ButtonCardState createState() => _ButtonCardState();
}

class _ButtonCardState extends State<ButtonCard> {

  bool _isActive = false;
  Color? fontColor;

  @override
  void initState() {
    super.initState();

    _isActive = widget.isActive;

  }

  @override
  Widget build(BuildContext context) {

    fontColor = (widget.fontColor != null) ? widget.fontColor! : widget.color;

    int length = (widget.text.length < 5) ? widget.text.length * 20 : widget.text.length * widget.factorial;

    return Container(
        width: (widget.width != null) ? widget.width : length.toDouble(),
        padding: EdgeInsets.zero,
        child: GestureDetector(
          // padding: EdgeInsets.zero,
          onTap: () async {
            if(widget.isReadable == true){

              if(widget.isHover == true){
                setState(() {
                  _isActive = !_isActive;
                });

                new Future.delayed(const Duration(milliseconds: 200), () {

                  if(widget.isLoading == true){

                  } else {
                    setState(() {
                      _isActive = !_isActive;
                    });
                  }
                });
              } else {
                setState(() {
                  _isActive = widget.isActive;
                });
              }

              if(widget.onPressed != null){
                widget.onPressed!();
                setState(() {
                  _isActive = widget.isActive;
                });
              }

              if(widget.onChanged != null) {
                widget.onChanged!(widget.text);
                setState(() {
                  _isActive = widget.isActive;
                });
              }
            }
          },
          child: Container(
              width: (widget.width != null) ? widget.width : length.toDouble(),
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: widget.paddingHorizontal, vertical: widget.padding),
              decoration: BoxDecoration(
                  color: (_isActive == false) ? widget.color : (widget.backColor != null) ? widget.backColor : Colors.white,
                  gradient: widget.colorGradient,
                  border: Border.all(width: (widget.isBordered == true) ? 1 : 0, color: (widget.borderColor != null) ? widget.borderColor! : widget.color),
                  borderRadius: BorderRadius.circular(widget.radius),
                  // boxShadow: widget.boxShadow != null ? widget.boxShadow : []
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: (widget.isLoading == false) ? [
                  (widget.iconData != null) ? Container(margin: EdgeInsets.only(right: widget.marginIcon), child: Icon(widget.iconData, size: widget.iconSize, color: (_isActive == false) ? Colors.white : fontColor,)) : SizedBox(),
                  (widget.iconPath != null) ? Container(margin: EdgeInsets.only(right: widget.marginIcon), child: SvgPicture.asset(widget.iconPath!, width: widget.iconSize, height: widget.iconSize,)) : SizedBox(),
                  Text(widget.text, style: blackFontStyle.copyWith(color: (_isActive == false) ? ((widget.backColor != null) ? ((fontColor != null) ? widget.backColor : fontColor) : Colors.white) : fontColor, fontWeight: (widget.isBold == true) ? FontWeight.w700 : FontWeight.w400, fontSize: widget.fontSize)),
                ] : [(_isActive == false) ? loadingIndicatorButtonWhite : loadingIndicatorButton],
              )
          ),
        )
    );
  }
}

class ButtonHorizontalCard extends StatelessWidget {
  final double width;
  final String title;
  final IconData icon;
  final Color color;

  ButtonHorizontalCard(this.width, this.title, this.icon, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "${title}",
            textAlign: TextAlign.start,
            style: blackFontStyle.copyWith(fontSize: 13, color: color, fontWeight: FontWeight.w600),
          ),
          Icon(icon, color: color, size: 16)
        ],
      ),
    );
  }
}

class ButtonHorizontalProfileCard extends StatelessWidget {
  final double width;
  final String title;
  final String icon;
  final Color color;
  final Function? onTap;

  ButtonHorizontalProfileCard(this.width, this.title, this.icon, this.color,
      {this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onTap!();
      },
      child: Container(
        width: width,
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset("${prefixIcons}${icon}", width: 16, height: 16,),
                SizedBox(width: 8),
                Text(
                  "${title}",
                  textAlign: TextAlign.start,
                  style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                ),
              ],
            ),
            Icon(Icons.arrow_forward_ios_rounded, color: color, size: 16)
          ],
        ),
      )
    );
  }
}

class CommonDottedButtonWithImage extends StatefulWidget {
  final double width;
  final ValueChanged<File> onPicked;
  final String icon;
  final bool isCamera;

  CommonDottedButtonWithImage(this.width,
      {required this.onPicked, required this.icon, this.isCamera = false});

  @override
  State<CommonDottedButtonWithImage> createState() => _CommonDottedButtonWithImageState();
}

class _CommonDottedButtonWithImageState extends State<CommonDottedButtonWithImage> {

  File? selectedFile;

  @override
  Widget build(BuildContext context) {

    double defaultWidth = widget.width;

    return InkWell(
      onTap: () async {
        if(widget.isCamera == true){
          PickedFile? pickedFile = await ImagePicker().getImage(source: ImageSource.camera);
          if (pickedFile != null) {
            setState(() {
              selectedFile = File(pickedFile.path);
            });

            widget.onPicked(selectedFile!);
          }
        } else {
          FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image, );

          if (result != null) {

            setState(() {
              selectedFile = File(result.files.single.path!);
            });

            widget.onPicked(selectedFile!);
          } else {
            // User canceled the picker
          }
        }

      },
      child: DottedBorder(
        strokeWidth: 1,
        dashPattern: [8,4],
        radius: const Radius.circular(8),
        color: mainColor,
        child: Container(
            alignment: Alignment.center,
            width: defaultWidth,
            padding: EdgeInsets.all(40),
            decoration: BoxDecoration(
                color: mainColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              image: (selectedFile != null) ? DecorationImage(
                fit: BoxFit.cover,
                image: FileImage(selectedFile!)
              ) : null
            ),
            child: (selectedFile == null) ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(widget.icon, width: 20, height: 20),
                // SizedBox(height: 12),
                // Text(
                //   (selectedFile == null) ? "${widget.title}" : "${path.basename(selectedFile.path)}",
                //   textAlign: TextAlign.center,
                //   style: blackFontStyle.copyWith(
                //       fontWeight: FontWeight.w600,
                //       color: (selectedFile == null) ? blackColor : mainColor),
                // ),
                // SizedBox(height: 12),
                // Text(
                //   "${widget.subtitle}",
                //   textAlign: TextAlign.center,
                //   style: blackFontStyle.copyWith(
                //       fontWeight: FontWeight.w400,
                //       color: greyColor),
                // ),
              ],
            ) : SizedBox(width: 20, height: 20)
        ),
      ),
    );
  }
}

class CommonDottedButtonWithImage2 extends StatefulWidget {
  final String title;
  final String subtitle;
  final ValueChanged<File> onPicked;
  final bool isCamera;

  CommonDottedButtonWithImage2(
      {required this.title, required this.subtitle, required this.onPicked, this.isCamera = false});

  @override
  State<CommonDottedButtonWithImage2> createState() => _CommonDottedButtonWithImage2State();
}

class _CommonDottedButtonWithImage2State extends State<CommonDottedButtonWithImage2> {

  File? selectedFile;

  @override
  Widget build(BuildContext context) {

    double defaultWidth = MediaQuery.of(context).size.width - 2*20;

    return InkWell(
      onTap: () async {
        if(widget.isCamera == true){
          XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
          if (pickedFile != null) {
            setState(() {
              selectedFile = File(pickedFile.path);
            });

            widget.onPicked(selectedFile!);
          }
        } else {
          FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image, );

          if (result != null) {

            setState(() {
              selectedFile = File(result.files.single.path!);
            });

            widget.onPicked(selectedFile!);
          } else {
            // User canceled the picker
          }
        }

      },
      child: DottedBorder(
        strokeWidth: 1,
        dashPattern: [8,4],
        radius: const Radius.circular(8),
        color: mainColor,
        child: Container(
            alignment: Alignment.center,
            width: defaultWidth,
            padding: EdgeInsets.all(30),
            decoration: BoxDecoration(
                color: mainColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.attach_file, size: 45, color: mainColor),
                SizedBox(height: 12),
                Text(
                  (selectedFile == null) ? "${widget.title}" : "${path.basename(selectedFile!.path)}",
                  textAlign: TextAlign.center,
                  style: blackFontStyle.copyWith(
                      fontWeight: FontWeight.w600,
                      color: (selectedFile == null) ? mainColor : blackColor),
                ),
                SizedBox(height: 12),
                Text(
                  "${widget.subtitle}",
                  textAlign: TextAlign.center,
                  style: blackFontStyle.copyWith(
                      fontWeight: FontWeight.w400,
                      color: greyColor),
                ),
              ],
            )
        ),
      ),
    );
  }
}
