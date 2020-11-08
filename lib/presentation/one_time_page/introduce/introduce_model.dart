import 'package:flutter/material.dart';
import 'package:flutter_app/domain/my_data.dart';

class IntroduceModel extends ChangeNotifier {
  bool showSnipper = false;
  int pageIndex = 0;
  int nextCount = 0;
  List<bool> isNowPage = [true, false, false, false];
  final imageList = [
    Image.asset("assets/icons/AppIcon.png"),
    Image.asset("assets/icons/AppIcon.png"),
    Image.asset("assets/icons/AppIcon.png"),
    Image.asset("assets/icons/AppIcon.png"),
  ];

  void nextPage() {
    pageIndex++;
    nextCount++;
    isNowPage = [false, false, false, false];
    isNowPage[nextCount] = true;
    notifyListeners();
  }

  Future<void> createUser() async {
    showSnipper = true;
    notifyListeners();
    await MyData.createUser();
    showSnipper = false;
    notifyListeners();
  }
}
