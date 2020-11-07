import 'package:flutter/material.dart';

class SecondModel extends ChangeNotifier {
  String gender;
  String name;
  String age;
  String city;

  final ageController = TextEditingController();
  final cityController = TextEditingController();

  final List<String> ageList =
      List.generate(50, (index) => (index + 16).toString());

  final List<String> cityList = [
    "秘密",
    "東京都",
    "大阪府",
    "福岡県",
    "愛知県",
    "北海道",
    "青森県",
    "岩手県",
    "宮城県",
    "秋田県",
    "山形県",
    "福島県",
    "茨城県",
    "栃木県",
    "群馬県",
    "埼玉県",
    "千葉県",
    "神奈川県",
    "新潟県",
    "富山県",
    "石川県",
    "福井県",
    "山梨県",
    "長野県",
    "岐阜県",
    "静岡県",
    "三重県",
    "滋賀県",
    "京都府",
    "兵庫県",
    "奈良県",
    "和歌山県",
    "鳥取県",
    "島根県",
    "岡山県",
    "広島県",
    "山口県",
    "徳島県",
    "香川県",
    "愛媛県",
    "高知県",
    "佐賀県",
    "長崎県",
    "熊本県",
    "大分県",
    "宮崎県",
    "鹿児島県",
    "沖縄県"
  ];

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
    this.city = cityList[idx];
    this.cityController.value = TextEditingValue(text: this.city);
  }
}
