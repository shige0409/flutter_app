import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/domain/my_data.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyPageModel extends ChangeNotifier {
  MyData user;

  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController profileTextController = TextEditingController();
  final picker = ImagePicker();
  File imageFile;
  bool isUpdated = false;
  bool showSnipper = false;

  Future getUser() async {
    final userId = await MyData.getCurrenUserId();
    this.user = await MyData.getUser(userId);
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
    await MyData.updateUser(this.user.documentId, {
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
        .child("users/${this.user.userId}")
        .putFile(imageFile)
        .onComplete;
    final downloadUrl = await snapshot.ref.getDownloadURL();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(this.user.documentId)
        .update({
      'image_url': downloadUrl,
    });
  }

  Future signOut() async {
    await FirebaseAuth.instance.signOut();
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove('document_id');
    await pref.remove('u_id');
  }
}
