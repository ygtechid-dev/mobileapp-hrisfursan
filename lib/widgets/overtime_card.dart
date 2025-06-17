part of "widgets.dart";

class OvertimeSummaryCard extends StatefulWidget {
  final String token;
  final double width;

  OvertimeSummaryCard(this.token, this.width);

  @override
  State<OvertimeSummaryCard> createState() => _OvertimeSummaryCardState();
}

class _OvertimeSummaryCardState extends State<OvertimeSummaryCard> {
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
              "total_overtime".trans(context),
              textAlign: TextAlign.start,
              style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 3),
            Text(
              "${"paid_period".trans(context)} 25 Nov 2024 - 25 Dec 2024",
              textAlign: TextAlign.start,
              style: greyFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TimeCard((widget.width - 2*16)/2 - 5, "today_overtime".trans(context), "00:00"),
                TimeCard((widget.width - 2*16)/2 - 5, "total_period".trans(context), "00:00"),
              ],
            ),
          ]
      ),
    );
  }
}

class OvertimeItemCard extends StatelessWidget {
  final double width;
  final String? date;
  final String? overtime_date;
  final String? priority;
  final String? category;
  final String? status;
  final String? approved_at;
  final String? rejected_at;

  OvertimeItemCard(this.width, {this.date, this.overtime_date, this.priority, this.category, this.status, this.approved_at, this.rejected_at});

  Color? colorStatus;
  IconData? iconStatus;
  String? textStatus;

  @override
  Widget build(BuildContext context) {

    if(status == "pending"){
      colorStatus = Colors.orange;
      iconStatus = Icons.access_time;
      textStatus = "waiting_approval".trans(context);
    }

    if(status == "approved"){
      colorStatus = Colors.green;
      iconStatus = Icons.check_circle;
      textStatus = "${"approved_at".trans(context)} ${approved_at}";
    }

    if(status == "rejected"){
      colorStatus = Colors.red;
      iconStatus = Icons.cancel;
      textStatus = "${"rejected_at".trans(context)} ${rejected_at}";
    }

    return InkWell(
        onTap:(){
          if(status == "rejected"){
            modalBottomSheetRefusal(context, "");
          }

          if(status == "approved"){
            modalBottomSheetApproved(context, "");
          }
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
                        Icon(Icons.receipt_long, size: 14, color: mainColor),
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
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        color: "F9FAFB".toColor(),
                        border: Border.all(color: "EAECF0".toColor()),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "overtime_date".trans(context),
                                    textAlign: TextAlign.start,
                                    style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    "${overtime_date}",
                                    textAlign: TextAlign.start,
                                    style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                                  ),
                                ]
                            ),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "priority".trans(context),
                                    textAlign: TextAlign.start,
                                    style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    "${priority}",
                                    textAlign: TextAlign.start,
                                    style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                                  ),
                                ]
                            ),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "category".trans(context),
                                    textAlign: TextAlign.start,
                                    style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    "${category}",
                                    textAlign: TextAlign.start,
                                    style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                                  ),
                                ]
                            ),
                          ]
                      )
                  ),
                  SizedBox(height: 5),
                  Row(
                      children: [
                        Icon(iconStatus, size: 12, color: colorStatus),
                        SizedBox(width: 6),
                        Text(
                          "${textStatus}",
                          textAlign: TextAlign.start,
                          style: blackFontStyle.copyWith(fontSize: 12, color: colorStatus, fontWeight: FontWeight.w400),
                        ),
                      ]
                  ),
                ]
            )
        )
    );
  }

  void modalBottomSheetRefusal(contexts, String token){
    double fullWidth = MediaQuery.of(contexts).size.width;

    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
        ),
        context: contexts,
        enableDrag: true,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (bc){
          return ModalDefaultInfoCard(token, fullWidth, 16, "refusal_overtime".trans(contexts), "refusal_overtime_notes".trans(contexts), "img_leave.png");
        });
  }

  void modalBottomSheetApproved(contexts, String token){
    double fullWidth = MediaQuery.of(contexts).size.width;

    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
        ),
        context: contexts,
        enableDrag: true,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (bc){
          return ModalDefaultInfoCard(token, fullWidth, 16, "approval_overtime".trans(contexts), "approval_overtime_notes".trans(contexts), "img_leave.png");
        });
  }
}