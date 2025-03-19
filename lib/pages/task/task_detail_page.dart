part of '../pages.dart';

class TaskDetailPage extends StatefulWidget {
  final String title;

  TaskDetailPage(this.title);

  @override
  State<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  TextEditingController taskTitleC = TextEditingController();
  TextEditingController dueDateC = TextEditingController();
  TextEditingController assignToC = TextEditingController();
  TextEditingController descriptionC = TextEditingController();
  TextEditingController linkC = TextEditingController();

  bool isAgree = false;

  List<String> menuEvents = [
    "To Do",
    "In Progress",
    "Done",
  ];

  String selectedMenu = "To Do";

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
      title: "${widget.title}",
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PopupMenuButton<String>(
                            padding: EdgeInsets.all(0),
                            icon: statusCard(selectedMenu),
                            onSelected: (String selected) async {
                              setState(() {
                                selectedMenu = selected;
                              });
                            },
                            itemBuilder: (BuildContext context) {
                              return menuEvents.map((String choice) {
                                return PopupMenuItem<String>(
                                  value: choice,
                                  child: Text(choice),
                                );
                              }).toList();
                            },
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(Icons.remove_red_eye_outlined, size: 20, color: mainColor),
                                SizedBox(width: 12),
                                Icon(Icons.more_vert_outlined, size: 20, color: mainColor),
                              ]
                          ),
                        ]
                      ),
                      SizedBox(height: 16),
                      Container(
                          width: fullWidth - 2*15,
                          padding: EdgeInsets.symmetric(vertical: 10.5, horizontal: 12),
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            color: "F9FAFB".toColor(),
                            border: Border.all(color: "EAECF0".toColor()),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 52,
                                height: 52,
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
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Adam Sudjana",
                                    textAlign: TextAlign.start,
                                    style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    "Graphic Designer",
                                    textAlign: TextAlign.start,
                                    style: blackFontStyle.copyWith(fontSize: 12, color: mainColor, fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ],
                          )
                      ),
                      SizedBox(height: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "due_date".trans(context),
                            textAlign: TextAlign.start,
                            style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Icon(Icons.date_range, size: 18, color: mainColor ),
                              SizedBox(width: 5),
                              Text(
                                "27 December 2024",
                                textAlign: TextAlign.start,
                                style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w600),
                              ),
                            ]
                          )
                        ],
                      ),
                      SizedBox(height: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "priority".trans(context),
                            textAlign: TextAlign.start,
                            style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                          ),
                          SizedBox(height: 5),
                          Row(
                              children: [
                                Icon(Icons.layers_outlined, size: 18, color: mainColor ),
                                SizedBox(width: 5),
                                Text(
                                  "High",
                                  textAlign: TextAlign.start,
                                  style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w600),
                                ),
                              ]
                          )
                        ],
                      ),
                      SizedBox(height: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "assign_to".trans(context),
                            textAlign: TextAlign.start,
                            style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                          ),
                          SizedBox(height: 5),
                          Row(
                              children: [
                                Container(
                                  width: 38,
                                  height: 38,
                                  decoration: BoxDecoration(
                                      color: CupertinoColors.systemGrey2,
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(color: mainColor),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage("${prefixImages}img_avatar_dummy.png")
                                      )
                                  ),
                                ),
                                SizedBox(width: 12),
                                Text(
                                  "Bima - Sr Graphic Design",
                                  textAlign: TextAlign.start,
                                  style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                                ),
                              ]
                          )
                        ],
                      ),
                      SizedBox(height: 16),
                      FormWithLabelCard(
                          outerLabelText: "task_description".trans(context),
                          hintText: "",
                          controller: descriptionC,
                          readOnly: true,
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
                      SizedBox(height: 16),
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
                                "download_file".trans(context),
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
                    ],
                  )
              ),
              SizedBox(height: 60),
            ],
          )
      ),
    );
  }

  Widget statusCard(String status){
    Color color = "47C28B".toColor();

    if(status == "Done"){
      color = "47C28B".toColor();
    }

    if(status == "To Do"){
      color = "7A5AF8".toColor();
    }

    if(status == "In Progress"){
      color = "F79009".toColor();
    }

    return Container(
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "${status}",
            textAlign: TextAlign.start,
            style: blackFontStyle.copyWith(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w600),
          ),
          SizedBox(width: 12),
          Icon(Icons.keyboard_arrow_down_sharp, size: 14, color: Colors.white )
        ]
      ),
    );
  }

}
