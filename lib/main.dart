import 'package:coupons/data/Helper.dart';
import 'package:coupons/locals/ar.dart';
import 'package:coupons/locals/en.dart';
import 'package:coupons/pages/UIHelper.dart';
import 'package:coupons/pages/home_page.dart';
import 'package:coupons/pages/welcome/splash_page.dart';
import 'package:coupons/pages/widgets/successfully_added_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  final FirebaseAuth mAuth = FirebaseAuth.instance;

  Widget pageRoute;
  bool first = true;

  @override
  void initState() {
    pageRoute = SplashPage();

    mLocal = new Arabic();

    SharedPreferences.getInstance().then((value) {
      SharedPreferences prefs = value;
      var language = (prefs.getBool('is_arabic') ?? true);
      if (language) {
        fontBold = "pr_ar_bold";
        fontReg = "pr_ar_reg";
        mLocal = new Arabic();

        isArabic = true;
      } else {
        fontBold = "pr_en_bold";
        fontReg = "pr_en_reg";
        mLocal = new English();

        isArabic = false;
      }
    });

    if (mAuth.currentUser != null) {
      auth = true;
      userId = mAuth.currentUser.uid;
      print("we have a user $userId");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Color(0xff666666)));

    if (first) {
      Future.delayed(Duration(milliseconds: 3000)).then((value) {
        setState(() {
          pageRoute = HomePage();
          first = false;
        });
      });
    }

    return MaterialApp(
      title: mLocal.app_name,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale("ar", "AE"),
        Locale("en", "US"),
      ],
      debugShowCheckedModeBanner: false,
      locale: isArabic ? Locale("ar", "AE") : Locale("en", "US"),
      home: pageRoute,
    );
  }
}
