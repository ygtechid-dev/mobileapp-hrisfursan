part of 'widgets.dart';

class FormCard extends StatefulWidget {
  FormCard({
    Key? key,
    this.labelText,
    @required this.outerLabelText,
    this.initialText,
    this.prefixSvg,
    this.prefixPadding,
    this.prefixOnTap,
    this.prefixHeight,
    this.prefixWidth,
    this.suffixSvg,
    this.suffixPadding,
    this.suffixOnTap,
    this.suffixHeight,
    this.suffixWidth,
    this.hintText,
    this.prefixText,
    this.inputFormatters,
    @required this.onSaved,
    @required this.validator,
    this.onTap,
    this.readOnly,
    this.obscure,
    this.enabled,
    this.controller,
    this.autoValidateMode,
    this.onChanged,
    this.maxLines,
    this.minLines,
    this.disableBorder,
    this.fillColor,
    this.hintStyle,
    @required this.filled,
    this.textStyle,
    this.cursorColor,
    this.autoFocused,
    this.onFieldSubmit,
    this.prefixWidget,
    this.hintDirection,
    this.textDirection,
    this.focusNode,
    this.capitalization,
    this.inputType,
    this.isDense,
    this.contentPadding,
    this.prefixIconColor,
    this.suffixIconColor,
    this.borderRadius,
    this.textInputAction,
    this.isRequired,
  }) : super(key: key);
  final String? labelText;
  final String? outerLabelText;
  final String? initialText;
  final String? suffixSvg, prefixSvg;
  final Widget? prefixWidget;
  final String? hintText;
  final String? prefixText;
  final int? maxLines;
  final int? minLines;
  bool? isRequired;
  TextDirection? hintDirection;
  final TextStyle? textStyle, hintStyle;
  final List<TextInputFormatter>? inputFormatters;
  bool? filled;
  EdgeInsetsGeometry? contentPadding;
  bool? readOnly, obscure, enabled, disableBorder, autoFocused, isDense;
  FormFieldValidator<String>? validator;
  FormFieldSetter<String>? onSaved, onFieldSubmit;
  VoidCallback? onTap;
  final VoidCallback? suffixOnTap, prefixOnTap;
  final EdgeInsets? suffixPadding, prefixPadding;
  final double? suffixHeight, suffixWidth, prefixHeight, prefixWidth;
  TextEditingController? controller;
  AutovalidateMode? autoValidateMode;
  void Function(String text)? onChanged;
  final Color? fillColor, cursorColor;
  final TextDirection? textDirection;
  final FocusNode? focusNode;
  final TextCapitalization? capitalization;
  final TextInputType? inputType;
  final Color? prefixIconColor, suffixIconColor;
  final double? borderRadius;
  TextInputAction? textInputAction;

  @override
  State<FormCard> createState() =>
      _FormCardState();
}

