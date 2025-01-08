part of 'widgets.dart';

class NotificationCard extends StatelessWidget {
  final double width;
  final String title;
  final String subtitle;
  final String time;
  final String imagePath;
  final Function? onTap;

  NotificationCard(
      this.width, this.title, this.subtitle, this.imagePath, this.time, {this.onTap});

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
            Container(
              height: 64,
              width: 64,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("${prefixImages}${imagePath}")
                )
              ),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${title}",
                      textAlign: TextAlign.start,
                      style: blackFontStyle.copyWith(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "${time}",
                      textAlign: TextAlign.end,
                      style: blackFontStyle.copyWith(fontSize: 11, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                SizedBox(height: 3),
                Text(
                  "${subtitle}",
                  textAlign: TextAlign.start,
                  style: greyFontStyle.copyWith(fontSize: 11, fontWeight: FontWeight.w400),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
