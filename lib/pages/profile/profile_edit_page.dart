part of "../pages.dart";

class ProfileEditPage extends StatefulWidget {
  final String token;
  final User user;

  ProfileEditPage(this.token, this.user);

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  TextEditingController firstNameC = TextEditingController();
  TextEditingController lastNameC = TextEditingController();
  TextEditingController dateC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  TextEditingController positionC = TextEditingController();
  TextEditingController addressC = TextEditingController();
  TextEditingController stateC = TextEditingController();
  TextEditingController countryC = TextEditingController();
  TextEditingController cityC = TextEditingController();

  bool isAgree = false;

  bool initDesignation = false;

  List<List<String>> listData = [];

  File? selectedFile;

  Future<bool> _checkPermission() async {
    if (Platform.isIOS) {
      return true;
    }

    if (Platform.isAndroid) {

      DeviceInfoPlugin plugin = DeviceInfoPlugin();
      AndroidDeviceInfo android = await plugin.androidInfo;

      if (android.version.sdkInt < 33) {
        final status = await Permission.storage.status;
        if (status == PermissionStatus.granted) {
          return true;
        }

        final result = await Permission.storage.request();
        return result == PermissionStatus.granted;
      } else {
        return true;
      }

    }

    throw StateError('unknown platform');
  }

  @override
  void initState() {
    super.initState();
    context.read<DesignationCubit>().getDesignations(widget.token);

    firstNameC.text = widget.user.first_name ?? "";
    lastNameC.text = widget.user.last_name ?? "";
    dateC.text = widget.user.dob ?? "";
    phoneC.text = widget.user.phone ?? "";
    positionC.text = widget.user.first_name ?? "";
    addressC.text = widget.user.address ?? "";

    if(widget.user!.employee!.designation != null && widget.user!.employee!.designation!.id != null){
      selectedDesignationInit = ["${widget.user!.employee!.designation!.id}", "${widget.user!.employee!.designation!.name}"];
    }

  }

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {

    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1980, 8),
        lastDate: DateTime(2040)
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;

