part of "widgets.dart";

class LanguageCard extends StatelessWidget {
  final double width;
  final String iconPath;
  final String title;
  final bool isSelected;
  final ValueChanged<String>? onSelected;

  LanguageCard(
      this.width, this.title, this.iconPath, {this.onSelected, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onSelected!(title);
      },
      child: Container(
        width: width,
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: (isSelected) ? mainColor : mainColor.withOpacity(0.3), width: (isSelected) ? 2 : 1),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        child: Row(
          children: [
            Container(
              width: 32, height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage("${prefixIcons}${iconPath}")
                )
              ),
            ),
            SizedBox(width: 10),
            Text(
              "${title}",
              textAlign: TextAlign.start,
              style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}

class LanguageCard2 extends StatelessWidget {
  final double width;
  final String iconPath;
  final String title;
  final bool isSelected;
  final ValueChanged<String>? onSelected;

  LanguageCard2(
      this.width, this.title, this.iconPath, {this.onSelected, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onSelected!(title);
      },
      child: Container(
        width: width,
        margin: EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: (isSelected) ? mainColor : mainColor.withOpacity(0.3), width: (isSelected) ? 2 : 1),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 32, height: 32,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage("${prefixIcons}${iconPath}")
                      )
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  "${title}",
                  textAlign: TextAlign.start,
                  style: blackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            Icon((isSelected) ? Icons.check_circle : Icons.circle_outlined, size: 24, color: (isSelected) ? mainColor : greyColor)
          ]
        ),
      ),
    );
  }
}