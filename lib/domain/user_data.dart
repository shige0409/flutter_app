import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserData {
  final String name;
  String profile;
  String gender;
  String imageUrl;
  bool isCalling;
  final String userId;

  UserData({
    @required this.name,
    this.profile = "",
    this.gender = "",
    this.isCalling = false,
    this.imageUrl = "",
    @required this.userId,
  });

  static Future<UserData> getUser(String userId) async {
    final document = await FirebaseFirestore.instance
        .collection('users')
        .where('u_id', isEqualTo: userId)
        .get();
    final u = document.docs.first;
    return UserData(
      name: u['name'],
      profile: u['profile'],
      gender: u['gender'],
      imageUrl: u['mypage_image_url'],
      isCalling: u['is_calling'],
      userId: u['u_id'],
    );
  }

  static Future<String> getDocumentId(String userId) async {
    final document = await FirebaseFirestore.instance
        .collection('users')
        .where('u_id', isEqualTo: userId)
        .get();
    return document.docs.first.id;
  }

  static Future<bool> isCallingUser(String userId) async {
    final document = await FirebaseFirestore.instance
        .collection('users')
        .where('u_id', isEqualTo: userId)
        .get();
    return document.docs.first['is_calling'];
  }

  static Future<void> updateIsCalling(bool isCalling) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String documentId = await pref.getString('document_id');
    await FirebaseFirestore.instance
        .collection('users')
        .doc(documentId)
        .update({"is_calling": isCalling});
  }
}
