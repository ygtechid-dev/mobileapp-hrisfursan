part of 'widgets.dart';

class WorkingCard extends StatefulWidget {
  final String token;
  final double width;

  WorkingCard(this.token, this.width);

  @override
  State<WorkingCard> createState() => _WorkingCardState();
}

class _WorkingCardState extends State<WorkingCard> {
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
            "Total Working Hour",
            textAlign: TextAlign.start,
            style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 3),
          Text(
            "Paid Period 25 Nov 2024 - 25 Dec 2024",
            textAlign: TextAlign.start,
            style: greyFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TimeCard((widget.width - 2*16)/2 - 5, "Clock In", "00:00"),
              TimeCard((widget.width - 2*16)/2 - 5, "Clock Out", "00:00"),
            ],
          ),
          SizedBox(height: 12),
          ButtonCard("Check In Now", widget.width - 2*16, mainColor, colorGradient: buttonGradient, onPressed: () async {}),
        ]
      ),
    );
  }
}

class TimeCard extends StatelessWidget {
  final double width;
  final String title;
  final String time;

  TimeCard(this.width, this.title, this.time);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: "F9F9F9".toColor(),
        border: Border.all(color: greyColor),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleCard(title, iconData: Icons.access_time_filled,),
          SizedBox(height: 5),
          Text(
            "${time}",
            textAlign: TextAlign.start,
            style: blackFontStyle.copyWith(fontSize: 22, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}


class TitleCard extends StatelessWidget {
  final String title;
  final String? iconPath;
  final IconData? iconData;

  TitleCard(this.title, {this.iconPath, this.iconData});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          (iconPath != null) ? SvgPicture.asset("${prefixIcons}${iconPath}", width: 16, height: 16) : SizedBox(),
          (iconData != null) ? Icon(iconData, size: 16, color: greyColor) : SizedBox(),
          SizedBox(width: 4),
          Text(
            "${title}",
            textAlign: TextAlign.start,
            style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