class _FormCardState extends State<FormCard> {
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
          border: Border.all(
              color: Colors.grey.shade200
          )
      ),
      child: TextFormField(
        textDirection: widget.textDirection,
        maxLines: widget.obscure ?? false ? 1 : widget.maxLines ?? 1,
        minLines: widget.minLines ?? 1,
        enabled: widget.enabled,
        initialValue: widget.initialText,
        controller: widget.controller,
        textInputAction: widget.textInputAction,
        obscureText: (widget.obscure ?? false) ? hidePassword : false,
        onChanged: widget.onChanged,
        cursorColor: widget.cursorColor ?? blackColor,
        autovalidateMode: widget.autoValidateMode,
        inputFormatters: widget.inputFormatters,
        autofocus: widget.autoFocused ?? false,
        focusNode: widget.focusNode,
        textCapitalization:
        widget.capitalization ?? TextCapitalization.sentences,
        keyboardType: widget.inputType,
        style: widget.textStyle ??
            GoogleFonts.inter().copyWith(
                fontSize: 12, fontWeight: FontWeight.w400),
        decoration: InputDecoration(
          isDense: widget.isDense ?? true,
          fillColor: widget.fillColor ?? Colors.white,
          filled: widget.filled,
          // focusedBorder: widget.disableBorder == true
          //     ? null
          //     : OutlineInputBorder(
          //   borderSide: const BorderSide(
          //     color: Colors.green,
          //     width: 1,
          //   ),
          //   borderRadius:
          //   BorderRadius.circular(widget.borderRadius ?? 10),
          // ),
          labelStyle: widget.hintStyle ??
              GoogleFonts.inter().copyWith(fontSize: 12, fontWeight: FontWeight.w400),
          hintStyle: widget.hintStyle ??
              GoogleFonts.inter().copyWith(
                  fontSize: 12, fontWeight: FontWeight.w400),
          hintTextDirection: widget.hintDirection,
          // contentPadding: widget.contentPadding ??
          //     EdgeInsets.only(
          //         top: 20, bottom: 20, left: 16, right: 16),
          // enabledBorder: widget.disableBorder == true
          //     ? null
          //     : OutlineInputBorder(
          //   borderSide: const BorderSide(
          //     color: Colors.blue,
          //     width: 1,
          //   ),
          //   borderRadius:
          //   BorderRadius.circular(widget.borderRadius ?? 10),
          // ),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius:
            BorderRadius.circular(widget.borderRadius ?? 2),
          ),

          // errorBorder: widget.disableBorder == true
          //     ? null
          //     : OutlineInputBorder(
          //   borderRadius:
          //   BorderRadius.circular(widget.borderRadius ?? 5),
          //   borderSide: const BorderSide(
          //     color: Colors.red,
          //     width: 1,
          //   ),
          // ),
          // focusedErrorBorder: OutlineInputBorder(
          //   borderSide: const BorderSide(
          //     color: Colors.red,
          //     width: 1,
          //   ),
          //   borderRadius: BorderRadius.circular(widget.borderRadius ?? 5),
          // ),
          // errorStyle: AppTextStyle.fieldErrorTextStyle,
          alignLabelWithHint: true,
          // labelText: widget.labelText,
          hintText: widget.labelText,

          prefixIcon: widget.prefixSvg != null
              ? Padding(
            padding: widget.prefixPadding ??
                EdgeInsets.only(
                  top: 0,
                  bottom: 0,
                  left: 0,
                ),
            child: IconButton(
              onPressed: widget.prefixOnTap,
              splashRadius: 20,
              icon: SvgPicture.asset(
                widget.prefixSvg!,
                height: widget.prefixHeight != null
                    ? widget.prefixHeight
                    : 24,
                width: widget.prefixWidth != null
                    ? widget.prefixWidth
                    : 24,
                color:
                widget.prefixIconColor ?? Colors.grey,
              ),
            ),
          )
              : null,
          suffixIconConstraints:
          BoxConstraints(minHeight: 20, minWidth: 20),
          suffixIcon: widget.obscure ?? false
              ? Padding(
            padding: EdgeInsets.only(right: 4),
            child: IconButton(
              onPressed: () {
                setState(() {
                  if (hidePassword) {
                    hidePassword = false;
                  } else {
                    hidePassword = true;
                  }
                });
              },
              icon: Icon(
                  hidePassword
                      ? Icons.remove_red_eye_outlined
                      : Icons.remove_red_eye,
                  size: 20
              ),
            ),
          )
              : widget.suffixSvg != null
              ? Padding(
            padding:
            widget.suffixPadding ?? EdgeInsets.only(right: 4),
            child: IconButton(
              onPressed: widget.suffixOnTap,
              // splashRadius: 12,
              icon: SvgPicture.asset(
                widget.suffixSvg!,
                height: widget.suffixHeight != null
                    ? widget.suffixHeight
                    : 20,
                width: widget.suffixWidth != null
                    ? widget.suffixWidth
                    : 20,
                color:
                widget.suffixIconColor ?? Colors.white,
              ),
              color: Colors.white,
            ),
          )
              : null,
        ),
        readOnly: widget.readOnly ?? false,
        onSaved: widget.onSaved,
        validator: widget.validator,
        onTap: widget.onTap,
        onFieldSubmitted: widget.onFieldSubmit,
      ),
    );
  }
}

