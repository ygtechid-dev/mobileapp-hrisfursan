part of '../pages.dart';

class PayslipHistoryPage extends StatefulWidget {
  final String token;

  PayslipHistoryPage(this.token);

  @override
  State<PayslipHistoryPage> createState() => _PayslipHistoryPageState();
}

class _PayslipHistoryPageState extends State<PayslipHistoryPage> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    context.read<PayslipCubit>().getPayslip(widget.token);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double defaultWidth = MediaQuery.of(context).size.width - 2*defaultMargin2;
    double itemWidth = MediaQuery.of(context).size.width - 2*defaultMargin3;
    double fullWidth = MediaQuery.of(context).size.width;

    return GeneralPage(
      statusBarColor: mainColor,
      isBackInvert: false,
      isFrontAppBar: true,
      marginAppBar: 65,
      title: "payslip".trans(context),
      onBackButtonPressed: (){
        Get.back();
      },
      backColor: "F1F3F8".toColor(),
      appBarColor: Colors.white,
      child: Column(
        children: [
          Container(
              width: fullWidth,
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: defaultMargin2),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              alignment: Alignment.center,
              child: searchWidget(defaultWidth)
          ),
          SizedBox(height: 20),
          BlocBuilder<PayslipCubit, PayslipState>(
              builder: (context, state) {
                if (state is PayslipLoaded) {
                  if (state.data != null && state.data!.isNotEmpty) {
                    return Column(
                        children: state.data!.map((e) {

                          DateTime appliedDate = new DateFormat("yyyy-MM-dd").parse(e.payment_date ?? "");
                          String applied_date = DateFormat("dd MMMM yyyy").format(appliedDate);

                          DateTime createdDate = new DateFormat("yyyy-MM-dd hh:mm:ss").parse(e.created_at ?? "");
                          String created_date = DateFormat("dd MMMM yyyy").format(createdDate);

                          return PayslipCard(widget.token, defaultWidth, e, date: created_date, total_hours: "40:00:00", received: (e.net_salary ?? "0")!.toDouble(), paid_on: applied_date);
                        }).toList()
                    );
                  } else {
                    return SizedBox();
                  }
                } else {
                  return loadingIndicator;
                }
              }
          ),
        ],
      ),
    );
  }

  searchWidget(double width) {
    return Container(
      width: width,
      height: 50,
      decoration: BoxDecoration(
        color: greyColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: TextField(
                textInputAction: TextInputAction.search,
                controller: searchController,
                onTap: (){

                },
                onChanged: (value) async {

                },
                onSubmitted: (value) async {
                  if(searchController.text.isNotEmpty){

                  }
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(0)),
                    hintText: "search".trans(context),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 6.0),
                      child: Icon(Icons.search, color: greyColor, size: 20),
                    ),
                    prefixStyle: greyFontStyle.copyWith(color: greyColor, fontSize: 12),
                    contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 12),
                    hintStyle: greyFontStyle.copyWith(color: greyColor, fontSize: 12)),
              ),
            ),
            Container(
                margin: EdgeInsets.only(right: 15),
                child: Icon(Icons.tune, size: 24, color: mainColor)
            ),
          ]
      ),
    );
  }
}
