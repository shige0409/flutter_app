import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/domain/my_data.dart';

import 'package:flutter_app/domain/user_data.dart';

class UserListModel extends ChangeNotifier {
  List<UserData> users = [];

  Future fetchUsers() async {
    final document = await FirebaseFirestore.instance.collection('users').get();
    final users = document.docs
        .map(
          (user) => UserData(
            city: user['city'],
            profile: user['profile'],
            loginAt: user['login_at'],
            gender: user['gender'],
            age: user['age'],
            name: user['name'],
            userId: user['u_id'],
            imageUrl: user['image_url'],
          ),
        )
        .toList();
    final userId = await MyData.getCurrenUserId();
    final removeIndex = users.indexWhere((element) => element.userId == userId);
    users.removeAt(removeIndex);
    this.users = users;
    notifyListeners();
  }

  void show(BuildContext context) {}

  Future addCall(String calledUserId) async {
    final currenUserId = await MyData.getCurrenUserId();
    final callId = calledUserId.hashCode + currenUserId.hashCode;
    final calls = FirebaseFirestore.instance.collection('calls');
    await calls.add({
      'call_id': callId.toString(),
      'caller_user_id': FirebaseAuth.instance.currentUser.uid,
      'called_user_id': calledUserId,
      'is_opend': false,
      'created_at': Timestamp.now(),
    });
  }
}
