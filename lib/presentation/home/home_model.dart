import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/calls/call_list/call_list_page.dart';
import 'package:flutter_app/presentation/home/manager_page.dart';
import 'package:flutter_app/presentation/users/my_page/my_page.dart';
import 'package:flutter_app/presentation/posts/post_list/post_list_page.dart';
import 'package:flutter_app/presentation/users/user_list/user_list_page.dart';

class HomeModel extends ChangeNotifier {
  int index = 0;
  final List<Widget> pageList = [
    PostListPage(),
    UserListPage(),
    CallListPage(),
    MyPage(),
    ManagerPage(),
    // リアルタイムの通知を管理するページ
  ];
  void changePage(int idx) {
    if (this.index != idx) {
      this.index = idx;
      notifyListeners();
    } else {
      print("更新しない");
    }
  }
}
