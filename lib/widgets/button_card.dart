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
