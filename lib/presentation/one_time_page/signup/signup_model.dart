import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
      // 端末にuIdを保存
      SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.setString('u_id', userCredential.user.uid);
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
    final u_id = FirebaseAuth.instance.currentUser.uid;
    await users.add({
      'gender': 'gender',
      'name': 'name',
      'profile': 'profile',
      'u_id': u_id,
      'mypage_image_url':
          'https://i0.wp.com/sozaikoujou.com/wordpress/wp-content/uploads/2020/02/th_ca_recruitmen202.png?w=600&ssl=1',
    });
    this.showSnipper = false;
    notifyListeners();
    print('finish create user');
  }
}
