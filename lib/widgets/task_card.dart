part of "widgets.dart";

class TaskSummaryCard extends StatefulWidget {
  final String token;
  final double width;
  final ProjectsCounts count;

  TaskSummaryCard(this.token, this.width, this.count);

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
              "summary_work".trans(context),
              textAlign: TextAlign.start,
              style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 3),
            Text(
              "current_task".trans(context),
              textAlign: TextAlign.start,
              style: greyFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                itemTodo((widget.width - 2*16)/3 - 5, "to_do".trans(context), "ic_task_todo.svg", widget.count.on_hold ?? 0),
                itemTodo((widget.width - 2*16)/3 - 5, "in_progress".trans(context), "ic_task_progress.svg", widget.count.active ?? 0),
                itemTodo((widget.width - 2*16)/3 - 5, "done".trans(context), "ic_task_done.svg", widget.count.completed ?? 0),
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
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset("${prefixIcons}${iconPath}", width: 16, height: 16,),
                SizedBox(width: 4),
                Container(
                  width: width - 2*8 - 4 - 16 - 2,
                  child: Text(
                    "${title}",
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: blackFontStyle.copyWith(fontSize: 11, fontWeight: FontWeight.w600),
                  ),
                )
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
  final String token;
  final double width;
  final Projects projects;

  TaskGroupCard(this.token, this.width, this.projects);

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
                  "${projects.name}",
                  textAlign: TextAlign.start,
                  style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                SizedBox(width: 5),
                Icon(Icons.more_vert, color: mainColor, size: 16,)
              ],
            ),
            SizedBox(height: 3),
            Text(
              "${projects.description}",
              textAlign: TextAlign.start,
              style: greyFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 15),
            (projects.tasks != null) ? Column(
              children: projects.tasks!.map((e) => TaskItemCard(token, width, e)).toList()
            ) : SizedBox(),
            SizedBox(height: 15),
            ButtonHorizontalCard(width, "Create New Task", Icons.add_box_rounded, mainColor, onTap: (){
              Get.to(TaskCreatePage(token, "${projects.id}"));
            })
          ],
        )
    );
  }
}

class TaskItemCard extends StatefulWidget {
  final String token;
  final double width;
  final Tasks task;

  TaskItemCard(this.token, this.width, this.task);

  @override
  State<TaskItemCard> createState() => _TaskItemCardState();
}

class _TaskItemCardState extends State<TaskItemCard> {
  bool isShow = false;
  bool isShowImage = false;
  bool isShowComment = false;

  TextEditingController commentC = TextEditingController();

  File? fileImage;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.to(TaskDetailPage(widget.token, widget.task));
      },
      child: Container(
          width: widget.width,
          margin: EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: greyColor.withOpacity(0.3))
          ),
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: (){
                  // setState((){
                  //   isShow = !isShow;
                  // });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: widget.width - 2*16 - 34,
                      child: Text(
                        "${widget.task.title}",
                        textAlign: TextAlign.start,
                        style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                    ),
                    // SizedBox(width: 5),
                    // Icon(Icons.more_vert, color: mainColor, size: 16,)
                  ],
                ),
              ),
              Column(
                  children: [
                    SizedBox(height: 10),
                    (isShowImage) ? Column(
                        children: [
                          SizedBox(height: 5),
                          CommonDottedButtonWithImage(widget.width - 2*16, isReset: (fileImage != null), onPicked: (value) async {
                            setState(() {
                              fileImage = value;
                            });

                            if(fileImage != null){
                              await TaskServices.addAttachment(widget.token, "${widget.task.id}", fileImage!).then((result) async {

                                if(result != null && result.value != null){

                                  setState(() {
                                    fileImage = null;
                                    isShowImage = false;
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


                                } else {

                                  setState(() {
                                    fileImage = null;
                                    isShowImage = false;
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

                          }, icon: "${prefixIcons}ic_add_picture.svg"),
                          SizedBox(height: 5),
                        ]
                    ) : SizedBox(),
                    (isShowComment) ? Column(
                        children: [
                          SizedBox(height: 5),
                          FormWithLabelCard(
                              outerLabelText: "comment".trans(context),
                              hintText: "Enter ${"comment".trans(context)}",
                              controller: commentC,
                              inputType: TextInputType.text,
                              textInputAction: TextInputAction.send,
                              onSaved: (e) {
                                commentC.text = e ?? "";
                              },
                              onFieldSubmit: (e) async {
                                await TaskServices.addComments(widget.token, "${widget.task.id}", e!).then((result) async {

                                  if(result != null && result.value != null){

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

                                  } else {

                                    setState(() {
                                      fileImage = null;
                                      isShowImage = false;
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
                              },
                              validator: (e) {
                                return simpleValidator(e, null);
                              },
                              filled: true),
                          SizedBox(height: 5),
                        ]
                    ) : SizedBox(),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                            children: [
                              InkWell(
                                  onTap: (){
                                    setState((){
                                      isShowComment = !isShowComment;
                                    });
                                  },
                                  child: Container(
                                    width: 20, height: 20,
                                    child: SvgPicture.asset("${prefixIcons}ic_text.svg", width: 20, height: 20),
                                  )
                              ),
                              SizedBox(width: 6),
                              ((widget.task.comments_count ?? 0) > 0) ? Text(
                                "${widget.task.comments_count}",
                                textAlign: TextAlign.start,
                                style: blackFontStyle.copyWith(fontSize: 11, fontWeight: FontWeight.w600),
                              ) : SizedBox(),
                            ]
                        ),
                        SizedBox(width: 10),
                        Row(
                          children: [
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
                            ((widget.task.attachments_count ?? 0) > 0) ? Text(
                              "${widget.task.attachments_count}",
                              textAlign: TextAlign.start,
                              style: blackFontStyle.copyWith(fontSize: 11, fontWeight: FontWeight.w600),
                            ) : SizedBox(),
                          ]
                        ),

                      ],
                    ),
                    SizedBox(height: 15),
                  ]
              )
            ],
          )
      )
    );
  }
}