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
  void initState() {
    context.read<LeavesRemainingCubit>().getLeavesRemaining(widget.token);
    super.initState();
  }

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
              "total_leave".trans(context),
              textAlign: TextAlign.start,
              style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 3),
            Text(
              "${"period".trans(context)} 1 Jan 2025 - 31 Dec 2025",
              textAlign: TextAlign.start,
              style: greyFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 12),
            BlocBuilder<LeavesRemainingCubit, LeavesRemainingState>(
                builder: (context, state) {
                  if (state is LeavesRemainingLoaded) {
                    if (state.data != null && state.data!.isNotEmpty) {
                      List<int> listAvailable = [];
                      List<int> listUsed = [];

                      state.data!.forEach((e) {
                        int tempAvailable = e.remaining ?? 0;
                        int tempUsed = e.used ?? 0;

                        listAvailable.add(tempAvailable);
                        listUsed.add(tempUsed);
                      });

                      int total_available = listAvailable.fold(0, (p, c) => p + ((c ?? 0).toInt()));
                      int total_used = listUsed.fold(0, (p, c) => p + ((c ?? 0).toInt()));

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          itemLeave((widget.width - 2*16)/2 - 5, "Available", Colors.green, total_available),
                          itemLeave((widget.width - 2*16)/2 - 5, "Leave Used", Colors.blue, total_used),
                        ],
                      );
                    } else {
                      return SizedBox();
                    }
                  }  else {
                    return loadingIndicator;
                  }
                }
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
  final String? approved_at;
  final String? rejected_at;

  LeaveItemCard(this.width, {this.date, this.leave_date, this.value, this.status, this.approved_at, this.rejected_at});

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
      textStatus = "${"approved_at".trans(context)}${approved_at}";
    }

    if(status == "rejected"){
      colorStatus = Colors.red;
      iconStatus = Icons.cancel;
      textStatus = "${"rejected_at".trans(context)}${rejected_at}";
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
                                    "leave_date".trans(context),
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
                                    "total_value".trans(context),
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
          return ModalDefaultInfoCard(token, fullWidth, 16, "refusal_leave".trans(contexts), "refusal_leave_desc".trans(contexts), "img_leave.png");
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
          return ModalDefaultInfoCard(token, fullWidth, 16, "approve_leave".trans(contexts), "approve_leave_desc".trans(contexts), "img_leave.png");
        });
  }
}