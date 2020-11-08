import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/domain/my_data.dart';

class FourthModel extends ChangeNotifier {
  final List<bool> checkList = List.generate(12, (index) => false);
  bool showSnipper = false;

  void updateCheck(int idx) {
    checkList[idx] = !checkList[idx];
    notifyListeners();
  }

  Future<void> createHobby() async {
    showSnipper = true;
    notifyListeners();

    final documents = FirebaseFirestore.instance.collection('hobbies');
    final userId = await MyData.getCurrenUserId();
    await documents.add({'u_id': userId, 'hobby_list': checkList});

    showSnipper = false;
    notifyListeners();
  }
}
