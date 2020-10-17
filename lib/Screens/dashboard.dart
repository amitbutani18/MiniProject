import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:miniProject/Helpers/notice_list.dart';
import 'package:miniProject/Screens/utils/constants.dart';
import 'package:miniProject/Screens/utils/d_colors.dart';
import 'package:miniProject/Screens/utils/dashbord_widgets.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return Scaffold(
        body: Stack(
      children: [
        CustomWave(),
        Container(
          height: height,
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomTItleBar(height: height, width: width),
              CustomWelcomeString(width: width, height: height),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 50),
                child: Container(
                  child: TextField(
                    textAlignVertical: TextAlignVertical.center,
                    decoration: searchInputDecoration(),
                  ),
                  alignment: Alignment.center,
                ),
              ),
              // customNoticeBoard(height, width),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 18, 0, 18),
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: height / 5,
                    autoPlay: true,
                  ),
                  items: notices.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(15.0, 8, 8, 0),
                          child: AnimatedContainer(
                            duration: Duration(seconds: 1),
                            height: height / 5,
                            width: width,
                            decoration: BoxDecoration(
                                color: i.color.withOpacity(.9),
                                borderRadius: BorderRadius.circular(25)),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          22.0, 18, 0, 0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                      padding: EdgeInsets.only(
                                          top: 18, right: 0, left: 0),
                                      child: Image.network(i.image),
                                    )),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 28.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: text(
                    'What do you need?',
                    textColor: d_textColorPrimary,
                    fontSize: textSizeLarge,
                    fontFamily: fontBold,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(18.0, 10, 18, 0),
                  child: AnimationLimiter(
                    child: GridView.builder(
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: gridItems.length,
                        gridDelegate:
                            new SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                crossAxisCount: 3),
                        itemBuilder: (BuildContext context, int index) {
                          return customCard(
                              index, height, width, gridItems[index]);
                        }),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    ));
  }
}

class CustomWelcomeString extends StatelessWidget {
  const CustomWelcomeString({
    Key key,
    @required this.width,
    @required this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 28.0, right: 28),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              text("Hello",
                  textColor: d_white,
                  fontSize: textSizeLarge,
                  fontFamily: fontMedium),
              text(
                "Amit Butani !",
                textColor: d_white,
                fontSize: textSizeXLarge,
                fontFamily: fontBold,
              ),
            ],
          ),
          SizedBox(
            width: width / 29,
          ),
          Container(
            height: height / 25,
            width: width / 12,
            child: Image.network(
              heart_image,
              fit: BoxFit.fill,
            ),
          )
        ],
      ),
    );
  }
}

class CustomTItleBar extends StatelessWidget {
  const CustomTItleBar({
    Key key,
    @required this.height,
    @required this.width,
  }) : super(key: key);

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 28.0, right: 28, bottom: 28, top: 38),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: height / 20,
            width: width / 10,
            decoration: BoxDecoration(
                color: d_white, borderRadius: BorderRadius.circular(10)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                profile_image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: height / 30,
            width: width / 18,
            child: Image.network(
              menu_button,
              fit: BoxFit.contain,
            ),
          )
        ],
      ),
    );
  }
}

class CustomWave extends StatelessWidget {
  const CustomWave({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WaveWidget(
      config: CustomConfig(
        gradients: [
          [Colors.white, Color(0xFF7380F2)],
          [Colors.white30, Color(0xFF6B78E0)],
          [Colors.white24, Color(0xFF6270DD)],
          [Colors.white70, Colors.white70]
        ],
        durations: [35000, 19440, 10800, 6000],
        heightPercentages: [0.15, 0.15, 0.15, 0.15],
        blur: MaskFilter.blur(BlurStyle.inner, 0),
        gradientBegin: Alignment.topLeft,
        gradientEnd: Alignment.bottomLeft,
      ),
      waveAmplitude: 0,
      backgroundColor: d_colorPrimary,
      // heightPercentages: [0.25, 0.26, 0.28, 0.31],
      size: Size(
        double.infinity,
        double.infinity,
      ),
    );
  }
}
