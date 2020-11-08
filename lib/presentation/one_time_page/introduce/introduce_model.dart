import 'package:flutter/material.dart';
import 'package:flutter_app/domain/my_data.dart';

class IntroduceModel extends ChangeNotifier {
  bool showSnipper = false;
  int pageIndex = 0;
  int nextCount = 0;
  List<bool> isNowPage = [true, false, false, false];
  final imageList = [
    Image.asset("assets/images/intro1.jpg"),
    Image.asset("assets/images/intro2.jpg"),
    Image.asset("assets/images/intro3.jpg"),
    Image.asset("assets/images/intro4.jpg"),
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
