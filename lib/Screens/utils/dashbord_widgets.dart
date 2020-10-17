import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:miniProject/Helpers/notice_list.dart';
import 'package:miniProject/Screens/utils/d_colors.dart';
import 'package:miniProject/Screens/utils/constants.dart';
import 'package:miniProject/providers/helper_provider.dart';
import 'package:provider/provider.dart';

Widget text(var text,
    {var fontSize = textSizeLargeMedium,
    textColor = d_textColorSecondary,
    var fontFamily = fontRegular,
    var isCentered = false,
    var maxLine = 1,
    var latterSpacing = 0.5}) {
  return Text(
    text,
    textAlign: isCentered ? TextAlign.center : TextAlign.start,
    maxLines: maxLine,
    style: TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize,
        color: textColor,
        height: 1.5,
        letterSpacing: latterSpacing),
  );
}

InputDecoration searchInputDecoration() {
  return InputDecoration(
    filled: true,
    fillColor: d_white,
    hintText: "Search",
    border: InputBorder.none,
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 0.5),
      borderRadius: BorderRadius.circular(15),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 0.5),
      borderRadius: BorderRadius.circular(15),
    ),
    prefixIcon: Icon(
      Icons.search,
      color: d_colorPrimary,
    ),
    contentPadding:
        EdgeInsets.only(left: 26.0, bottom: 8.0, top: 8.0, right: 50.0),
  );
}

BoxDecoration boxDecoration(
    {double radius = 2,
    Color color = Colors.transparent,
    Color bgColor = Colors.white,
    var showShadow = false}) {
  return BoxDecoration(
    color: bgColor,
    boxShadow: showShadow
        ? [BoxShadow(color: Color(0X95E9EBF0), blurRadius: 2, spreadRadius: 2)]
        : [BoxShadow(color: Colors.transparent)],
    border: Border.all(color: color),
    borderRadius: BorderRadius.all(Radius.circular(radius)),
  );
}

AnimationConfiguration customCard(
    int index, double height, double width, GridItem gridItem) {
  return AnimationConfiguration.staggeredGrid(
    columnCount: 3,
    position: index,
    duration: const Duration(milliseconds: 400),
    child: ScaleAnimation(
      child: FadeInAnimation(
        child: new GestureDetector(
          child: new Container(
            decoration: BoxDecoration(
                color: d_app_background,
                borderRadius: BorderRadius.circular(15)),
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: height / 20,
                  width: width / 13,
                  child: Image.network(gridItem.image),
                ),
                SizedBox(
                  height: 5,
                ),
                text(
                  gridItem.title,
                  textColor: d_textColorPrimary.withOpacity(.8),
                  fontSize: textSizeSmall,
                  fontFamily: fontMedium,
                ),
              ],
            ),
          ),
          onTap: () {},
        ),
      ),
    ),
  );
}

Widget customNoticeBoard(double height, double width) {
  return Consumer<HelperProvider>(
    builder: (context, provider, ch) => Padding(
      padding: const EdgeInsets.fromLTRB(28, 18, 28, 18),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 8, 8, 0),
            child: AnimatedContainer(
              duration: Duration(seconds: 1),
              height: provider.noticeShow ? height / 5 : 0,
              width: width,
              decoration: BoxDecoration(
                  color: Color(0xFF4EBAD4).withOpacity(.9),
                  borderRadius: BorderRadius.circular(25)),
              child: Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(22.0, 28, 0, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            text(
                              'Stay Home',
                              textColor: Colors.white,
                              fontSize: textSizeNormal,
                              fontFamily: fontBold,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            text(
                                'Schedule on e-visit and discuss the plan with a doctor.',
                                textColor: Colors.white,
                                fontSize: textSizeMedium,
                                fontFamily: fontMedium,
                                maxLine: null),
                          ],
                        ),
                      )),
                  Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.only(top: 18, right: 0, left: 0),
                        child: Image.network(doctor_man),
                      )),
                ],
              ),
            ),
          ),
          provider.noticeShow
              ? Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      provider.chageNoticeValue();
                    },
                    child: CircleAvatar(
                      backgroundColor: d_red,
                      radius: 15,
                      child: Icon(
                        Icons.close,
                        color: d_white,
                      ),
                    ),
                  ),
                )
              : Container()
        ],
      ),
    ),
  );
}