class FormWithLabelCard extends StatefulWidget {
  FormWithLabelCard({
    Key? key,
    this.labelText,
    @required this.outerLabelText,
    this.initialText,
    this.prefixSvg,
    this.prefixPadding,
    this.prefixOnTap,
    this.invert = false,
    this.prefixHeight,
    this.prefixWidth,
    this.suffixSvg,
    this.suffixPadding,
    this.suffixOnTap,
    this.suffixHeight,
    this.suffixWidth,
    this.hintText,
    this.prefixText,
    this.inputFormatters,
    @required this.onSaved,
    @required this.validator,
    this.onTap,
    this.readOnly,
    this.obscure,
    this.enabled,
    this.controller,
    this.autoValidateMode,
    this.onChanged,
    this.maxLines,
    this.minLines,
    this.disableBorder,
    this.fillColor,
    this.hintStyle,
    @required this.filled,
    this.textStyle,
    this.cursorColor,
    this.autoFocused,
    this.onFieldSubmit,
    this.prefixWidget,
    this.hintDirection,
    this.textDirection,
    this.focusNode,
    this.capitalization,
    this.inputType,
    this.isDense,
    this.contentPadding,
    this.prefixIconColor,
    this.suffixIconColor,
    this.borderRadius,
    this.textInputAction,
    this.isRequired,
  }) : super(key: key);
  final String? labelText;
  final String? outerLabelText;
  final String? initialText;
  final String? suffixSvg, prefixSvg;
  final Widget? prefixWidget;
  final String? hintText;
  final String? prefixText;
  final int? maxLines;
  final int? minLines;
  bool? isRequired;
  TextDirection? hintDirection;
  final TextStyle? textStyle, hintStyle;
  final List<TextInputFormatter>? inputFormatters;
  bool? filled;
  bool? invert;
  EdgeInsetsGeometry? contentPadding;
  bool? readOnly, obscure, enabled, disableBorder, autoFocused, isDense;
  FormFieldValidator<String>? validator;
  FormFieldSetter<String>? onSaved, onFieldSubmit;
  VoidCallback? onTap;
  final VoidCallback? suffixOnTap, prefixOnTap;
  final EdgeInsets? suffixPadding, prefixPadding;
  final double? suffixHeight, suffixWidth, prefixHeight, prefixWidth;
  TextEditingController? controller;
  AutovalidateMode? autoValidateMode;
  void Function(String text)? onChanged;
  final Color? fillColor, cursorColor;
  final TextDirection? textDirection;
  final FocusNode? focusNode;
  final TextCapitalization? capitalization;
  final TextInputType? inputType;
  final Color? prefixIconColor, suffixIconColor;
  final double? borderRadius;
  TextInputAction? textInputAction;

  @override
  State<FormWithLabelCard> createState() =>
      _FormWithLabelCardState();
}

