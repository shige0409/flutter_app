import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/domain/user_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SigninModel extends ChangeNotifier {
  String email;
  String password;
  bool showSpinner = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signin() async {
    this.showSpinner = true;
    notifyListeners();

    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
              email: this.email, password: this.password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }

    final String myDocumentId =
        await UserData.getDocumentId(_auth.currentUser.uid);
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('document_id', myDocumentId);

    this.showSpinner = false;
    notifyListeners();
  }
}
