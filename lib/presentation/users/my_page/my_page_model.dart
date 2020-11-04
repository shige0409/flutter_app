import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/domain/my_data.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyPageModel extends ChangeNotifier {
  MyData user = MyData(
      'name', 'profile', 'gender', 'image_url', 'user_id', 'document_id');

  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController profileTextController = TextEditingController();
  final picker = ImagePicker();
  File imageFile;
  bool isUpdated = false;
  bool showSnipper = false;

  Future getUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    final currentUserId = pref.getString('u_id');
    final document = await FirebaseFirestore.instance
        .collection('users')
        .where('u_id', isEqualTo: currentUserId)
        .get();
    final uLists = document.docs
        .map((u) => MyData(u['name'], u['profile'], u['gender'],
            u['mypage_image_url'], u['u_id'], u.id))
        .toList();
    this.user = uLists[0];
    this.nameTextController.text = user.name;
    this.profileTextController.text = user.profile;
    notifyListeners();
  }

  void editing() {
    this.isUpdated = true;
    notifyListeners();
  }

  void edited() {
    this.isUpdated = false;
    notifyListeners();
  }

  Future updateUser() async {
    this.showSnipper = true;
    notifyListeners();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(this.user.documentId)
        .update({
      'name': this.user.name,
      'profile': this.user.profile,
    });
    this.showSnipper = false;
  }

  Future getImage() async {
    // pick image from gallery
    final pickFile = await picker.getImage(source: ImageSource.gallery);
    imageFile = File(pickFile.path);

    final storage = FirebaseStorage.instance;
    StorageTaskSnapshot snapshot = await storage
        .ref()
        .child("books/${this.user.name}")
        .putFile(imageFile)
        .onComplete;
    final downloadUrl = await snapshot.ref.getDownloadURL();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(this.user.documentId)
        .update({
      'mypage_image_url': downloadUrl,
    });
  }

  Future signOut() async {
    await FirebaseAuth.instance.signOut();
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('u_id', '');
  }
}