class _FormWithLabelCardState extends State<FormWithLabelCard> {
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (widget.outerLabelText != null) ? Container(
          child: Text(
            widget.outerLabelText ?? "",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: blackFontStyle.copyWith(
                fontSize: 13, fontWeight: FontWeight.w400),
            textAlign: TextAlign.left,
          ),
        ) : SizedBox(),
        (widget.outerLabelText != null) ? SizedBox(height: 7.5) : SizedBox(),
        Container(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: (widget.invert == true) ? "8D8D8D".toColor() : lightGreyColor,
              border: Border.all(
                  color: "E9E9E9".toColor()
              )
          ),
          child: TextFormField(
            textDirection: widget.textDirection,
            maxLines: widget.obscure ?? false ? 1 : widget.maxLines ?? 1,
            minLines: widget.minLines ?? 1,
            enabled: widget.enabled,
            initialValue: widget.initialText,
            controller: widget.controller,
            textInputAction: widget.textInputAction,
            obscureText: (widget.obscure ?? false) ? hidePassword : false,
            onChanged: widget.onChanged,
            cursorColor: widget.cursorColor ?? blackColor,
            autovalidateMode: widget.autoValidateMode,
            inputFormatters: widget.inputFormatters,
            autofocus: widget.autoFocused ?? false,
            focusNode: widget.focusNode,
            textCapitalization:
            widget.capitalization ?? TextCapitalization.sentences,
            keyboardType: widget.inputType,
            style: widget.textStyle ??
                GoogleFonts.inter().copyWith(
                    fontSize: 12, fontWeight: FontWeight.w400),
            decoration: InputDecoration(
              isDense: widget.isDense ?? true,
              fillColor: widget.fillColor ?? Colors.transparent,
              filled: widget.filled,
              contentPadding: EdgeInsets.zero,
              // focusedBorder: widget.disableBorder == true
              //     ? null
              //     : OutlineInputBorder(
              //   borderSide: const BorderSide(
              //     color: Colors.green,
              //     width: 1,
              //   ),
              //   borderRadius:
              //   BorderRadius.circular(widget.borderRadius ?? 10),
              // ),
              labelStyle: widget.hintStyle ??
                  GoogleFonts.inter().copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: (widget.invert == true) ? Colors.white : blackColor),
              hintStyle: widget.hintStyle ??
                  GoogleFonts.inter().copyWith(
                      fontSize: 12, fontWeight: FontWeight.w400, color: (widget.invert == true) ? Colors.white : greyColor),
              hintTextDirection: widget.hintDirection,
              // contentPadding: widget.contentPadding ??
              //     EdgeInsets.only(
              //         top: 20, bottom: 20, left: 16, right: 16),
              // enabledBorder: widget.disableBorder == true
              //     ? null
              //     : OutlineInputBorder(
              //   borderSide: const BorderSide(
              //     color: Colors.blue,
              //     width: 1,
              //   ),
              //   borderRadius:
              //   BorderRadius.circular(widget.borderRadius ?? 10),
              // ),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius:
                BorderRadius.circular(widget.borderRadius ?? 2),
              ),
              alignLabelWithHint: true,
              // labelText: widget.labelText,
              hintText: widget.hintText,
              prefixIcon: widget.prefixSvg != null
                  ? Padding(
                padding: widget.prefixPadding ??
                    EdgeInsets.only(
                      top: 0,
                      bottom: 0,
                      left: 0,
                    ),
                child: IconButton(
                  onPressed: widget.prefixOnTap,
                  splashRadius: 20,
                  icon: SvgPicture.asset(
                    widget.prefixSvg!,
                    height: widget.prefixHeight != null
                        ? widget.prefixHeight
                        : 24,
                    width: widget.prefixWidth != null
                        ? widget.prefixWidth
                        : 24,
                    color:
                    widget.prefixIconColor ?? Colors.grey,
                  ),
                ),
              )
                  : null,
              suffixIconConstraints:
              BoxConstraints(minHeight: 0, minWidth: 0),
              suffixIcon: widget.obscure ?? false
                  ? Padding(
                padding: EdgeInsets.only(right: 4),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      if (hidePassword) {
                        hidePassword = false;
                      } else {
                        hidePassword = true;
                      }
                    });
                  },
                  child: Icon(
                      hidePassword
                          ? Icons.remove_red_eye_outlined
                          : Icons.remove_red_eye,
                      size: 20,
                    color: greyColor,
                  ),
                ),
              )
                  : widget.suffixSvg != null
                  ? Padding(
                padding:
                widget.suffixPadding ?? EdgeInsets.only(right: 4),
                child: InkWell(
                  onTap: widget.suffixOnTap,
                  // splashRadius: 12,
                  child: SvgPicture.asset(
                    widget.suffixSvg!,
                    height: widget.suffixHeight != null
                        ? widget.suffixHeight
                        : 20,
                    width: widget.suffixWidth != null
                        ? widget.suffixWidth
                        : 20,
                    color:
                    widget.suffixIconColor ?? Colors.white,
                  ),
                  // color: Colors.white,
                ),
              )
                  : null,
            ),
            readOnly: widget.readOnly ?? false,
            onSaved: widget.onSaved,
            validator: widget.validator,
            onTap: widget.onTap,
            onFieldSubmitted: widget.onFieldSubmit,
          ),
        )
      ],
    );
  }
}

