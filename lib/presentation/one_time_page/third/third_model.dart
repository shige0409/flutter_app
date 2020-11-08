import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/domain/my_data.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThirdModel extends ChangeNotifier {
  final picker = ImagePicker();
  File imageFile;
  String profile;
  bool showSnipper = false;
  String downloadUrl = "";

  updateProfile(text) {
    this.profile = text;
  }

  Future getImage() async {
    final pickFile = await picker.getImage(source: ImageSource.gallery);
    imageFile = File(pickFile.path);
    notifyListeners();
  }

  Future updateUser(Map<String, dynamic> user) async {
    this.showSnipper = true;
    notifyListeners();

    final userId = MyData.getCurrenUserId();
    // 画像を先にアップロード
    if (imageFile != null) {
      final storage = FirebaseStorage.instance;
      StorageTaskSnapshot snapshot = await storage
          .ref()
          .child("users/$userId")
          .putFile(this.imageFile)
          .onComplete;
      this.downloadUrl = await snapshot.ref.getDownloadURL();
    }

    // ユーザー情報を更新
    SharedPreferences pref = await SharedPreferences.getInstance();
    String documentId = await pref.getString('document_id');
    await MyData.updateUser(documentId, {
      'gender': user['gender'],
      'name': user['name'],
      'city': user['city'],
      'age': user['age'],
      'profile': this.profile,
      'image_url': this.downloadUrl,
    });

    this.showSnipper = false;
    notifyListeners();
  }
}
