import 'dart:async';

import 'package:flutter/material.dart';
import 'package:miniProject/Covid_19/ui/home/HomePage.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration(seconds: 3),
      () {
        decideWhichPageToGo();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 100,
          child: Hero(
            tag: "ic_goaway",
            child: Image.asset('assets/img/ic_go_away.png'),
          ),
        ),
      ),
    );
  }

  void decideWhichPageToGo() async {
    gotoHomePage();
  }

  void gotoHomePage() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 800),
        pageBuilder: (
          _,
          __,
          ___,
        ) =>
            HomePage(),
      ),
    );
  }
}