class FormDropdownCard extends StatefulWidget {
  FormDropdownCard({
    Key? key,
    this.labelText,
    @required this.listItem,
    @required this.outerLabelText,
    this.initialText,
    this.prefixSvg,
    this.prefixPadding,
    this.initialValue,
    this.prefixOnTap,
    this.prefixHeight,
    this.prefixWidth,
    this.suffixSvg,
    this.suffixPadding,
    this.suffixOnTap,
    this.suffixHeight,
    this.suffixWidth,
    this.hintText,
    this.prefixText,
    this.inputFormatters,
    @required this.onSaved,
    @required this.validator,
    this.onTap,
    this.readOnly,
    this.obscure,
    this.enabled,
    this.autoValidateMode,
    this.onChanged,
    this.maxLines,
    this.minLines,
    this.disableBorder,
    this.fillColor,
    this.hintStyle,
    @required this.filled,
    this.textStyle,
    this.cursorColor,
    this.autoFocused,
    this.onFieldSubmit,
    this.prefixWidget,
    this.hintDirection,
    this.textDirection,
    this.focusNode,
    this.capitalization,
    this.inputType,
    this.isDense,
    this.contentPadding,
    this.prefixIconColor,
    this.suffixIconColor,
    this.borderRadius,
    this.textInputAction,
    this.isRequired,
  }) : super(key: key);
  final String? labelText;
  final String? outerLabelText;
  final String? initialText;
  final String? suffixSvg, prefixSvg;
  final Widget? prefixWidget;
  final String? hintText;
  final String? prefixText;
  final int? maxLines;
  final List<String>? initialValue;
  final List<List<String>>? listItem;
  final int? minLines;
  bool? isRequired;
  TextDirection? hintDirection;
  final TextStyle? textStyle, hintStyle;
  final List<TextInputFormatter>? inputFormatters;
  bool? filled;
  EdgeInsetsGeometry? contentPadding;
  bool? readOnly, obscure, enabled, disableBorder, autoFocused, isDense;
  FormFieldValidator<String>? validator;
  FormFieldSetter<String>? onSaved, onFieldSubmit;
  VoidCallback? onTap;
  final VoidCallback? suffixOnTap, prefixOnTap;
  final EdgeInsets? suffixPadding, prefixPadding;
  final double? suffixHeight, suffixWidth, prefixHeight, prefixWidth;
  AutovalidateMode? autoValidateMode;
  void Function(String text)? onChanged;
  final Color? fillColor, cursorColor;
  final TextDirection? textDirection;
  final FocusNode? focusNode;
  final TextCapitalization? capitalization;
  final TextInputType? inputType;
  final Color? prefixIconColor, suffixIconColor;
  final double? borderRadius;
  TextInputAction? textInputAction;

  @override
  State<FormDropdownCard> createState() =>
      _FormDropdownCardState();
}

class _FormDropdownCardState extends State<FormDropdownCard> {
  bool? hidePassword = true;

  List<String>? selectedValue;


