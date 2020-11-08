import 'package:flutter/material.dart';

import '../../../constants.dart';

class SecondModel extends ChangeNotifier {
  String gender;
  String name;
  String age;
  String city;

  final ageController = TextEditingController();
  final cityController = TextEditingController();

  final List<String> ageList =
      List.generate(50, (index) => (index + 16).toString());

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

  void updateCity(int idx) {
    this.city = kCityList[idx];
    this.cityController.value = TextEditingValue(text: this.city);
  }
}
