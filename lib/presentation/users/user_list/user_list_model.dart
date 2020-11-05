import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:flutter_app/domain/user_data.dart';

class UserListModel extends ChangeNotifier {
  List<UserData> users = [];

  Future fetchUsers() async {
    final document = await FirebaseFirestore.instance.collection('users').get();
    final users = document.docs
        .map((user) => UserData(user['name'], user['profile'], user['gender'],
            user['mypage_image_url'], user['u_id']))
        .toList();
    this.users = users;
    notifyListeners();
  }

  Future addCall(String calledUserId) async {
    final calls = await FirebaseFirestore.instance.collection('calls');
    final uId = await FirebaseAuth.instance.currentUser.uid;
    await calls.add({
      'call_id': uId + calledUserId,
      'caller_user_id': uId,
      'called_user_id': calledUserId,
      'created_at': Timestamp.now(),
    });
  }
}
