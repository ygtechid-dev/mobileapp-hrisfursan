part of "widgets.dart";

class CalendarCard extends StatefulWidget {
  final ValueChanged<List<String>>? onSelected;

  CalendarCard({this.onSelected});

  @override
  State<CalendarCard> createState() => _CalendarCardState();
}

class _CalendarCardState extends State<CalendarCard> {

  bool isBeginActive = false;
  bool isEndActive = false;

  String? selectedData;

  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';

  String? startDate, endDate, startDay, endDay, selectedStartDate, selectedEndDate;

  /// The method for [DateRangePickerSelectionChanged] callback, which will be
  /// called whenever a selection changed on the date picker widget.
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    /// The argument value will return the changed date as [DateTime] when the
    /// widget [SfDateRangeSelectionMode] set as single.
    ///
    /// The argument value will return the changed dates as [List<DateTime>]
    /// when the widget [SfDateRangeSelectionMode] set as multiple.
    ///
    /// The argument value will return the changed range as [PickerDateRange]
    /// when the widget [SfDateRangeSelectionMode] set as range.
    ///
    /// The argument value will return the changed ranges as
    /// [List<PickerDateRange] when the widget [SfDateRangeSelectionMode] set as
    /// multi range.
    setState(() {
      if (args.value is PickerDateRange) {
        _range = '${intl.DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
        // ignore: lines_longer_than_80_chars
            ' ${intl.DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
        startDate = '${intl.DateFormat('dd MMMM').format(args.value.startDate)}';
        endDate = '${intl.DateFormat('dd MMMM').format(args.value.endDate)}';

        startDay = '${intl.DateFormat('EEEE').format(args.value.startDate)}';
        endDay = '${intl.DateFormat('EEEE').format(args.value.endDate)}';

        selectedStartDate = '${intl.DateFormat('yyyy-MM-dd').format(args.value.startDate)}';
        selectedEndDate = '${intl.DateFormat('yyyy-MM-dd').format(args.value.endDate)}';

        widget.onSelected!(["${selectedStartDate}", "${selectedEndDate}"]);

      } else if (args.value is DateTime) {
        _selectedDate = args.value.toString();
      } else if (args.value is List<DateTime>) {
        _dateCount = args.value.length.toString();
      } else {
        _rangeCount = args.value.length.toString();
      }
    });
  }


  @override
  void initState() {
    startDate = intl.DateFormat('dd MMMM').format(DateTime.now().subtract(const Duration(days: 1)));
    endDate = intl.DateFormat('dd MMMM').format(DateTime.now().add(const Duration(days: 1)));

    startDay = intl.DateFormat('EEEE').format(DateTime.now().subtract(const Duration(days: 1)));
    endDay = intl.DateFormat('EEEE').format(DateTime.now().add(const Duration(days: 1)));

    selectedStartDate = '${intl.DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(const Duration(days: 1)))}';
    selectedEndDate = '${intl.DateFormat('yyyy-MM-dd').format(DateTime.now().add(const Duration(days: 1)))}';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double defaultWidth = MediaQuery.of(context).size.width - 2*defaultMargin2;
    double itemWidth = MediaQuery.of(context).size.width - 2*defaultMargin3;
    double fullWidth = MediaQuery.of(context).size.width;

    return Container(
      width: defaultWidth,
      padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: mainColor)
      ),
      child: Column(
        children: [
          SfDateRangePicker(
            backgroundColor: Colors.white,
            selectionColor: mainColor.withOpacity(0.5),
            startRangeSelectionColor: mainColor,
            endRangeSelectionColor: mainColor,
            rangeSelectionColor: mainColor.withOpacity(0.2),
            todayHighlightColor: mainColor,
            headerStyle: DateRangePickerHeaderStyle(
              backgroundColor: Colors.white,
            ),
            onSelectionChanged: _onSelectionChanged,
            selectionMode: DateRangePickerSelectionMode.range,
            initialSelectedRange: PickerDateRange(
                DateTime.now().subtract(const Duration(days: 1)),
                DateTime.now().add(const Duration(days: 1))
            ),
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     InkWell(
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.start,
          //         children: [
          //           Icon(Icons.arrow_back_ios_new, size: 18, color: mainColor),
          //           SizedBox(width: 5),
          //           Text(
          //             "Nov",
          //             textAlign: TextAlign.start,
          //             style: blackFontStyle.copyWith(fontSize: 12, color: mainColor, fontWeight: FontWeight.w400),
          //           ),
          //         ],
          //       ),
          //     ),
          //     Text(
          //       "Dec 2024",
          //       textAlign: TextAlign.start,
          //       style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
          //     ),
          //     InkWell(
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.end,
          //         children: [
          //           Text(
          //             "Jan",
          //             textAlign: TextAlign.end,
          //             style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
          //           ),
          //           SizedBox(width: 5),
          //           Icon(Icons.arrow_forward_ios, size: 18),
          //         ],
          //       ),
          //     )
          //   ],
          // ),
          // SizedBox(height: 20),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: listDay.map((e) => Container(
          //     width: (defaultWidth - 2*20)/7-10,
          //     child: Text(
          //       "${e}",
          //       textAlign: TextAlign.center,
          //       style: blackFontStyle.copyWith(fontSize: 11, fontWeight: FontWeight.w400),
          //     )
          //   )).toList()
          // ),
          // SizedBox(height: 10),
          // Divider(thickness: 1),
          // SizedBox(height: 10),
          // Wrap(
          //   alignment: WrapAlignment.spaceBetween,
          //   spacing: 20, runSpacing: 20,
          //   runAlignment: WrapAlignment.start,
          //   children: listDate.map((e) => Container(
          //     width: (defaultWidth - 2*20)/7-10,
          //     padding: EdgeInsets.all(2),
          //     decoration: (e == "1") ? BoxDecoration(
          //       shape: BoxShape.circle,
          //       color: mainColor
          //     ) : null,
          //     child: Text(
          //       "${e}",
          //       textAlign: TextAlign.center,
          //       style: blackFontStyle.copyWith(fontSize: 11, color: (e == "23" || e == "24" || e == "25" || e == "31") ? Colors.red : (e == "1") ? Colors.white : greyColor, fontWeight: FontWeight.w400),
          //     ),
          //   )).toList()
          // )
        ]
      ),
    );
  }
}

