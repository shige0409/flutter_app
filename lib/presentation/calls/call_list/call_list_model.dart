import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/domain/call_data.dart';

class CallListModel extends ChangeNotifier {
  List<CallData> callLists = [];
  void fetchCallList() {
    final currentUserId = FirebaseAuth.instance.currentUser.uid;
    final snapshots = FirebaseFirestore.instance
        .collection('calls')
        .where('caller_user_id', isEqualTo: currentUserId)
        .orderBy('create_at', descending: true)
        .limit(10).snapshots();
    snapshots.listen((snapshot) {
      final calls = snapshot.docs.map((doc) => CallData(doc['call_id'], doc['caller_user_id'], doc['called']))
    });
  }
}
