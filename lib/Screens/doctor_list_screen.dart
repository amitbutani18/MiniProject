import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../Helpers/notice_list.dart';
import 'utils/constants.dart';
import 'utils/d_colors.dart';
import 'utils/dashbord_widgets.dart';

class DoctorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: d_colorPrimary,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxISScroll) {
          return [
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              leading: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: d_white,
                        borderRadius: BorderRadius.circular(10)),
                    height: height / 30,
                    width: width / 18,
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                      size: 15,
                    ),
                  ),
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text("Top Doctors",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                    )),
                // background: ,
                // background: Image.network(
                //   "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
                //   fit: BoxFit.cover,
                // )
              ),
            ),
          ];
        },
        body: ClipRRect(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(60)),
            child: Container(
              height: height,
              width: width,
              color: Colors.white70,
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 28.0, top: 8, right: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        text(
                          'Categories',
                          textColor: d_textColorPrimary,
                          fontSize: textSizeLarge,
                          fontFamily: fontBold,
                        ),
                        text(
                          'See All',
                          textColor: d_textColorSecondary,
                          fontSize: textSizeMedium,
                          fontFamily: fontBold,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 18, top: 18),
                    // width: width,
                    height: height / 7,
                    child: AnimationLimiter(
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount: gridItems.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              height: height / 2,
                              width: width / 3.5,
                              margin: EdgeInsets.only(right: 18),
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
                                    width: width / 12,
                                    child:
                                        Image.network(gridItems[index].image),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  text(
                                    gridItems[index].title,
                                    textColor:
                                        d_textColorPrimary.withOpacity(.8),
                                    fontSize: textSizeSmall,
                                    fontFamily: fontMedium,
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                  ),
                  Expanded(
                      child: Container(
                          // color: Colors.red,

                          ))
                ],
              ),
            )),
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
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 28.0, right: 28, bottom: 28, top: 38),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  height: height / 20,
                  width: width / 10,
                  decoration: BoxDecoration(
                      color: d_white, borderRadius: BorderRadius.circular(10)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Icon(
                      Icons.keyboard_arrow_left,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                // onTap: () => Navigator.of(context).pushNamed(Doctors.route),
                child: Container(
                  height: height / 30,
                  width: width / 18,
                  child: Image.network(
                    menu_button,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomWelcomeString2 extends StatelessWidget {
  const CustomWelcomeString2({
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
              text("Top Doctors",
                  textColor: d_white,
                  fontSize: textSizeLarge,
                  fontFamily: fontMedium),
            ],
          ),
          SizedBox(
            width: width / 29,
          ),
          Container(
            height: height / 25,
            width: width / 12,
            child: Image.network(
              doctor_man,
              fit: BoxFit.fill,
            ),
          )
        ],
      ),
    );
  }
}

class CustomCardview extends StatelessWidget {
  const CustomCardview({
    Key key,
    @required this.width,
    @required this.height,
  }) : super(key: key);

  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.all(8),
          leading: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(13)),
            child: Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.green,
              ),
              child: Image.network(
                doctor_man,
                height: 50,
                width: 50,
                fit: BoxFit.contain,
              ),
            ),
          ),
          title: text(
            "smeet",
          ),
          subtitle: text(
            "vaghani",
          ),
          trailing: Icon(
            Icons.keyboard_arrow_right,
            size: 30,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
