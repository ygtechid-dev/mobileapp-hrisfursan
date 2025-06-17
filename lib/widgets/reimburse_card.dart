part of "widgets.dart";

class ReimburseSummaryCard extends StatefulWidget {
  final String token;
  final double width;
  final double total;
  final double approved;

  ReimburseSummaryCard(this.token, this.width, this.total, this.approved);

  @override
  State<ReimburseSummaryCard> createState() => _ReimburseSummaryCardState();
}

class _ReimburseSummaryCardState extends State<ReimburseSummaryCard> {
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
              "remaining_balance".trans(context),
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
                itemReimburse((widget.width - 2*16)/2 - 5, "total".trans(context), Colors.green, "${intl.NumberFormat.currency(
                  locale: 'id_ID',
                  decimalDigits: 0,
                  symbol: 'Rp',
                ).format(widget.total)}"),
                itemReimburse((widget.width - 2*16)/2 - 5, "approved".trans(context), Colors.blue, "${intl.NumberFormat.currency(
                  locale: 'id_ID',
                  decimalDigits: 0,
                  symbol: 'Rp',
                ).format(widget.approved)}"),
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
                      height: 12,
                      width: 12,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: color
                      )
                  ),
                  SizedBox(width: 6),
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
  final String? token;
  final double width;
  final String? date;
  final String? typeData;
  final String? value;
  final String? status;
  final String? approved_at;
  final String? rejected_at;

  ReimburseItemCard(this.token, this.width, {this.date, this.typeData, this.value, this.status, this.approved_at, this.rejected_at});

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

    if(status == "paid"){
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
            modalBottomSheetRefusal(context, token ?? "");
          }

          if(status == "approved"){
            modalBottomSheetApproved(context, token ?? "");
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
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "type".trans(context),
                                    textAlign: TextAlign.start,
                                    style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    "${typeData}",
                                    textAlign: TextAlign.start,
                                    style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                                  ),
                                ]
                            ),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "total".trans(context),
                                    textAlign: TextAlign.start,
                                    style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    "${intl.NumberFormat.currency(
                                      locale: 'id_ID',
                                      decimalDigits: 0,
                                      symbol: 'Rp',
                                    ).format(double.parse(value ?? "0"))}",
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
          return ModalDefaultInfoCard(token, fullWidth, 16, "refusal_reimbursement".trans(contexts), "refusal_reimbursement_notes".trans(contexts), "img_leave.png");
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
          return ModalDefaultInfoCard(token, fullWidth, 16, "approval_reimbursement".trans(contexts), "approval_reimbursement_notes".trans(contexts), "img_leave.png");
        });
  }
}