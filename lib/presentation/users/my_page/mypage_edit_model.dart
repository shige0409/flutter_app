import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/domain/my_data.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants.dart';

class MyPageEditModel extends ChangeNotifier {
  final picker = ImagePicker();
  final ageController = TextEditingController();
  final cityController = TextEditingController();
  final nameTextController = TextEditingController();
  final profileTextController = TextEditingController();

  final List<String> ageList =
      List.generate(50, (index) => (index + 16).toString());

  File imageFile;
  MyData user = MyData(imageUrl: kFirstImageUrl);
  bool showSnipper = false;

  Future<void> init() async {
    final userId = await MyData.getCurrenUserId();
    user = await MyData.getUser(userId);
    nameTextController.text = user.name;
    profileTextController.text = user.profile;
    ageController.text = user.profile;
    cityController.text = user.city;
    notifyListeners();
  }

  void getImage() async {
    final pickFile = await picker.getImage(source: ImageSource.gallery);
    imageFile = File(pickFile.path);
    notifyListeners();
  }

  Future<void> updateUser() async {
    this.showSnipper = true;
    notifyListeners();

    final userId = await MyData.getCurrenUserId();
    // 画像を先にアップロード
    if (imageFile != null) {
      final storage = FirebaseStorage.instance;
      StorageTaskSnapshot snapshot = await storage
          .ref()
          .child("users/$userId")
          .putFile(this.imageFile)
          .onComplete;
      user.imageUrl = await snapshot.ref.getDownloadURL();
    }

    // ユーザー情報を更新
    SharedPreferences pref = await SharedPreferences.getInstance();
    String documentId = await pref.getString('document_id');
    await MyData.updateUser(documentId, {
      'name': user.name,
      'city': user.city,
      'age': user.age,
      'profile': user.profile,
      'image_url': user.imageUrl,
    });

    this.showSnipper = false;
    notifyListeners();
  }
}
