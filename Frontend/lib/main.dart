import 'dart:io';
import 'package:digital_healthcare_space/app_theme.dart';
import 'package:digital_healthcare_space/introduction_animation/introduction_animation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'login_screen/utils/exports.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness:
          !kIsWeb && Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
      title: 'Flutter UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //  Color(0xff132137)
        // primarySwatch: Colors.blue,
        primarySwatch: MaterialColor(0xff132137, {
          50: Color(0xff132137),
          100: Color(0xff132137),
          200: Color(0xff132137),
          300: Color(0xff132137),
          400: Color(0xff132137),
          500: Color(0xff132137),
          600: Color(0xff132137),
          700: Color(0xff132137),
          800: Color(0xff132137),
          900: Color(0xff132137),
        }),
        textTheme: AppTheme.textTheme,
        platform: TargetPlatform.iOS,
      ),
      // home: NavigationHomeScreen(),
      home: IntroductionAnimationScreen(),
      // home: LoginScreen(),
    );
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