  @override
  void initState() {

    selectedValue = widget.initialValue;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    print(selectedValue.toString());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Text(
            widget.outerLabelText ?? "",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: blackFontStyle.copyWith(
                fontSize: 13, fontWeight: FontWeight.w400),
            textAlign: TextAlign.left,
          ),
        ),
        SizedBox(height: 7.5),
        Container(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: lightGreyColor,
              border: Border.all(
                  color: "E9E9E9".toColor()
              )
          ),
          child: FormField<String>(
            onSaved: widget.onSaved,
            validator: widget.validator,
            builder: (FormFieldState<String> state2) {
              return InputDecorator(
                // isHovering: isFocus,
                decoration: InputDecoration(
                  isDense: widget.isDense ?? true,
                  focusedBorder: widget.disableBorder == true
                      ? null
                      : OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius:
                    BorderRadius.circular(widget.borderRadius ?? 10),
                  ),
                  hintStyle: widget.hintStyle ??
                      GoogleFonts.inter().copyWith(
                          fontSize: 12, fontWeight: FontWeight.w400),
                  hintTextDirection: widget.hintDirection,
                  fillColor: widget.fillColor ?? Colors.transparent,
                  filled: widget.filled,
                  contentPadding: EdgeInsets.zero,
                  // enabledBorder: widget.disableBorder == true
                  //     ? null
                  //     : OutlineInputBorder(
                  //   borderSide: const BorderSide(
                  //     color: AppColors.kTextfieldFillColor,
                  //     width: 1,
                  //   ),
                  //   borderRadius:
                  //   BorderRadius.circular(widget.borderRadius ?? 10.r),
                  // ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius:
                    BorderRadius.circular(widget.borderRadius ?? 2),
                  ),

                  // errorBorder: widget.disableBorder == true
                  //     ? null
                  //     : OutlineInputBorder(
                  //   borderRadius:
                  //   BorderRadius.circular(widget.borderRadius ?? 10.r),
                  //   borderSide: const BorderSide(
                  //     color: AppColors.kDanger50Color,
                  //     width: 1,
                  //   ),
                  // ),
                  // focusedErrorBorder: OutlineInputBorder(
                  //   borderSide: const BorderSide(
                  //     color: AppColors.kTextfieldFillColor,
                  //     width: 1,
                  //   ),
                  //   borderRadius: BorderRadius.circular(widget.borderRadius ?? 10.r),
                  // ),
                  // errorStyle: AppTextStyle.fieldErrorTextStyle,
                  alignLabelWithHint: true,
                  labelText: widget.labelText,
                  hintText: widget.hintText,
                  prefixIcon: widget.prefixSvg != null
                      ? Padding(
                    padding: widget.prefixPadding ??
                        EdgeInsets.only(
                          top: 0,
                          bottom: 0,
                          left: 0,
                        ),
                    child: IconButton(
                      onPressed: widget.prefixOnTap,
                      splashRadius: 20,
                      icon: SvgPicture.asset(
                        widget.prefixSvg!,
                        height: widget.prefixHeight != null
                            ? widget.prefixHeight
                            : 24,
                        width: widget.prefixWidth != null
                            ? widget.prefixWidth
                            : 24,
                        color:
                        widget.prefixIconColor ?? blackColor,
                      ),
                    ),
                  )
                      : null,
                  suffixIconConstraints:
                  BoxConstraints(minHeight: 20, minWidth: 20),
                  // suffixIcon: widget.obscure ?? false
                  //     ? Padding(
                  //   padding: EdgeInsets.only(right: 4),
                  //   child: IconButton(
                  //     onPressed: () {
                  //       setState(() {
                  //         if (hidePassword) {
                  //           hidePassword = false;
                  //         } else {
                  //           hidePassword = true;
                  //         }
                  //       });
                  //     },
                  //     icon: SvgPicture.asset(
                  //       hidePassword
                  //           ? AppAssets.eyeSlashIcon
                  //           : AppAssets.eyeIcon,
                  //       height: 20,
                  //       width: 20,
                  //     ),
                  //   ),
                  // )
                  //     : widget.suffixSvg != null
                  //     ? Padding(
                  //   padding:
                  //   widget.suffixPadding ?? EdgeInsets.only(right: 4),
                  //   child: IconButton(
                  //     onPressed: widget.suffixOnTap,
                  //     // splashRadius: 12,
                  //     icon: SvgPicture.asset(
                  //       widget.suffixSvg,
                  //       height: widget.suffixHeight != null
                  //           ? widget.suffixHeight
                  //           : 20,
                  //       width: widget.suffixWidth != null
                  //           ? widget.suffixWidth
                  //           : 20,
                  //       color:
                  //       widget.suffixIconColor ?? Colors.white,
                  //     ),
                  //     color: Colors.white,
                  //   ),
                  // )
                  //     : null,
                ),
                isEmpty: selectedValue == null,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<List<String>>(
                    value: selectedValue,
                    isDense: true,
                    onChanged: (List<String>? newValue) async {

                      print("${newValue}");

                      setState(() {
                        selectedValue = newValue;
                        widget.onSaved!(selectedValue![0]);
                      });

                    },
                    items:
                    widget.listItem!.map((List<String> value) {
                      return DropdownMenuItem<List<String>>(
                        value: value ?? [],
                        child: Text(value[1] ?? "", style: GoogleFonts.inter().copyWith(
                            fontSize: 12, fontWeight: FontWeight.w400)),
                      );
                    }).toList(),
                  ),
                ),
              );
            },
          )
        )
      ],
    );
  }
}

class FormSelectorCard extends StatefulWidget {
  final String? label;
  final List<String>? listSelector;
  final ValueChanged<String>? onSelected;

  FormSelectorCard({this.label, this.listSelector, this.onSelected});

  @override
  State<FormSelectorCard> createState() => _FormSelectorCardState();
}

class _FormSelectorCardState extends State<FormSelectorCard> {
  String? selectedValue;

  @override
  void initState() {

    selectedValue = widget.listSelector![0];
    // widget.onSelected(selectedValue);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Text(
            widget.label ?? "",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: blackFontStyle.copyWith(
                fontSize: 13, fontWeight: FontWeight.w400),
            textAlign: TextAlign.left,
          ),
        ),
        SizedBox(height: 7.5),
        Wrap(
          alignment: WrapAlignment.start,
          spacing: 10,
          runSpacing: 10,
          children: widget.listSelector!.map((e) => ButtonCard(e, null, (selectedValue == e) ? mainColor : greyColor, radius: 5, isBold: false, isActive: true, isHover: false, backColor: (selectedValue == e) ? lightMainColor2 : lightGreyColor, factorial: 11, padding: 8, paddingHorizontal: 10, fontSize: 11, fontColor: (selectedValue == e) ? mainColor : blackColor, onPressed: (){
            setState(() {
              selectedValue = e;
              widget.onSelected!(selectedValue!);
            });
          })).toList(),
        )
      ],
    );
  }
}
