import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/calls/call_list/call_list_page.dart';
import 'package:flutter_app/presentation/users/my_page/my_page.dart';
import 'package:flutter_app/presentation/posts/post_list/post_list_page.dart';
import 'package:flutter_app/presentation/users/user_list/user_list_page.dart';

class HomeModel extends ChangeNotifier {
  int index = 0;
  List<Widget> pageList = [];
  void changePage(int idx) {
    this.index = idx;
    notifyListeners();
  }

  void createPage() {
    print("create Home");
    print(FirebaseAuth.instance.currentUser);
    this.pageList = [
      PostListPage(),
      UserListPage(),
      CallListPage(),
      MyPage(),
    ];
  }
}
