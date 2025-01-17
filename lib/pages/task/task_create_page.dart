part of '../pages.dart';

class TaskCreatePage extends StatefulWidget {

  @override
  State<TaskCreatePage> createState() => _TaskCreatePageState();
}

class _TaskCreatePageState extends State<TaskCreatePage> {
  TextEditingController taskTitleC = TextEditingController();
  TextEditingController dueDateC = TextEditingController();
  TextEditingController assignToC = TextEditingController();
  TextEditingController descriptionC = TextEditingController();
  TextEditingController linkC = TextEditingController();

  bool isAgree = false;

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
      title: "Create New Task",
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
                          outerLabelText: "Task Title",
                          hintText: "Input Task Title",
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
                          outerLabelText: "Due Date",
                          hintText: "Input Due Date",
                          controller: dueDateC,
                          prefixSvg: "${prefixIcons}ic_form_date.svg",
                          onSaved: (e) {
                            dueDateC.text = e ?? "";
                          },
                          validator: (e) {
                            return simpleValidator(e, null);
                          },
                          filled: true),
                      SizedBox(height: 20),
                      FormWithLabelCard(
                          outerLabelText: "Assign To",
                          hintText: "Input Assign To",
                          controller: assignToC,
                          prefixSvg: "${prefixIcons}ic_form_assign.svg",
                          onSaved: (e) {
                            assignToC.text = e ?? "";
                          },
                          validator: (e) {
                            return simpleValidator(e, null);
                          },
                          filled: true),
                      SizedBox(height: 20),
                      FormWithLabelCard(
                          outerLabelText: "Task Description",
                          hintText: "Task Description",
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
                              "Attachment",
                              textAlign: TextAlign.start,
                              style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 3),
                            Text(
                              "Format should be in .pdf .jpeg .png less than 5MB",
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

                            });
                          }, icon: "${prefixIcons}ic_add_picture.svg"),
                          CommonDottedButtonWithImage((defaultWidth - 2*defaultMargin3)/3 - 10, onPicked: (value){
                            setState(() {

                            });
                          }, icon: "${prefixIcons}ic_add_picture.svg"),
                          CommonDottedButtonWithImage((defaultWidth - 2*defaultMargin3)/3 - 10, onPicked: (value){
                            setState(() {

                            });
                          }, icon: "${prefixIcons}ic_add_picture.svg"),
                        ],
                      ),
                      SizedBox(height: 20),
                      FormWithLabelCard(
                          outerLabelText: "Add Link File",
                          hintText: "Input Add Link File",
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
        child: ButtonCard("Create Task", defaultWidth - 2*24, mainColor, colorGradient: buttonGradient, onPressed: () async {
          Get.to(MainPage(index_: 3));
        }),
      ),
    );
  }
  
}
