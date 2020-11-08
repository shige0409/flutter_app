import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/init_root_page.dart';
import 'package:flutter_app/presentation/home/home_page.dart';
import 'package:flutter_app/presentation/one_time_page/fourth/fourth_page.dart';
import 'package:flutter_app/presentation/one_time_page/second/second_page.dart';
import 'package:flutter_app/presentation/one_time_page/signin/signin_page.dart';
import 'package:flutter_app/presentation/one_time_page/signup/signup_page.dart';
import 'package:flutter_app/presentation/users/my_page/mypage_edit_page.dart';
import 'constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Voite",
      theme: kThemeData,
      home: Scaffold(
        body: FutureBuilder(
          future: Firebase.initializeApp(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Container(color: Colors.white);
            }
            if (snapshot.connectionState == ConnectionState.done) {
              return InitRootPage();
            }
            return Container(
              width: double.infinity,
              height: double.infinity,
              child: Image.asset('assets/icons/AppIcon.png'),
            );
          },
        ),
      ),
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => HomePage(),
        '/user/edit': (BuildContext context) => MyPageEditPage(),
        '/init': (BuildContext context) => InitRootPage(),
        '/second': (BuildContext context) => SecondPage(),
        '/fourth': (BuildContext context) => FourthPage(),
        '/signin': (BuildContext context) => SigninPage(),
        '/signup': (BuildContext context) => SignupPage(),
      },
    );
  }
}
