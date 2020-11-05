import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/domain/post_data.dart';
import 'package:flutter_app/domain/user_data.dart';

class PostListModel extends ChangeNotifier {
  List<PostData> posts = [];
  DateTime now = DateTime.now();
  Future fetchPosts() async {
    final document = await FirebaseFirestore.instance
        .collection('posts')
        .orderBy('created_at', descending: true)
        .limit(10)
        .get();
    final posts = document.docs
        .map((post) => PostData(post['text'], post['u_id'], post['created_at']))
        .toList();
    this.posts = posts;
    notifyListeners();
  }

  void realTimeFetchPosts() {
    final snapshots = FirebaseFirestore.instance
        .collection('posts')
        .orderBy('created_at', descending: true)
        .limit(10)
        .snapshots();
    snapshots.listen((snapshot) {
      final posts = snapshot.docs
          .map((doc) => PostData(doc['text'], doc['u_id'], doc['created_at']))
          .toList();
      this.posts = posts;
      notifyListeners();
    });
  }

  Future<String> getImageUrl(String userId) async {
    final document = await FirebaseFirestore.instance
        .collection('users')
        .where('u_id', isEqualTo: userId)
        .get();
    final user = await document.docs
        .map((u) => UserData(u['name'], u['profile'], u['gender'],
            u['mypage_image_url'], u['u_id']))
        .toList()[0];
    return user.imageUrl;
  }
}
