part of "widgets.dart";

class TaskSummaryCard extends StatefulWidget {
  final String token;
  final double width;

  TaskSummaryCard(this.token, this.width);

  @override
  State<TaskSummaryCard> createState() => _TaskSummaryCardState();
}

class _TaskSummaryCardState extends State<TaskSummaryCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Summary of Your Work",
              textAlign: TextAlign.start,
              style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 3),
            Text(
              "Your current task progress",
              textAlign: TextAlign.start,
              style: greyFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                itemTodo((widget.width - 2*16)/3 - 5, "To Do", "${prefixIcons}ic_task_todo.svg", 3),
                itemTodo((widget.width - 2*16)/3 - 5, "In Progress", "${prefixIcons}ic_task_progress.svg", 1),
                itemTodo((widget.width - 2*16)/3 - 5, "Done", "${prefixIcons}ic_task_done.svg", 2),
              ],
            ),
          ]
      ),
    );
  }

  Widget itemTodo(double width, String title, String iconPath, int amount){
    return Container(
        width: width,
        decoration: BoxDecoration(
          color: "F9FAFB".toColor(),
          border: Border.all(color: greyColor),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset("${prefixIcons}${iconPath}", width: 16, height: 16,),
                Text(
                  "${title}",
                  textAlign: TextAlign.start,
                  style: blackFontStyle.copyWith(fontSize: 11, fontWeight: FontWeight.w400),
                ),
              ],
            ),
            SizedBox(height: 4),
            Text(
              "${amount}",
              textAlign: TextAlign.start,
              style: blackFontStyle.copyWith(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ]
        )
    );
  }
}

class TaskGroupCard extends StatelessWidget {
  final double width;
  final String title;
  final String subtitle;

  TaskGroupCard(this.width, this.title, this.subtitle);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(right: 20),
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${title}",
                  textAlign: TextAlign.start,
                  style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                SizedBox(width: 5),
                Icon(Icons.more_vert, color: mainColor, size: 16,)
              ],
            ),
            SizedBox(height: 3),
            Text(
              "${subtitle}",
              textAlign: TextAlign.start,
              style: greyFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 15),
            Column(
              children: []
            ),
            SizedBox(height: 15),
            ButtonHorizontalCard(width, "Create New Task", Icons.add_box_rounded, mainColor)
          ],
        )
    );
  }
}

class TaskItemCard extends StatefulWidget {
  final double width;
  final String title;

  TaskItemCard(this.width, this.title);

  @override
  State<TaskItemCard> createState() => _TaskItemCardState();
}

class _TaskItemCardState extends State<TaskItemCard> {
  bool isShow = false;
  bool isShowImage = false;



  @override
  Widget build(BuildContext context) {
    return Container(
        width: widget.width,
        margin: EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: greyColor)
        ),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: (){
                setState((){
                  isShow = !isShow;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${widget.title}",
                    textAlign: TextAlign.start,
                    style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(width: 5),
                  // Icon(Icons.more_vert, color: mainColor, size: 16,)
                ],
              ),
            ),
            (isShow) ? Column(
              children: [
                (isShowImage) ? Column(
                    children: [
                      SizedBox(height: 5),
                      CommonDottedButtonWithImage(onPicked: (value){
                        setState(() {

                        });
                      }, icon: "${prefixIcons}ic_add_picture.svg")
                    ]
                ) : SizedBox(),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: (){},
                      child: Container(
                        width: 20, height: 20,
                        child: SvgPicture.asset("${prefixIcons}ic_text.svg", width: 20, height: 20),
                      )
                    ),
                    SizedBox(width: 10),
                    InkWell(
                        onTap: (){
                          setState((){
                            isShowImage = !isShowImage;
                          });
                        },
                        child: Container(
                          width: 20, height: 20,
                          child: SvgPicture.asset("${prefixIcons}ic_paperclip.svg", width: 20, height: 20),
                        )
                    ),
                    SizedBox(width: 6),
                    Text(
                      "1",
                      textAlign: TextAlign.start,
                      style: blackFontStyle.copyWith(fontSize: 11, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Column(
                    children: [

                    ]
                ),
                SizedBox(height: 15),
                ButtonHorizontalCard(widget.width, "Create New Task", Icons.add_box_rounded, mainColor)
              ]
            ) : SizedBox()
          ],
        )
    );
  }
}