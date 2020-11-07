import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/home/home_page.dart';
import 'package:flutter_app/presentation/one_time_page/signin/signin_page.dart';

class InitRootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Container(color: Colors.white);
        }
        if (snapshot.connectionState == ConnectionState.done) {
          try {
            print(FirebaseAuth.instance.currentUser.uid);
            return HomePage();
          } catch (e) {
            return SigninPage();
          }
        }
        return Container(
          color: Colors.white,
          width: double.infinity,
          child: Center(
            child: null,
          ),
        );
      },
    );
  }
}
