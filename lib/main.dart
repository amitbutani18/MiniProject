import 'package:flutter/material.dart';
import 'package:miniProject/Screens/doctor_list_screen.dart';
import 'package:miniProject/Screens/splash_page.dart';
import 'package:miniProject/Screens/utils/d_colors.dart';
import 'package:miniProject/providers/helper_provider.dart';
import 'package:miniProject/stores/login_store.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: HelperProvider()),
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
          },
          home: SplashPage()),
    );
  }
}
