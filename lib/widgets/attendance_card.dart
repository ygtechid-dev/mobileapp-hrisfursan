part of 'widgets.dart';

class WorkingCard extends StatefulWidget {
  final String token;
  final double width;
  final String? clockin;
  final String? clockout;

  WorkingCard(this.token, this.width, {this.clockin, this.clockout});

  @override
  State<WorkingCard> createState() => _WorkingCardState();
}

class _WorkingCardState extends State<WorkingCard> {

  String? clockin;
  String? clockout;


  @override
  void initState() {

    if(widget.clockin != null && widget.clockin != ""){
      clockin = widget.clockin!.substring(0, 5);
    }

    if(widget.clockout != null && widget.clockout != ""){
      clockout = widget.clockout!.substring(0, 5);
    }


    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    DateTime now = DateTime.now();
    String formattedDate = intl.DateFormat('MMMM yyyy').format(now);

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
            "total_working".trans(context),
            textAlign: TextAlign.start,
            style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 3),
          Text(
            "${"paid_period".trans(context)} 01 ${formattedDate} - ${now.day} ${formattedDate}",
            textAlign: TextAlign.start,
            style: greyFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TimeCard((widget.width - 2*16)/2 - 5, "clockin".trans(context), "${clockin ?? "--:--"}", color: (clockin != null) ? mainColor : greyColor),
              TimeCard((widget.width - 2*16)/2 - 5, "clockout".trans(context), "${clockout ?? "--:--"}", color: (clockout != null) ? mainColor : greyColor),
            ],
          ),
          SizedBox(height: 12),
          ButtonCard((widget.clockin != null && widget.clockin != "") ? (widget.clockout != null && widget.clockout != "") ? "donefortoday".trans(context) : "clocked_out".trans(context) : "checkin_now".trans(context), widget.width - 2*16, (widget.clockout != null) ? greyColor : mainColor, colorGradient: buttonGradient, onPressed: () async {
            if(widget.clockin != null){
              if(widget.clockout != null){

              } else {
                modalBottomSheet(context, widget.token);
              }
            } else {
              Get.to(ClockInPage(widget.token));
            }

          }),
        ]
      ),
    );
  }
  void modalBottomSheet(contexts, String token){
    double fullWidth = MediaQuery.of(context).size.width;

    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
        ),
        context: contexts,
        enableDrag: true,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (bc){
          return ModalClockOutCard(token, fullWidth, 16);
        });
  }
}

class TimeCard extends StatelessWidget {
  final double width;
  final String title;
  final String time;
  final Color? color;

  TimeCard(this.width, this.title, this.time, {this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: "F9F9F9".toColor(),
        border: Border.all(color: greyColor),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleCard(title, iconData: Icons.access_time_filled, color: color),
          SizedBox(height: 5),
          Text(
            "${time}",
            textAlign: TextAlign.start,
            style: blackFontStyle.copyWith(fontSize: 22, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}

class TitleCard extends StatelessWidget {
  final String title;
  final String? iconPath;
  final IconData? iconData;
  final Color? color;

  TitleCard(this.title, {this.iconPath, this.iconData, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          (iconPath != null) ? SvgPicture.asset("${prefixIcons}${iconPath}", width: 16, height: 16) : SizedBox(),
          (iconData != null) ? Icon(iconData, size: 16, color: color ?? greyColor) : SizedBox(),
          SizedBox(width: 4),
          Text(
            "${title}",
            textAlign: TextAlign.start,
            style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class AttendantCard extends StatelessWidget {
  final String token;
  final AttendantRecords records;
  final double width;
  final String? date;
  final String? total_hours;
  final String? clock_in;
  final String? clock_out;

  AttendantCard(this.token, this.records, this.width, {this.date, this.total_hours, this.clock_in, this.clock_out});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:(){
        Get.to(AttendantDetailPage(token, records));
      },
      child: Container(
          width: width,
          margin: EdgeInsets.only(bottom: 15),
          padding: EdgeInsets.symmetric(vertical: 14, horizontal: defaultMargin3),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8)
          ),
          child: Column(
              children: [
                Row(
                    children: [
                      Icon(Icons.date_range, size: 18, color: mainColor),
                      SizedBox(width: 6),
                      Text(
                        "${date}",
                        textAlign: TextAlign.start,
                        style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                    ]
                ),
                SizedBox(height: 10),
                Container(
                    width: width - 2*defaultMargin3,
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: "F9FAFB".toColor(),
                      border: Border.all(color: "EAECF0".toColor()),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "total_hours".trans(context),
                                  textAlign: TextAlign.start,
                                  style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  "${total_hours ?? "-"} hrs",
                                  textAlign: TextAlign.start,
                                  style: blackFontStyle.copyWith(fontSize: 15, fontWeight: FontWeight.w600),
                                ),
                              ]
                          ),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "clockin_out".trans(context),
                                  textAlign: TextAlign.start,
                                  style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  "${clock_in ?? "-"} -- ${clock_out ?? "-"}",
                                  textAlign: TextAlign.start,
                                  style: blackFontStyle.copyWith(fontSize: 15, fontWeight: FontWeight.w600),
                                ),
                              ]
                          ),
                        ]
                    )
                ),
              ]
          )
      )
    );
  }
}

