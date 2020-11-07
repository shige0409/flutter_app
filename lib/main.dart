import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/home/home_page.dart';
import 'package:flutter_app/presentation/one_time_page/second/second_page.dart';
import 'package:flutter_app/presentation/one_time_page/signin/signin_page.dart';
import 'package:flutter_app/presentation/one_time_page/signup/signup_page.dart';
import 'package:flutter_app/presentation/one_time_page/third/third_page.dart';
import 'constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Voite",
        theme: kThemeData,
        home: SecondPage(),
        routes: <String, WidgetBuilder>{
          '/home': (BuildContext context) => HomePage(),
          '/second_page': (BuildContext context) => SecondPage(),
          '/third_page': (BuildContext context) => ThirdPage(),
          '/signin': (BuildContext context) => SigninPage(),
          '/signup': (BuildContext context) => SignupPage(),
        });
  }
}
