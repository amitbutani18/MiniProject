import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:miniProject/Covid_19/ui/home/faq/FaqPage.dart';
import 'package:miniProject/Covid_19/ui/home/global/GlobalPage.dart';
import 'package:miniProject/Covid_19/ui/home/map/MapPage.dart';
import 'package:miniProject/Covid_19/ui/home/news/NewsPage.dart';
import 'package:miniProject/Covid_19/util/ColorUtil.dart';
import 'package:miniProject/Covid_19/util/StyleUtil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> screens = [GlobalPage(), FaqPage(), NewsPage(), MapPage()];
  Widget currentScreen = GlobalPage();
  final PageStorageBucket bucket = PageStorageBucket();
  int currentTab = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor:
            currentTab == 3 ? Colors.white : getPageBackgroundColor(),
        title: Row(
          children: <Widget>[
            Container(
              height: 30,
              width: 100,
              child: Hero(
                  tag: "ic_goaway",
                  child: Image.asset(
                    'assets/img//ic_go_away.png',
                    fit: BoxFit.cover,
                  )),
            ),
            Spacer(),
            InkWell(
                onTap: () {
                  removeUserCountry();
                },
                child: Text(getPageTitle(currentTab),
                    style: getPageTitleTextStyle(18.0)))
          ],
        ),
      ),
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      bottomNavigationBar: getBottomNavigationBar(),
    );
  }

  Widget getBottomNavigationBar() {
    return BubbleBottomBar(
      // type: BottomNavigationBarType.fixed,
      currentIndex: currentTab,
      backgroundColor: getBottomNavigationBarColor(),
      opacity: .2,
      // color: Color(0XFFffffff),
      // showSelectedLabels: false,
      // showUnselectedLabels: false,
      items: <BubbleBottomBarItem>[
        BubbleBottomBarItem(
          backgroundColor: Colors.indigo,
          icon: Container(
            height: 24,
            width: 24,
            child: Image.asset(
              "assets/img//tab_icon_global.png",
              fit: BoxFit.contain,
            ),
          ),
          title: Text("Global"),
        ),
        BubbleBottomBarItem(
          backgroundColor: Colors.indigo,
          icon: Container(
            height: 24,
            width: 24,
            child: Image.asset(
              "assets/img//tab_icon_faq.png",
              fit: BoxFit.contain,
            ),
          ),
          title: Text("FAQ"),
        ),
        BubbleBottomBarItem(
          backgroundColor: Colors.indigo,
          icon: Container(
            height: 24,
            width: 24,
            child: Image.asset(
              "assets/img//tab_icon_news.png",
              fit: BoxFit.contain,
            ),
          ),
          title: Text("News"),
        ),
        BubbleBottomBarItem(
          backgroundColor: Colors.indigo,
          icon: Container(
            height: 24,
            width: 24,
            child: Image.asset(
              "assets/img//tab_icon_map.png",
              fit: BoxFit.contain,
            ),
          ),
          title: Text("Map"),
        ),
        // Image.asset(
        //   "assets/img//tab_icon_faq.png",
        // ),
        // Image.asset(
        //   "assets/img//tab_icon_news.png",
        // ),
        // Image.asset(
        //   "assets/img//tab_icon_map.png",
        // ),
      ],
      onTap: (index) {
        setState(() {
          currentScreen = screens[index];
          currentTab = index;
        });
      },
    );
  }

  String getPageTitle(int currentTab) {
    var pageTitle = "GLOBAL";
    switch (currentTab) {
      case 0:
        pageTitle = 'GLOBAL';
        break;
      case 1:
        pageTitle = 'FAQ';
        break;
      case 2:
        pageTitle = 'NEWS';
        break;
      case 3:
        pageTitle = 'MAP';
        break;
    }
    setState(() {
      pageTitle = pageTitle;
    });
    return pageTitle;
  }
}

void removeUserCountry() async {
  var preference = await SharedPreferences.getInstance();
  preference.remove('userCountry');
}