class EventCard extends StatefulWidget {
  final double width;
  final String status;
  final Color color;
  final List<EventData> listData;

  EventCard(this.width, this.status, this.color, this.listData);

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  bool isShow = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: widget.width,
          margin: EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            color: widget.color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                decoration: BoxDecoration(
                    color: widget.color.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(40)
                ),
                child: Text(
                  "${widget.status}",
                  textAlign: TextAlign.start,
                  style: blackFontStyle.copyWith(fontSize: 11, color: widget.color, fontWeight: FontWeight.w600),
                ),
              ),
              Text(
                "${widget.listData.length} Schedule",
                textAlign: TextAlign.start,
                style: blackFontStyle.copyWith(fontSize: 12, color: widget.color.withOpacity(0.4), fontWeight: FontWeight.w400),
              ),
              InkWell(
                  onTap: (){
                    setState((){
                      isShow = !isShow;
                    });
                  },
                  child: Icon((isShow) ? Icons.keyboard_arrow_up_outlined : Icons.keyboard_arrow_down_outlined, color: widget.color.withOpacity(0.4), size: 24)
              )
            ],
          ),
        ),
        (isShow) ? Column(
          children: widget.listData.map((e) => Container(
              width: widget.width,
              margin: EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: widget.color.withOpacity(0.4)),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                      decoration: BoxDecoration(
                          color: widget.color.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(40)
                      ),
                      child: Text(
                        "${e.status!.capitalizeFirst}",
                        textAlign: TextAlign.start,
                        style: blackFontStyle.copyWith(fontSize: 11, color: widget.color.withOpacity(0.5), fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(height: 15),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "${e.title}",
                              textAlign: TextAlign.start,
                              style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 3),
                            Container(
                              width: widget.width - 2*14 - 30,
                              child: Text(
                                "${e.description}",
                                textAlign: TextAlign.start,
                                style: greyFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                              ),
                            )
                          ],
                        ),
                        Icon(Icons.check_circle, size: 24, color: Colors.green,)
                      ]
                    ),
                    SizedBox(height: 10),
                    Divider(thickness: 1),
                    SizedBox(height: 10),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${e.start}",
                            textAlign: TextAlign.start,
                            style: greyFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                          ),
                          Text(
                            "by Staff HR",
                            textAlign: TextAlign.end,
                            style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                        ]
                    ),
                  ]
              )
          )).toList()
        ) : SizedBox()
      ]
    );
  }
}
