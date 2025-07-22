part of 'widgets.dart';

class MenuCard extends StatelessWidget {
  final double width;
  final String title;
  final String iconPath;
  final Function? onTap;
  
  MenuCard(this.width, this.title, this.iconPath, {this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onTap!();
      },
      child: Container(
        width: width,
        child: Column(
          children: [
            SvgPicture.asset("${prefixIcons}${iconPath}", width: 40, height: 40,),
            SizedBox(height: 6),
            Container(
              width: width,
              child: Text(
                "${title}",
                textAlign: TextAlign.center,
                style: blackFontStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
              ),
            )
          ],
        ),
      ),
    );
  }
}
