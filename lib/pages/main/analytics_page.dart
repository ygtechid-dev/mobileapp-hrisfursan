part of '../pages.dart';

class AnalyticsPage extends StatefulWidget {
  final String token;

  AnalyticsPage(this.token);

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {

  @override
  void initState() {
    context.read<WorkingPeriodCubit>().getWorkingPeriod(widget.token);
    context.read<SalaryCubit>().getSalary(widget.token);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double defaultWidth = MediaQuery.of(context).size.width - 2*defaultMargin2;
    double fullWidth = MediaQuery.of(context).size.width;

    return GeneralPage(
      title: "",
      appBarColor: mainColor,
      appBarColorGradient: backgroundGradient,
      heightAppBar: 210,
      backColor: "F1F3F8".toColor(),
      isAppBarCircular: true,
      child: Column(
        children: [
          Container(
            width: defaultWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "analytics".trans(context),
                      textAlign: TextAlign.start,
                      style: blackFontStyle.copyWith(fontSize: 24, color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "desc_analytics".trans(context),
                      textAlign: TextAlign.start,
                      style: blackFontStyle.copyWith(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("${prefixImages}img_header_analytics.png")
                      )
                  ),
                )
              ],
            ),
          ),
          BlocBuilder<SalaryCubit, SalaryState>(
              builder: (context, state) => (state is SalaryLoaded) ? (state.data != null) ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 10),
                    SalaryCard(defaultWidth, state.data!.salary ?? 0),
                    SizedBox(height: 20),
                    PerformanceStatsCard(defaultWidth, "${state.data!.performance_status}", "ic_emoji_good.svg"),
                  ]
              ) : SizedBox() : loadingIndicator
          ),
          BlocBuilder<WorkingPeriodCubit, WorkingPeriodState>(
              builder: (context, state) => (state is WorkingPeriodLoaded) ? (state.data != null) ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    GraphCard(defaultWidth, state.data!.monthly_data ?? []),
                    SizedBox(height: 50),
                  ]
              ) : SizedBox() : loadingIndicator
          ),

        ],
      ),
    );
  }
}
