import 'package:flutter/material.dart';
import 'package:miniProject/Screens/dashboard.dart';
import 'package:miniProject/Screens/personal_details_screen.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:miniProject/Screens/login_page.dart';
import 'package:miniProject/stores/login_store.dart';
import 'package:miniProject/theme.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key key}) : super(key: key);
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool _isInit = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (_isInit) {
      // SharedPreferences preferences = await SharedPreferences.getInstance();
      // var _isDetAvl = preferences.getBool('perDetAvl');

      Provider.of<LoginStore>(context, listen: false)
          .isAlreadyAuthenticated()
          .then((result) {
        if (result) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => DashBoard()),
              (Route<dynamic> route) => false);
        } else {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const LoginPage()),
              (Route<dynamic> route) => false);
        }
      });
      _isInit = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primaryColor,
    );
  }
}
