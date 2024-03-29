import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddPostModel extends ChangeNotifier {
  String postText = '';
  Timestamp now = Timestamp.now();

  Future addPost() async {
    final posts = await FirebaseFirestore.instance.collection('posts');
    final uId = await FirebaseAuth.instance.currentUser.uid;
    this.now = Timestamp.now();
    await posts.add({
      'text': this.postText,
      'u_id': uId,
      'created_at': this.now,
    });
    notifyListeners();
  }
}
