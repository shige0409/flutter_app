import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/domain/call_data.dart';
import 'package:flutter_app/domain/my_data.dart';

class CallListModel extends ChangeNotifier {
  List<CallData> callLists = [];

  Future fetchCallList() async {
    final currentUserId = MyData.getCurrenUserId();
    final document = await FirebaseFirestore.instance
        .collection('calls')
        .where('called_user_id', isEqualTo: currentUserId)
        .orderBy('created_at', descending: true)
        .limit(5)
        .get();
    final callLists = document.docs
        .map((doc) => CallData(
            doc['call_id'], doc['caller_user_id'], doc['called_user_id']))
        .toList();
    this.callLists = callLists;
    notifyListeners();
  }
}
