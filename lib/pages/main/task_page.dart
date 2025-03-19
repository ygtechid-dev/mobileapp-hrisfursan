part of '../pages.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  Widget build(BuildContext context) {
    double defaultWidth = MediaQuery.of(context).size.width - 2*defaultMargin2;
    double fullWidth = MediaQuery.of(context).size.width;

    return GeneralPage(
      title: "",
      heightAppBar: 210,
      appBarColor: mainColor,
      appBarColorGradient: backgroundGradient,
      backColor: "F1F3F8".toColor(),
      isAppBarCircular: true,
      child: Column(
        children: [
          Container(
            width: defaultWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "todo".trans(context),
                      textAlign: TextAlign.start,
                      style: blackFontStyle.copyWith(fontSize: 24, color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "lets_tackle".trans(context),
                      textAlign: TextAlign.start,
                      style: blackFontStyle.copyWith(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("${prefixImages}img_header_activity.png")
                      )
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 15),
          TaskSummaryCard('', defaultWidth),
          SizedBox(height: 15),
          Container(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    SizedBox(width: 20),
                    TaskGroupCard(defaultWidth*75/100, "To Do", "The tasks assigned to you for today"),
                    TaskGroupCard(defaultWidth*75/100, "In Progress", "The tasks assigned to you for today"),
                    TaskGroupCard(defaultWidth*75/100, "Done", "The tasks assigned to you for today"),
                  ]
              )
            ),
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }
}
