import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:miniProject/Helpers/upload_sedual.dart';
import 'package:miniProject/Screens/doc_personal_screen.dart';
import 'package:miniProject/Screens/doctor_list_screen.dart';
import 'package:miniProject/Screens/razorpay_screen.dart';
import 'package:miniProject/Screens/scheduleing_screen.dart';
import 'package:miniProject/Screens/splash_page.dart';
import 'package:miniProject/Screens/utils/d_colors.dart';
import 'package:miniProject/providers/helper_provider.dart';
import 'package:miniProject/stores/login_store.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snap) => MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: HelperProvider()),
          ChangeNotifierProvider.value(value: UploadSedual()),
          Provider<LoginStore>(
            create: (_) => LoginStore(),
          )
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              primaryColor: d_colorPrimary,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            routes: {
              'diagnostics': (context) => DoctorScreen(),
              'appointment': (context) => DocPersonal(),
            },
            home: SplashPage()),
      ),
    );
  }
}
