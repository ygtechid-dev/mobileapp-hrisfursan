part of "widgets.dart";

class GraphItemCard extends StatefulWidget {
  final List<WorkingPeriod> listData;

  GraphItemCard(this.listData);

  @override
  State<GraphItemCard> createState() => _GraphItemCardState();
}

class _GraphItemCardState extends State<GraphItemCard> {
  List<Color> gradientColors = [
    mainColor,
    Colors.white,
  ];

  bool showAvg = false;

  List<List<double>> listTemp = [];

  @override
  Widget build(BuildContext context) {

    widget.listData.forEach((item) {
      double monthData = double.parse(item.month ?? "1");
      List<double> temp = [
        (monthData-1),
        ((item.total_working_hours!.toDouble() == 0) ? 0 : item.total_working_hours!.toDouble()/10)
      ];

      listTemp.add(temp);
    });

    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.65,
          child: Padding(
            padding: const EdgeInsets.only(
              right: 12,
              left: 8,
              top: 24,
              bottom: 12,
            ),
            child: LineChart(
              showAvg ? avgData() : mainData(listTemp),
            ),
          ),
        ),
        // SizedBox(
        //   width: 60,
        //   height: 34,
        //   child: TextButton(
        //     onPressed: () {
        //       setState(() {
        //         showAvg = !showAvg;
        //       });
        //     },
        //     child: Text(
        //       'avg',
        //       style: TextStyle(
        //         fontSize: 12,
        //         color: showAvg
        //             ? Colors.white.withOpacity(0.5)
        //             : Colors.white,
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    var style = TextStyle(
      color: greyColor,
      fontWeight: FontWeight.normal,
      fontSize: 12,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text =  Text('Jan', style: style);
        break;
      // case 2:
      //   text =  Text('Feb', style: style);
      //   break;
      case 2:
        text =  Text('Mar', style: style);
        break;
      // case 4:
      //   text =  Text('Apr', style: style);
      //   break;
      case 4:
        text =  Text('May', style: style);
        break;
      // case 6:
      //   text =  Text('Jun', style: style);
      //   break;
      case 6:
        text =  Text('Jul', style: style);
        break;
      // case 8:
      //   text =  Text('Aug', style: style);
      //   break;
      case 8:
        text =  Text('Sep', style: style);
        break;
      // case 10:
      //   text =  Text('Oct', style: style);
      //   break;
      case 10:
        text =  Text('Nov', style: style);
        break;
      // case 12:
      //   text =  Text('Dec', style: style);
      //   break;
      default:
        text =  Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    var style = TextStyle(
      color: greyColor,
      fontWeight: FontWeight.normal,
      fontSize: 12,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '10h';
        break;
      case 2:
        text = '20h';
        break;
      case 3:
        text = '30h';
        break;
      case 4:
        text = '40h';
        break;
      case 5:
        text = '50h';
        break;
      case 6:
        text = '60h';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData(List<List<double>> listValue) {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: greyColor.withOpacity(0.7),
            strokeWidth: 1,
              dashArray: [5, 10]
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          axisNameSize: 25,
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 30,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: listValue.map((e) => (e[1] == 0) ? FlSpot(0, 0) : FlSpot(e[0], e[1])).toList(),
          isCurved: false,
          // gradient: LinearGradient(
          //   colors: mainColor,
          // ),
          color: mainColor.withOpacity(0.5),
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: true,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData avgData() {
    return LineChartData(
      lineTouchData: const LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        verticalInterval: 1,
        horizontalInterval: 1,
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: bottomTitleWidgets,
            interval: 1,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
            interval: 1,
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3.44),
            FlSpot(2.6, 3.44),
            FlSpot(4.9, 3.44),
            FlSpot(6.8, 3.44),
            FlSpot(8, 3.44),
            FlSpot(9.5, 3.44),
            FlSpot(11, 3.44),
          ],
          isCurved: false,
          gradient: LinearGradient(
            colors: [
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
            ],
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
              ],
            ),
          ),
        ),
      ],
    );
  }
}