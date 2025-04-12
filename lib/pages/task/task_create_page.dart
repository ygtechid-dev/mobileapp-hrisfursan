part of '../pages.dart';

class TaskCreatePage extends StatefulWidget {
  final String token;
  final String projects_id;

  TaskCreatePage(this.token, this.projects_id);

  @override
  State<TaskCreatePage> createState() => _TaskCreatePageState();
}

class _TaskCreatePageState extends State<TaskCreatePage> {
  TextEditingController taskTitleC = TextEditingController();
  TextEditingController dueDateC = TextEditingController();
  TextEditingController assignToC = TextEditingController();
  TextEditingController descriptionC = TextEditingController();
  TextEditingController linkC = TextEditingController();
  TextEditingController priorityC = TextEditingController();

  String? selectedAssignee;

  bool isAgree = false;

  String selectedPriority = "low";
  bool isLoading = false;

  List<File> selectedFile = [];

  DateTime selectedDate = DateTime.now();

  bool initAssignee = false;
  List<List<String>> listPriority = [["low", "Low"], ["medium", "Medium"], ["high", "High"]];

  List<List<String>> listData = [];

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
        dueDateC.text = data;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<AssigneeCubit>().getAssignee(widget.token);
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
      title: "create_task".trans(context),
      onBackButtonPressed: (){
        Get.back();
      },
      backColor: "F1F3F8".toColor(),
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
                      FormWithLabelCard(
                          outerLabelText: "task_title".trans(context),
                          hintText: "Input ${"task_title".trans(context)}",
                          controller: taskTitleC,
                          prefixSvg: "${prefixIcons}ic_form_title.svg",
                          onSaved: (e) {
                            taskTitleC.text = e ?? "";
                          },
                          validator: (e) {
                            return simpleValidator(e, null);
                          },
                          filled: true),
                      SizedBox(height: 20),
                      FormWithLabelCard(
                          outerLabelText: "due_date".trans(context),
                          hintText: "Input ${"due_date".trans(context)}",
                          controller: dueDateC,
                          prefixSvg: "${prefixIcons}ic_form_date.svg",
                          onSaved: (e) {
                            dueDateC.text = e ?? "";
                          },
                          onTap: (){
                            _selectDate(context);
                          },
                          validator: (e) {
                            return simpleValidator(e, null);
                          },
                          filled: true),
                      SizedBox(height: 20),
                      BlocBuilder<AssigneeCubit, AssigneeState>(
                          builder: (context, state) {
                            if (state is AssigneeLoaded){
                              if (state.data != null) {

                                if(initAssignee == false){
                                  listData.clear();
                                  state.data!.forEach((items){
                                    var temp = ["${items.id}", "${items.name}"];

                                    listData.add(temp);
                                  });
                                  initAssignee = true;
                                }

                                return FormDropdownCard(
                                    outerLabelText: "assign_to".trans(context),
                                    hintText: "Input ${"assign_to".trans(context)}".trans(context),
                                    prefixSvg: "${prefixIcons}ic_form_assign.svg",
                                    listItem: listData,
                                    initialValue: listData.isEmpty ? null : listData[0],
                                    validator: (e) {
                                      return simpleValidator(e, null);
                                    },
                                    filled: true,
                                    onSaved: (String? newValue) async {
                                      setState((){
                                        selectedAssignee = newValue;
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
                      SizedBox(height: 20),
                      FormDropdownCard(
                          outerLabelText: "priority".trans(context),
                          hintText: "priority".trans(context),
                          prefixSvg: "${prefixIcons}ic_position.svg",
                          listItem: listPriority,
                          initialValue: listPriority[0],
                          validator: (e) {
                            return simpleValidator(e, null);
                          },
                          filled: true,
                          onSaved: (String? newValue) async {
                            setState((){
                              selectedPriority = newValue!;
                            });
                          }
                      ),
                      SizedBox(height: 20),
                      FormWithLabelCard(
                          outerLabelText: "task_description".trans(context),
                          hintText: "Input ${"task_description".trans(context)}",
                          controller: descriptionC,
                          inputType: TextInputType.multiline,
                          maxLines: 6,
                          minLines: 6,
                          onSaved: (e) {
                            descriptionC.text = e ?? "";
                          },
                          validator: (e) {
                            return simpleValidator(e, null);
                          },
                          filled: true),
                      SizedBox(height: 20),
                      Container(
                        width: defaultWidth - 2*defaultMargin3,
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "attachment".trans(context),
                              textAlign: TextAlign.start,
                              style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 3),
                            Text(
                              "format_should".trans(context),
                              textAlign: TextAlign.start,
                              style: greyFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                            ),
                          ]
                        ),
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CommonDottedButtonWithImage((defaultWidth - 2*defaultMargin3)/3 - 10, onPicked: (value){
                            setState(() {
                              selectedFile.add(value);
                            });
                          }, icon: "${prefixIcons}ic_add_picture.svg"),
                          CommonDottedButtonWithImage((defaultWidth - 2*defaultMargin3)/3 - 10, onPicked: (value){
                            setState(() {
                              selectedFile.add(value);
                            });
                          }, icon: "${prefixIcons}ic_add_picture.svg"),
                          CommonDottedButtonWithImage((defaultWidth - 2*defaultMargin3)/3 - 10, onPicked: (value){
                            setState(() {
                              selectedFile.add(value);
                            });
                          }, icon: "${prefixIcons}ic_add_picture.svg"),
                        ],
                      ),
                      SizedBox(height: 20),
                      FormWithLabelCard(
                          outerLabelText: "add_link".trans(context),
                          hintText: "Input ${"add_link".trans(context)}",
                          controller: linkC,
                          prefixSvg: "${prefixIcons}ic_form_link.svg",
                          onSaved: (e) {
                            linkC.text = e ?? "";
                          },
                          validator: (e) {
                            return simpleValidator(e, null);
                          },
                          filled: true),
                      SizedBox(height: 60),
                    ],
                  )
              ),
              SizedBox(height: 20),
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
        child: ButtonCard("create_task".trans(context), defaultWidth - 2*24, mainColor, isLoading: isLoading, colorGradient: buttonGradient, onPressed: () async {
          if(taskTitleC.text.isNotEmpty && dueDateC.text.isNotEmpty && selectedAssignee != null){
            setState(() {
              isLoading = true;
            });

            await TaskServices.createTask(widget.token, "${widget.projects_id}", "${taskTitleC.text}", "${descriptionC.text}", "${selectedPriority}", "${dueDateC.text}", linkC.text, selectedAssignee!, selectedFile).then((result) async {

              if(result != null && result.value != null){

                setState(() {
                  isLoading = false;
                });

                Fluttertoast.showToast(
                    msg: "success_submit".trans(context),
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0
                );

                await context.read<TaskCubit>().getTask(widget.token);

                Get.to(MainPage(token: widget.token, index_: 3));

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
