import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirstPageModel extends ChangeNotifier {
  bool showSnipper = false;

  Future createPage(BuildContext context) async {
    this.showSnipper = true;
    notifyListeners();
    SharedPreferences pref = await SharedPreferences.getInstance();
    final currentUserId = pref.getString('u_id') ?? '';
    if (currentUserId == '') {
      Navigator.of(context).pushReplacementNamed('/signin');
    } else {
      Navigator.of(context).pushReplacementNamed('/home');
    }
  }
}
