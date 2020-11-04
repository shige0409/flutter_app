import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/home/home_page.dart';
import 'package:flutter_app/presentation/one_time_page/signin/signin_page.dart';
import 'package:flutter_app/presentation/one_time_page/signup/signup_page.dart';
import 'constants.dart';
import 'package:flutter_app/presentation/one_time_page/first_page/first_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "flutter auth",
        theme: ThemeData(
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
        ),
        home: FirstPage(),
        routes: <String, WidgetBuilder>{
          '/home': (BuildContext context) => HomePage(),
          '/first_page': (BuildContext context) => FirstPage(),
          '/signin': (BuildContext context) => SigninPage(),
          '/signup': (BuildContext context) => SignupPage(),
        });
  }
}