        String data = DateFormat('yyyy-MM-dd').format(selectedDate);
        dateC.text = data;
      });
    }
  }

  bool isLoading = false;

  String? selectedDesignation;
  List<String>? selectedDesignationInit;


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
      title: "edit_account".trans(context),
      onBackButtonPressed: (){
        Get.back();
      },
      appBarColor: Colors.white,
      child: Container(
          width: fullWidth,
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: defaultMargin2),
          alignment: Alignment.center,
          child: Column(
            children: [
              Container(
                  width: defaultWidth,
                  padding: EdgeInsets.symmetric(vertical: 24, horizontal: defaultMargin3),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Container(
                        width: itemWidth,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "my_personal_data".trans(context),
                          textAlign: TextAlign.start,
                          style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(height: 3),
                      Container(
                        width: itemWidth,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "details_about".trans(context),
                          textAlign: TextAlign.start,
                          style: greyFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                          height: 116,
                          width: 116,
                          margin: EdgeInsets.only(left: 16),
                          child: Stack(
                            children: [
                              Positioned(
                                bottom: 0,
                                left: 0,
                                child: (widget.user!.avatar != null && widget.user!.avatar != "") ? (selectedFile != null) ? Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                      color: CupertinoColors.systemGrey2,
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(color: mainColor),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: FileImage(selectedFile!)
                                      )
                                  ),
                                ) : Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                      color: CupertinoColors.systemGrey2,
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(color: mainColor),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: CachedNetworkImageProvider("${widget.user!.avatar}")
                                      )
                                  ),
                                ) : (selectedFile != null) ? Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                      color: CupertinoColors.systemGrey2,
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(color: mainColor),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: FileImage(selectedFile!)
                                      )
                                  ),
                                ) : Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                      color: CupertinoColors.systemGrey2,
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(color: mainColor),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage("${prefixImages}img_avatar_dummy.png")
                                      )
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: InkWell(
                                  onTap: () async {

                                    _checkPermission().then((value) async {
                                      if(value == true){
                                        FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
                                        if (result != null) {
                                          setState(() {
                                            selectedFile = File(result.files.single.path!);
                                          });
                                        } else {
                                          // User canceled the picker
                                        }
                                      } else {
                                        Fluttertoast.showToast(
                                            msg: "Please grant permission for storage access",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0
                                        );
                                      }
                                    });
                                  },
                                  child: SvgPicture.asset("${prefixIcons}ic_suffle.svg", width: 32, height: 32,),
                                )
                              )

                            ],
                          )
                      ),
                      SizedBox(height: 10),
                      Text(
                        "upload_photo".trans(context),
                        textAlign: TextAlign.center,
                        style: greyFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "format_should".trans(context),
                        textAlign: TextAlign.center,
                        style: greyFontStyle.copyWith(fontSize: 10, fontWeight: FontWeight.w400),
                      ),

                      FormWithLabelCard(
                          outerLabelText: "first_name".trans(context),
                          hintText: "first_name_input".trans(context),
                          controller: firstNameC,
                          prefixSvg: "${prefixIcons}ic_user.svg",
                          onSaved: (e) {
                            firstNameC.text = e ?? "";
                          },
                          validator: (e) {
                            return simpleValidator(e, null);
                          },
                          filled: true),
                      SizedBox(height: 20),
                      FormWithLabelCard(
                          outerLabelText: "last_name".trans(context),
                          hintText: "last_name_input".trans(context),
                          controller: lastNameC,
                          prefixSvg: "${prefixIcons}ic_user.svg",
                          onSaved: (e) {
                            lastNameC.text = e ?? "";
                          },
                          validator: (e) {
                            return simpleValidator(e, null);
                          },
                          filled: true),
                      SizedBox(height: 20),
                      FormWithLabelCard(
                          outerLabelText: "phone_number".trans(context),
                          hintText: "+62 0000 0000 0000",
                          controller: phoneC,
                          inputType: TextInputType.number,
                          prefixSvg: "${prefixIcons}ic_phone.svg",
                          onSaved: (e) {
                            phoneC.text = e ?? "";
                          },
                          validator: (e) {
                            return phoneValidator(e, null);
                          },
                          filled: true),
                      SizedBox(height: 20),
                      FormWithLabelCard(
                          outerLabelText: "date_of_birth".trans(context),
                          hintText: "date_of_birth".trans(context),
                          controller: dateC,
                          prefixSvg: "${prefixIcons}ic_calendar.svg",
                          onTap: (){
                            _selectDate(context);
                          },
                          onSaved: (e) {
                            dateC.text = e ?? "";
                          },
                          validator: (e) {
                            return simpleValidator(e, null);
                          },
                          filled: true),
                      SizedBox(height: 20),
                      BlocBuilder<DesignationCubit, DesignationState>(
                          builder: (context, state) {
                            if (state is DesignationLoaded){
                              if (state.data != null) {

                                if(initDesignation == false){
                                  listData.clear();
                                  state.data!.forEach((items){
                                    var temp = ["${items.id}", "${items.name}"];

                                    listData.add(temp);
                                  });
                                  initDesignation = true;
                                }

                                return FormDropdownCard(
                                    outerLabelText: "position".trans(context),
                                    hintText: "enter_position".trans(context),
                                    prefixSvg: "${prefixIcons}ic_position.svg",
                                    listItem: listData,
                                    validator: (e) {
                                      return simpleValidator(e, null);
                                    },
                                    initialValue: (selectedDesignationInit != null) ? listData.firstWhere((e) => e[0] == selectedDesignationInit![0]) : null,
                                    filled: true,
                                    onSaved: (String? newValue) async {
                                      setState((){
                                        selectedDesignation = newValue;
                                      });
                                    }
                                );
                              } else {
                                return SizedBox();
                              }
                            } else {
                              return loadingIndicator;
                            }
                          }
                      ),
                    ],
                  )
              ),
              SizedBox(height: 20),
              Container(
                  width: defaultWidth,
                  padding: EdgeInsets.symmetric(vertical: 24, horizontal: defaultMargin3),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Container(
                        width: itemWidth,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "address".trans(context),
                          textAlign: TextAlign.start,
                          style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(height: 3),
                      Container(
                        width: itemWidth,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "current_domicile".trans(context),
                          textAlign: TextAlign.start,
                          style: greyFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                        ),
                      ),
                      // SizedBox(height: 20),
                      // FormWithLabelCard(
                      //     controller: countryC,
                      //     outerLabelText: "country".trans(context),
                      //     hintText: "enter_country".trans(context),
                      //     prefixSvg: "${prefixIcons}ic_location.svg",
                      //     onSaved: (e) {
                      //
                      //     },
                      //     validator: (e) {
                      //       return simpleValidator(e, null);
                      //     },
                      //     filled: true),
                      // SizedBox(height: 20),
                      // FormWithLabelCard(
                      //     controller: stateC,
                      //     outerLabelText: "state".trans(context),
                      //     hintText: "Enter State".trans(context),
                      //     prefixSvg: "${prefixIcons}ic_location.svg",
                      //     onSaved: (e) {
                      //
                      //     },
                      //     validator: (e) {
                      //       return simpleValidator(e, null);
                      //     },
                      //     filled: true),
                      // SizedBox(height: 20),
                      // FormWithLabelCard(
                      //     controller: cityC,
                      //     outerLabelText: "city".trans(context),
                      //     hintText: "enter_city".trans(context),
                      //     prefixSvg: "${prefixIcons}ic_location.svg",
                      //     onSaved: (e) {
                      //
                      //     },
                      //     validator: (e) {
                      //       return simpleValidator(e, null);
                      //     },
                      //     filled: true),
                      SizedBox(height: 20),
                      FormWithLabelCard(
                          outerLabelText: "full_address".trans(context),
                          hintText: "full_address_input".trans(context),
                          controller: addressC,
                          minLines: 6,
                          maxLines: 6,
                          onSaved: (e) {
                            addressC.text = e ?? "";
                          },
                          validator: (e) {
                            return simpleValidator(e, null);
                          },
                          filled: true),
                      SizedBox(height: 60,)
                    ],
                  )
              ),
            ],
          )
      ),
      navBar: Container(
        width: fullWidth,
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: boxShadow
        ),
        child: ButtonCard("Save", defaultWidth - 2*24, mainColor, colorGradient: (firstNameC.text.isNotEmpty && phoneC.text.isNotEmpty && lastNameC.text.isNotEmpty) ? buttonGradient : buttonGradientGrey, onPressed: () async {
          if(firstNameC.text.isNotEmpty && phoneC.text.isNotEmpty && lastNameC.text.isNotEmpty){
            setState(() {
              isLoading = true;
            });

            User user = User(
              phone: phoneC.text,
              dob: dateC.text,
              first_name: firstNameC.text,
              last_name: lastNameC.text,
              designation_id: selectedDesignation,
              address: "${addressC.text}, ${cityC.text}, ${stateC.text}, ${countryC.text}",
            );

            await UserServices.update(widget.token, user).then((result) async {

              if(result != null && result.value != null){

                if(selectedFile != null){
                  await UserServices.updatePhoto(widget.token, selectedFile!).then((result) async {

                    if(result != null && result.value != null){
                      await context.read<UserCubit>().getProfile(widget.token);

                      setState(() {
                        isLoading = false;
                      });

                      Fluttertoast.showToast(
                          msg: "success_update".trans(context),
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );

                      Get.to(MainPage(token: widget.token, index_: 4,));

                    } else {
                      setState(() {
                        isLoading = false;
                      });

                      Fluttertoast.showToast(
                          msg: "${result.message}",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                    }


                  });
                } else {
                  await context.read<UserCubit>().getProfile(widget.token);

                  setState(() {
                    isLoading = false;
                  });

                  Fluttertoast.showToast(
                      msg: "success_update".trans(context),
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 16.0
                  );

                  Get.to(MainPage(token: widget.token, index_: 4,));
                }



              } else {
                setState(() {
                  isLoading = false;
                });

                Fluttertoast.showToast(
                    msg: "${result.message}",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
              }


            });



          }
        }),
      ),
    );
  }
}
