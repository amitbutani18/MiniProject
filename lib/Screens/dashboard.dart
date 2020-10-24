import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:miniProject/Covid_19/main.dart';
import 'package:miniProject/Helpers/notice_list.dart';
import 'package:miniProject/Screens/my_profile_sceeen.dart';
import 'package:miniProject/Screens/personal_details_screen.dart';
import 'package:miniProject/Screens/utils/constants.dart';
import 'package:miniProject/Screens/utils/d_colors.dart';
import 'package:miniProject/Screens/utils/dashbord_widgets.dart';
import 'package:miniProject/stores/login_store.dart';
import 'package:provider/provider.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:http/http.dart' as http;

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _name = '', _email = '', _imageUrl = '';

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    var firebaseUser = await _auth.currentUser;
    var uid = firebaseUser.uid;
    final url = 'https://miniproject-dc6b4.firebaseio.com/$uid/profile.json';
    final response = await http.get(url);
    final map = json.decode(response.body) as Map<String, dynamic>;
    print(map);
    print(map['email']);
    setState(() {
      _name = map['fullName'];
      _email = map['email'];
      _imageUrl = map['imageUrl'];
    });
    print(_name);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return Scaffold(
        key: _scaffoldKey,
        drawer: ClipPath(
          clipper: OvalRightBorderClipper(),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Drawer(
            child: Consumer<LoginStore>(
              builder: (_, loginStore, __) => Container(
                padding: const EdgeInsets.only(left: 16.0, right: 40),
                decoration: BoxDecoration(
                  color: Color(0xFFffffff),
                ),
                width: 300,
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            icon: Icon(
                              Icons.power_settings_new,
                              color: Colors.black,
                            ),
                            onPressed: () async {
                              SharedPreferences preferences =
                                  await SharedPreferences.getInstance();
                              preferences.clear();
                              loginStore.signOut(context);
                            },
                          ),
                        ),
                        Container(
                          height: 90,
                          width: 90,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(width: 2, color: Colors.orange),
                            image: DecorationImage(
                                image: CachedNetworkImageProvider(_imageUrl)),
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          _name,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(_email,
                            style:
                                TextStyle(color: Colors.blue, fontSize: 16.0)),
                        GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: itemList(
                                Icon(Icons.home, color: Colors.black), "Home")),
                        Divider(),
                        15.height,
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    MyProfileScreen()));
                          },
                          child: itemList(
                              Icon(Icons.person_pin, color: Colors.black),
                              "My profile"),
                        ),
                        Divider(),
                        15.height,
                        GestureDetector(
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      SplashPage())),
                          child: itemList(
                              Icon(Icons.message, color: Colors.black),
                              "Covid 19"),
                        ),
                        Divider(),
                        15.height,
                        itemList(Icon(Icons.notifications, color: Colors.black),
                            "Notifications"),
                        Divider(),
                        15.height,
                        itemList(Icon(Icons.settings, color: Colors.black),
                            "Settings"),
                        Divider(),
                        15.height,
                        itemList(Icon(Icons.email, color: Colors.black),
                            "Contact us"),
                        Divider(),
                        15.height,
                        itemList(Icon(Icons.info_outline, color: Colors.black),
                            "Help"),
                        Divider(),
                        15.height,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
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
                  CustomTItleBar(
                      height: height,
                      width: width,
                      initImage: _imageUrl,
                      callBack: () {
                        _scaffoldKey.currentState.openDrawer();
                      }),
                  CustomWelcomeString(
                    width: width,
                    height: height,
                    name: _name,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, top: 50),
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
                              return customCard(index, height, width,
                                  gridItems[index], context);
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

  Widget itemList(Widget icon, String title) {
    return Row(
      children: [
        icon,
        10.width,
        Text(title, style: TextStyle(color: Colors.black)),
      ],
    );
  }
}

class CustomWelcomeString extends StatelessWidget {
  const CustomWelcomeString({
    Key key,
    @required this.width,
    @required this.height,
    @required this.name,
  }) : super(key: key);

  final double width;
  final double height;
  final String name;

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
                name,
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
    @required this.callBack,
    @required this.initImage,
  }) : super(key: key);

  final double height;
  final double width;
  final Function callBack;
  final String initImage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 28.0, right: 28, bottom: 28, top: 38),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: callBack,
            child: Container(
              height: height / 30,
              width: width / 18,
              child: Image.network(
                menu_button,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Container(
            height: height / 20,
            width: width / 10,
            decoration: BoxDecoration(
                color: d_white, borderRadius: BorderRadius.circular(10)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                initImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
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

class OvalRightBorderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(size.width - 50, 0);
    path.quadraticBezierTo(
        size.width, size.height / 4, size.width, size.height / 2);
    path.quadraticBezierTo(size.width, size.height - (size.height / 4),
        size.width - 40, size.height);
    path.lineTo(0, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
