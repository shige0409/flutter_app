import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/domain/my_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyPageModel extends ChangeNotifier {
  MyData user = MyData();

  Future getUser() async {
    final userId = await MyData.getCurrenUserId();
    this.user = await MyData.getUser(userId);
    notifyListeners();
  }

  Future signOut() async {
    await FirebaseAuth.instance.signOut();
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove('document_id');
    await pref.remove('u_id');
  }
}
