import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/domain/my_data.dart';
import 'package:flutter_app/domain/user_data.dart';
import 'package:flutter_app/presentation/calls/call_now/call_now_page.dart';

class ManagerModel extends ChangeNotifier {
  bool isInit = false;

  void realTimeFetchCallData(BuildContext context) async {
    final userId = await MyData.getCurrenUserId();
    final snapshots = FirebaseFirestore.instance
        .collection('calls')
        .where('called_user_id', isEqualTo: userId)
        .orderBy('created_at', descending: true)
        .limit(2)
        .snapshots();
    snapshots.listen((snapshot) async {
      final userId = await MyData.getCurrenUserId();
      final isCalling = await UserData.isCallingUser(userId);
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
                    final userId = await MyData.getCurrenUserId();
                    Navigator.pop(context);
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CallNowPage(
                                  callerId: userId,
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
