part of 'widgets.dart';

class SalaryCard extends StatefulWidget {
  final double width;
  final int amount;

  SalaryCard(this.width, this.amount);

  @override
  State<SalaryCard> createState() => _SalaryCardState();
}

class _SalaryCardState extends State<SalaryCard> {
  bool isShow = false;
  String dataAmount = "";

  int day = 27;
  int total_day = 30;

  double total_percent = 0;
  double pencapaian_percent = 0;
  double total_pencapaian_percent = 0;

  @override
  Widget build(BuildContext context) {

    pencapaian_percent = day.toDouble(); //0
    total_pencapaian_percent =
        total_day.toDouble(); //7

    double item_satuan = 1.00 / total_pencapaian_percent;

    total_percent = pencapaian_percent * item_satuan;
    int percent = (total_percent * 100).toInt();

    if(isShow == false){
      List<String> totalStars = [];
      int temp = "${widget.amount}".length;
      for(int i=1; i<=temp; i++){

        totalStars.add("*");
      }
      dataAmount = "Rp ${totalStars.join("")}";
    } else {
      dataAmount = intl.NumberFormat.currency(
        locale: 'id_ID',
        decimalDigits: 0,
        symbol: 'Rp',
      ).format(widget.amount);
    }

    DateTime now = DateTime.now();
    String formattedDate = intl.DateFormat('MMMM').format(now);

    String formattedDate2 = intl.DateFormat('d').format(now);

    int dayUntil = now.day - int.parse(formattedDate2);


    return Container(
      width: widget.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "your_salary".trans(context),
                  textAlign: TextAlign.start,
                  style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                InkWell(
                  onTap: (){
                    setState(() {
                      isShow = !isShow;
                    });
                  },
                  child: Container(
                    height: 20,
                    width: 20,
                    child: SvgPicture.asset((isShow == true) ?  "${prefixIcons}ic_eye_active.svg" : "${prefixIcons}ic_eye_unactive.svg"),
                  )
                )
              ],
            ),
            SizedBox(height: 10),
            Container(
              width: widget.width - 2*16,
              child: Text(
                "${dataAmount}",
                textAlign: TextAlign.center,
                style: blackFontStyle.copyWith(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "01 ${formattedDate}",
                  textAlign: TextAlign.start,
                  style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w600),
                ),
                Text(
                  "${dayUntil} ${"days_until".trans(context)}",
                  textAlign: TextAlign.start,
                  style: greyFontStyle.copyWith(fontSize: 11, fontWeight: FontWeight.w400),
                ),
                Text(
                  "${now.day} ${formattedDate}",
                  textAlign: TextAlign.start,
                  style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            SizedBox(height: 5),
            LinearPercentIndicator(
              width: widget.width - 2*16,
              lineHeight: 5,
              percent: (total_percent >= 1.0) ? 1.0 : total_percent,
              barRadius: Radius.circular(20),
              progressColor: mainColor,
              backgroundColor: greyColor,
            ),
            SizedBox(height: 20),
            ButtonHorizontalCard(widget.width - 2*16, "take_emergency".trans(context), Icons.arrow_forward, mainColor)
          ]
      ),
    );
  }
}

class PerformanceStatsCard extends StatelessWidget {
  final double width;
  final String status;
  final String iconPath;

  PerformanceStatsCard(this.width, this.status, this.iconPath);

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
          Row(
            children: [
              Text(
                "performance_stats".trans(context),
                textAlign: TextAlign.start,
                style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              SizedBox(width: 5),
              ButtonCard("${status}", null, Colors.green, fontSize: 11, padding: 4, paddingHorizontal: 8, isReadable: false)
            ],
          ),
          SizedBox(height: 3),
          Text(
            "maintain_your_time".trans(context),
            textAlign: TextAlign.start,
            style: greyFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
          ),
          SizedBox(height: 12),
          Container(
              width: width - 2*16,
              decoration: BoxDecoration(
                color: "F9FAFB".toColor(),
                border: Border.all(color: greyColor),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset("${prefixIcons}${iconPath}", width: 32, height: 32,),
                LinearPercentIndicator(
                  width: (width - 2*16) - 32 - 20,
                  lineHeight: 5,
                  percent: 0.7,
                  barRadius: Radius.circular(20),
                  progressColor: Colors.green,
                  backgroundColor: greyColor,
                ),
              ],
            )
          )
        ],
      )
    );
  }
}

class GraphCard extends StatelessWidget {
  final double width;
  final List<WorkingPeriod> listData;

  GraphCard(this.width, this.listData);

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "working_period".trans(context),
                  textAlign: TextAlign.start,
                  style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                SizedBox(width: 5),
                Icon(Icons.more_horiz_outlined, color: mainColor, size: 16,)
              ],
            ),
            SizedBox(height: 3),
            Text(
              "average_your".trans(context),
              textAlign: TextAlign.start,
              style: greyFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 12),
            GraphItemCard(listData)
          ],
        )
    );
  }
}



