import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirstPageModel extends ChangeNotifier {
  bool showSnipper = true;

  Future<void> createPage(BuildContext context) async {
    await Future.delayed(new Duration(seconds: 2));
    try {
      await print(FirebaseAuth.instance.currentUser.uid);
      await Navigator.of(context).pushReplacementNamed('/home');
    } catch (e) {
      await Navigator.of(context).pushReplacementNamed('/signin');
    }
  }
}
