part of "widgets.dart";

class CalendarCard extends StatefulWidget {

  @override
  State<CalendarCard> createState() => _CalendarCardState();
}

class _CalendarCardState extends State<CalendarCard> {

  List<String> listDay = [
    "SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT",
  ];

  List<String> listDate = [
    "30", "1", "2", "3", "4", "5", "6",
    "7", "8", "9", "10", "11", "12", "13",
    "14", "15", "16", "17", "18", "19", "20",
    "21", "22", "23", "24", "25", "26", "27",
    "28", "29", "30", "31", "2", "3", "4",
  ];

  @override
  Widget build(BuildContext context) {
    double defaultWidth = MediaQuery.of(context).size.width - 2*defaultMargin2;
    double itemWidth = MediaQuery.of(context).size.width - 2*defaultMargin3;
    double fullWidth = MediaQuery.of(context).size.width;

    return Container(
      width: defaultWidth,
      padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: mainColor)
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.arrow_back_ios_new, size: 18, color: mainColor),
                    SizedBox(width: 10),
                    Text(
                      "Nov",
                      textAlign: TextAlign.start,
                      style: blackFontStyle.copyWith(fontSize: 12, color: mainColor, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              Text(
                "Dec 2024",
                textAlign: TextAlign.start,
                style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w400),
              ),
              InkWell(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Icons.arrow_back_ios_new, size: 18),
                    SizedBox(width: 10),
                    Text(
                      "Jan",
                      textAlign: TextAlign.end,
                      style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: listDay.map((e) => Container(
              width: (defaultWidth - 2*20)/7-10,
              child: Text(
                "${e}",
                textAlign: TextAlign.center,
                style: blackFontStyle.copyWith(fontSize: 11, fontWeight: FontWeight.w400),
              )
            )).toList()
          ),
          SizedBox(height: 10),
          Divider(thickness: 1),
          SizedBox(height: 10),
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            spacing: 20, runSpacing: 20,
            runAlignment: WrapAlignment.start,
            children: listDate.map((e) => Container(
              width: (defaultWidth - 2*20)/7-10,
              padding: EdgeInsets.all(2),
              decoration: (e == "1") ? BoxDecoration(
                shape: BoxShape.circle,
                color: mainColor
              ) : null,
              child: Text(
                "${e}",
                textAlign: TextAlign.center,
                style: blackFontStyle.copyWith(fontSize: 10, color: (e == "23" || e == "24" || e == "25" || e == "31") ? Colors.red : greyColor, fontWeight: FontWeight.w400),
              ),
            )).toList()
          )
        ]
      ),
    );
  }
}

class EventCard extends StatefulWidget {
  final double width;
  final String status;
  final Color color;
  final List<EventData> listData;

  EventCard(this.width, this.status, this.color, this.listData);

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  bool isShow = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: widget.width,
          margin: EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            color: widget.color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                decoration: BoxDecoration(
                    color: widget.color.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(40)
                ),
                child: Text(
                  "${widget.status}",
                  textAlign: TextAlign.start,
                  style: blackFontStyle.copyWith(fontSize: 11, color: widget.color, fontWeight: FontWeight.w600),
                ),
              ),
              Text(
                "${widget.listData.length} Schedule",
                textAlign: TextAlign.start,
                style: blackFontStyle.copyWith(fontSize: 12, color: widget.color.withOpacity(0.4), fontWeight: FontWeight.w400),
              ),
              InkWell(
                  onTap: (){
                    setState((){
                      isShow = !isShow;
                    });
                  },
                  child: Icon((isShow) ? Icons.keyboard_arrow_up_outlined : Icons.keyboard_arrow_down_outlined, color: widget.color.withOpacity(0.4), size: 16)
              )
            ],
          ),
        ),
        (isShow) ? Column(
          children: widget.listData.map((e) => Container(
              width: widget.width,
              margin: EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: widget.color.withOpacity(0.4)),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                      decoration: BoxDecoration(
                          color: widget.color.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(40)
                      ),
                      child: Text(
                        "${e.state}",
                        textAlign: TextAlign.start,
                        style: blackFontStyle.copyWith(fontSize: 11, color: widget.color.withOpacity(0.5), fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(height: 15),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "${e.title}",
                              textAlign: TextAlign.start,
                              style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 3),
                            Text(
                              "${e.desc}",
                              textAlign: TextAlign.start,
                              style: greyFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        Icon(Icons.check_circle, size: 24, color: Colors.green,)
                      ]
                    ),
                    SizedBox(height: 10),
                    Divider(thickness: 1),
                    SizedBox(height: 10),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${e.date}",
                            textAlign: TextAlign.start,
                            style: greyFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                          ),
                          Text(
                            "${e.credit}",
                            textAlign: TextAlign.end,
                            style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                        ]
                    ),
                  ]
              )
          )).toList()
        ) : SizedBox()
      ]
    );
  }
}
