import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_app/domain/user_data.dart';

class UserListModel extends ChangeNotifier {
  List<UserData> users = [];

  Future fetchUsers() async {
    final document = await FirebaseFirestore.instance.collection('users').get();
    final users = document.docs
        .map((user) => UserData(
              name: user['name'],
              userId: user['u_id'],
              imageUrl: user['image_url'],
            ))
        .toList();
    final removeIndex = users.indexWhere(
        (element) => element.userId == FirebaseAuth.instance.currentUser.uid);
    users.removeAt(removeIndex);
    this.users = users;
    notifyListeners();
  }

  Future addCall(String calledUserId) async {
    final callId =
        calledUserId.hashCode + FirebaseAuth.instance.currentUser.uid.hashCode;
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
