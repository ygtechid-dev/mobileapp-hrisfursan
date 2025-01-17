part of "widgets.dart";

class LeaveSummaryCard extends StatefulWidget {
  final String token;
  final double width;

  LeaveSummaryCard(this.token, this.width);

  @override
  State<LeaveSummaryCard> createState() => _LeaveSummaryCardState();
}

class _LeaveSummaryCardState extends State<LeaveSummaryCard> {
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
              "Total Leave",
              textAlign: TextAlign.start,
              style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 3),
            Text(
              "Period 1 Jan 2024 - 30 Dec 2024",
              textAlign: TextAlign.start,
              style: greyFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                itemLeave((widget.width - 2*16)/2 - 5, "Available", Colors.green, 3),
                itemLeave((widget.width - 2*16)/2 - 5, "Leave Used", Colors.blue, 1),
              ],
            ),
          ]
      ),
    );
  }

  Widget itemLeave(double width, String title, Color color, int amount){
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
                  Container(
                    height: 12,
                    width: 12,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: color
                    )
                  ),
                  SizedBox(width: 4),
                  Text(
                    "${title}",
                    textAlign: TextAlign.start,
                    style: blackFontStyle.copyWith(fontSize: 11, fontWeight: FontWeight.w600),
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

class LeaveItemCard extends StatelessWidget {
  final double width;
  final String? date;
  final String? leave_date;
  final String? value;
  final String? status;
  final String? type;

  LeaveItemCard(this.width, {this.date, this.leave_date, this.value, this.status, this.type});

  Color? colorStatus;
  IconData? iconStatus;

  @override
  Widget build(BuildContext context) {

    if(type == "request"){
      colorStatus = Colors.orange;
      iconStatus = Icons.access_time;
    }

    if(type == "approved"){
      colorStatus = Colors.green;
      iconStatus = Icons.check_circle;
    }

    if(type == "rejected"){
      colorStatus = Colors.red;
      iconStatus = Icons.cancel;
    }

    return InkWell(
        onTap:(){
          if(type == "rejected"){
            modalBottomSheetRefusal(context, "");
          }

          if(type == "approved"){
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
                        Icon(Icons.receipt_long, size: 18, color: mainColor),
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
                                    "Leave Date",
                                    textAlign: TextAlign.start,
                                    style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    "${leave_date}",
                                    textAlign: TextAlign.start,
                                    style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                                  ),
                                ]
                            ),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Total Value",
                                    textAlign: TextAlign.start,
                                    style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    "${value}",
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
                        Icon(iconStatus, size: 16, color: colorStatus),
                        SizedBox(width: 6),
                        Text(
                          "${status}",
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
          return ModalDefaultInfoCard(token, fullWidth, 16, "Refusal of Leave Absence", "Leave application denied because your leave quota is already in use.", "img_leave.png");
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
          return ModalDefaultInfoCard(token, fullWidth, 16, "Approve of Leave Absence", "Congrats your Leave application is approved! “Selamat Healing yaaa - HRD Staff”", "img_leave.png");
        });
  }
}