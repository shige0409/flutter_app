import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_app/domain/user_data.dart';

class UserListModel extends ChangeNotifier {
  List<UserData> users = [];

  Future fetchUsers() async {
    final document = await FirebaseFirestore.instance.collection('users').get();
    final users = document.docs
        .map((user) =>
            UserData(user['name'], user['profile'], user['gender'], "", ""))
        .toList();
    this.users = users;
    notifyListeners();
  }
}
