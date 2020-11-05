import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupModel extends ChangeNotifier {
  String email;
  String password;
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
    final users = FirebaseFirestore.instance.collection('users');
    final result = await users.add({
      'gender': 'gender',
      'name': 'name',
      'profile': 'profile',
      'u_id': FirebaseAuth.instance.currentUser.uid,
      'is_calling': false,
      'mypage_image_url': kFirstImageUrl,
      'created_at': Timestamp.now(),
    });

    // 端末にdocumentIdを保存
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('document_id', result.id);
    this.showSnipper = false;
    notifyListeners();
    print('finish create user');
  }
}
