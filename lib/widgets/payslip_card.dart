part of "widgets.dart";

class PayslipCard extends StatelessWidget {
  final String token;
  final double width;
  final Payslip payslip;
  final String? date;
  final String? total_hours;
  final double? received;
  final String? paid_on;

  PayslipCard(this.token, this.width, this.payslip, {this.date, this.total_hours, this.received, this.paid_on});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap:(){
          Get.to(PayslipDetailPage(token, payslip));
        },
        child: Container(
            width: width,
            margin: EdgeInsets.only(bottom: 15),
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: defaultMargin3),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${date}",
                    textAlign: TextAlign.start,
                    style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 12),
                  Container(
                      width: width - 2*defaultMargin3,
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
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
                                    "total_hours".trans(context),
                                    textAlign: TextAlign.start,
                                    style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    "${total_hours}",
                                    textAlign: TextAlign.start,
                                    style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                                  ),
                                ]
                            ),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "received".trans(context),
                                    textAlign: TextAlign.start,
                                    style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    "${intl.NumberFormat.currency(
                                      locale: 'id_ID',
                                      decimalDigits: 0,
                                      symbol: 'Rp',
                                    ).format(received)}",
                                    textAlign: TextAlign.start,
                                    style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                                  ),
                                ]
                            ),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "paid_on".trans(context),
                                    textAlign: TextAlign.start,
                                    style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    "${paid_on}",
                                    textAlign: TextAlign.start,
                                    style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
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

class PayslipResumeCard extends StatelessWidget {
  final double width;
  final Payslip payslip;

  PayslipResumeCard(this.width, this.payslip);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "payroll_details".trans(context),
              textAlign: TextAlign.start,
              style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 3),
            Text(
              "payroll_details_notes".trans(context),
              textAlign: TextAlign.start,
              style: greyFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 6),
            Divider(thickness: 1, color: Colors.grey.shade100),
            SizedBox(height: 6),
            itemRow("basic_salary".trans(context), double.parse(payslip.basic_salary ?? "0")),
            itemRow("deduction".trans(context), double.parse(payslip.total_deduction ?? "0"), color: Colors.red),
            // itemRow("tax".trans(context), double.parse(payslip.basic_salary ?? "0"), color: Colors.red),
            // itemRow("reimbursement".trans(context), double.parse(payslip.basic_salary ?? "0"), color: Colors.green),
            itemRow("bonus".trans(context), double.parse(payslip.total_allowance ?? "0"), color: Colors.green),
            itemRow("overtime".trans(context), double.parse(payslip.total_overtime ?? "0"), color: Colors.green),
            SizedBox(height: 6),
            Divider(thickness: 1, color: Colors.grey.shade100),
            SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "total_salary".trans(context),
                  textAlign: TextAlign.start,
                  style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                Text(
                  "${intl.NumberFormat.currency(
                    locale: 'id_ID',
                    decimalDigits: 0,
                    symbol: 'Rp',
                  ).format(double.parse(payslip.net_salary ?? "0"))}",
                  textAlign: TextAlign.start,
                  style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ],
            )
          ]
      ),
    );
  }

  Widget itemRow(String title, double data, {Color? color = Colors.black}){
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "${title}",
            textAlign: TextAlign.start,
            style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
          ),
          Text(
            "${intl.NumberFormat.currency(
              locale: 'id_ID',
              decimalDigits: 0,
              symbol: 'Rp',
            ).format(data)}",
            textAlign: TextAlign.start,
            style: blackFontStyle.copyWith(fontSize: 13, color: color, fontWeight: FontWeight.w600),
          ),
        ],
      )
    );
  }
}

class PayslipSummaryCard extends StatefulWidget {
  final String token;
  final double width;
  final String overtime_hours;
  final String working_hours;

  PayslipSummaryCard(this.token, this.width, this.overtime_hours, this.working_hours);

  @override
  State<PayslipSummaryCard> createState() => _PayslipSummaryCardState();
}

class _PayslipSummaryCardState extends State<PayslipSummaryCard> {
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
              "total_working_hour".trans(context),
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
                TimeCard((widget.width - 2*16)/2 - 5, "overtime".trans(context), "${widget.overtime_hours}"),
                TimeCard((widget.width - 2*16)/2 - 5, "this_pay".trans(context), "${widget.working_hours}"),
              ],
            ),
          ]
      ),
    );
  }

}
