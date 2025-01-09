part of "widgets.dart";

class ReimburseSummaryCard extends StatefulWidget {
  final String token;
  final double width;

  ReimburseSummaryCard(this.token, this.width);

  @override
  State<ReimburseSummaryCard> createState() => _ReimburseSummaryCardState();
}

class _ReimburseSummaryCardState extends State<ReimburseSummaryCard> {
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
              "Remaining Balance",
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
                itemReimburse((widget.width - 2*16)/2 - 5, "Total", Colors.green, "Rp8.888.000"),
                itemReimburse((widget.width - 2*16)/2 - 5, "Approved", Colors.blue, "Rp0"),
              ],
            ),
          ]
      ),
    );
  }

  Widget itemReimburse(double width, String title, Color color, String amount){
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
                      height: 16,
                      width: 16,
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

class ReimburseItemCard extends StatelessWidget {
  final double width;
  final String? date;
  final String? typeData;
  final String? value;
  final String? status;
  final String? type;

  ReimburseItemCard(this.width, {this.date, this.typeData, this.value, this.status, this.type});

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
            padding: EdgeInsets.symmetric(vertical: 24, horizontal: defaultMargin3),
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
                      padding: EdgeInsets.symmetric(vertical: 10.5, horizontal: 12),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        color: "F9FAFB".toColor(),
                        border: Border.all(color: "EAECF0".toColor()),
                        borderRadius: BorderRadius.vertical(top: Radius.circular(5)),
                      ),
                      child: Row(
                          children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Type",
                                    textAlign: TextAlign.start,
                                    style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    "${typeData}",
                                    textAlign: TextAlign.start,
                                    style: blackFontStyle.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
                                  ),
                                ]
                            ),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Total",
                                    textAlign: TextAlign.start,
                                    style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    "${value}",
                                    textAlign: TextAlign.start,
                                    style: blackFontStyle.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
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
          return ModalDefaultInfoCard(token, fullWidth, 16, "Refusal of Reimbursement", "The application was rejected because your fee had expired.", "img_leave.png");
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
          return ModalDefaultInfoCard(token, fullWidth, 16, "Approve of Reimbursement", "Congrats your Reimburse application is approved!", "img_leave.png");
        });
  }
}