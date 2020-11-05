import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/domain/user_data.dart';
import 'package:flutter_app/presentation/calls/call_list/call_list_page.dart';
import 'package:flutter_app/presentation/calls/call_now/call_now_page.dart';
import 'package:flutter_app/presentation/users/my_page/my_page.dart';
import 'package:flutter_app/presentation/posts/post_list/post_list_page.dart';
import 'package:flutter_app/presentation/users/user_list/user_list_page.dart';

class HomeModel extends ChangeNotifier {
  int index = 0;
  bool isInit = false;
  List<Widget> pageList = [];
  void changePage(int idx) {
    this.index = idx;
    notifyListeners();
  }

  void initPages(BuildContext context) {
    print("create Home");
    this.pageList = [
      PostListPage(),
      UserListPage(),
      CallListPage(),
      MyPage(),
    ];
    final snapshots = FirebaseFirestore.instance
        .collection('calls')
        .where('called_user_id',
            isEqualTo: FirebaseAuth.instance.currentUser.uid)
        .orderBy('created_at', descending: true)
        .limit(2)
        .snapshots();
    // 更新されるたび呼ばれる
    snapshots.listen((snapshot) async {
      final isCalling =
          await UserData.isCallingUser(FirebaseAuth.instance.currentUser.uid);
      // すでに画面を開いている時、もしくは自分が通話中じゃない時
      if (this.isInit && isCalling == false) {
        final UserData userData =
            await UserData.getUser(snapshot.docs.first['caller_user_id']);
        showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text(userData.name),
              content: Image.network(userData.imageUrl),
              actions: <Widget>[
                // ボタン領域
                FlatButton(
                  child: Text("Cancel"),
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                  child: Text("OK"),
                  onPressed: () async {
                    await UserData.updateIsCalling(true);
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CallNowPage(
                                  callerId:
                                      FirebaseAuth.instance.currentUser.uid,
                                  calledId: userData.userId,
                                  userData: userData,
                                )));
                  },
                ),
              ],
            );
          },
        );
      } else {
        this.isInit = true;
      }
    });
  }
}
