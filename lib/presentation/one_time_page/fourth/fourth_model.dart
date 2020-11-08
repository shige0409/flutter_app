import 'package:flutter/material.dart';

class FourthModel extends ChangeNotifier {
  String gender;
  String name;
  String age;

  final List<String> ageList =
      List.generate(50, (index) => (index + 16).toString());

  final ageController = TextEditingController();

  void updateGender(dynamic val) {
    this.gender = val;
  }

  void updateName(text) {
    this.name = text;
  }

  void updateAge(int idx) {
    this.age = ageList[idx];
    this.ageController.value = TextEditingValue(text: this.age);
  }
}
