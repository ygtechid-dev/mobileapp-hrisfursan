part of "widgets.dart";

class PayslipCard extends StatelessWidget {
  final double width;
  final String? date;
  final String? total_hours;
  final String? received;
  final String? paid_on;

  PayslipCard(this.width, {this.date, this.total_hours, this.received, this.paid_on});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap:(){
          Get.to(PayslipDetailPage());
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
                  Text(
                    "${date}",
                    textAlign: TextAlign.start,
                    style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
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
                                    "Total Hours",
                                    textAlign: TextAlign.start,
                                    style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    "${total_hours}",
                                    textAlign: TextAlign.start,
                                    style: blackFontStyle.copyWith(fontSize: 15, fontWeight: FontWeight.w600),
                                  ),
                                ]
                            ),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Received",
                                    textAlign: TextAlign.start,
                                    style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    "${received}",
                                    textAlign: TextAlign.start,
                                    style: blackFontStyle.copyWith(fontSize: 15, fontWeight: FontWeight.w600),
                                  ),
                                ]
                            ),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Paid On",
                                    textAlign: TextAlign.start,
                                    style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    "${paid_on}",
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

class PayslipResumeCard extends StatelessWidget {
  final double width;

  PayslipResumeCard(this.width);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Payroll Details",
              textAlign: TextAlign.start,
              style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 3),
            Text(
              "Details about payroll",
              textAlign: TextAlign.start,
              style: greyFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 6),
            Divider(thickness: 1, color: Colors.grey.shade100),
            SizedBox(height: 6),
            itemRow("Basic Salary", "Rp 7.000.000"),
            itemRow("Tax", "Rp 300.000", color: Colors.red),
            itemRow("Reimbursement", "Rp 1.000.000", color: Colors.green),
            itemRow("Bonus", "Rp 500.000", color: Colors.green),
            itemRow("Overtime", "Rp 0"),
            SizedBox(height: 6),
            Divider(thickness: 1, color: Colors.grey.shade100),
            SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Salary",
                  textAlign: TextAlign.start,
                  style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                Text(
                  "Rp 8.200.000",
                  textAlign: TextAlign.start,
                  style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ],
            )
          ]
      ),
    );
  }

  Widget itemRow(String title, String data, {Color? color = Colors.black}){
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
            "${data}",
            textAlign: TextAlign.start,
            style: blackFontStyle.copyWith(fontSize: 13, color: color, fontWeight: FontWeight.w600),
          ),
        ],
      )
    );
  }
}
