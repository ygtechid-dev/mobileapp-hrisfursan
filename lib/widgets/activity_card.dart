part of 'widgets.dart';

class ActivityCard extends StatelessWidget {
  final double width;
  final String title;
  final String subtitle;
  final Function? onTap;

  ActivityCard(
      this.width, this.title, this.subtitle, {this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onTap!();
      },
      child: Container(
        width: width,
        margin: EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Row(
          children: [
            SvgPicture.asset("${prefixIcons}ic_activity_card.svg"),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${title}",
                  textAlign: TextAlign.start,
                  style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 3),
                Text(
                  "${subtitle}",
                  textAlign: TextAlign.start,
                  style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
