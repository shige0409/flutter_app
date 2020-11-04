import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SigninModel extends ChangeNotifier {
  String email;
  String password;
  bool showSpinner = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signin() async {
    this.showSpinner = true;
    notifyListeners();
    // todo
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
              email: this.email, password: this.password);
      print("longged in");
      SharedPreferences pref = await SharedPreferences.getInstance();
      print(userCredential.user.uid);
      await pref.setString('u_id', userCredential.user.uid);
      print("save user id to phone");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
    this.showSpinner = false;
    notifyListeners();
  }
}
