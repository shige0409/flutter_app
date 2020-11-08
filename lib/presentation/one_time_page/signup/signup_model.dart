import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/domain/my_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupModel extends ChangeNotifier {
  String email;
  String password;

  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  bool showSnipper = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future signup() async {
    this.showSnipper = true;
    notifyListeners();
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: this.email, password: this.password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future createUser() async {
    await MyData.createUser();
    this.showSnipper = false;
    notifyListeners();
    print('finish create user');
  }
}
