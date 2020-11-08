import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class MyData {
  MyData({
    this.name,
    this.profile,
    this.gender,
    this.imageUrl,
    this.userId,
    this.documentId,
    this.age,
    this.city,
  });
  String gender;
  String name;
  String profile;
  String imageUrl;
  String userId;
  String documentId;
  String age;
  String city;

  static Future<MyData> getUser(String userId) async {
    final document = await FirebaseFirestore.instance
        .collection('users')
        .where('u_id', isEqualTo: userId)
        .get();
    final u = document.docs.last;
    return MyData(
      gender: u['gender'],
      name: u['name'],
      profile: u['profile'],
      imageUrl: u['image_url'],
      userId: u['u_id'],
      documentId: u.id,
      age: u['age'],
      city: u['city'],
    );
  }

  static Future createUser() async {
    String userId = "";
    try {
      userId = FirebaseAuth.instance.currentUser.uid;
    } catch (e) {
      userId = getRandomId();
    }

    final users = FirebaseFirestore.instance.collection('users');
    final result = await users.add({
      'gender': 'gender',
      'name': 'name',
      'city': 'city',
      'age': '',
      'profile': 'profile',
      'image_url': kFirstImageUrl,
      'u_id': userId,
      'is_calling': false,
      'created_at': Timestamp.now(),
      'login_at': Timestamp.now(),
    });

    // 端末にdocumentIdを保存
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('document_id', result.id);
    await pref.setString('u_id', userId);
  }

  static Future<void> updateUser(
      String documentId, Map<String, dynamic> userDict) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(documentId)
        .update(userDict);
  }

  static String getRandomId() {
    const _randomChars =
        "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    final rand = Random.secure();
    final codeUnits = List.generate(
      20,
      (index) {
        final n = rand.nextInt(_randomChars.length);
        return _randomChars.codeUnitAt(n);
      },
    );
    return String.fromCharCodes(codeUnits);
  }

  static Future<String> getCurrenUserId() async {
    String userId = "";
    try {
      userId = FirebaseAuth.instance.currentUser.uid;
    } catch (e) {
      final pref = await SharedPreferences.getInstance();
      userId = await pref.getString('u_id');
    }
    return userId;
  }
}
