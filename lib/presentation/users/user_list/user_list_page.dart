import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/domain/user_data.dart';
import 'package:flutter_app/presentation/calls/call_now/call_now_page.dart';
import 'user_list_model.dart';
import 'package:provider/provider.dart';

class UserListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<UserListModel>(
      create: (_) => UserListModel()..fetchUsers(),
      child: Scaffold(
          appBar: AppBar(
            title: Text("ユーザー一覧"),
          ),
          body: Consumer<UserListModel>(builder: (context, model, child) {
            final users = model.users;
            final List<Widget> userCards = [];
            final tmp = [];
            users.asMap().forEach((idx, u) {
              print(idx);
              tmp.add(Container(
                  padding: EdgeInsets.all(10),
                  width: size.width * 0.45,
                  height: size.width * 0.5,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                          backgroundImage: NetworkImage(u.imageUrl),
                          radius: size.width * 0.15),
                      Text(u.name),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("マッチ度"),
                          Text(
                            "98",
                            style: TextStyle(
                                color: kPinkColor, fontWeight: FontWeight.bold),
                          )
                        ],
                      )
                    ],
                  )));
              if (idx % 2 == 0) {
              } else {
                userCards.add(Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    tmp[0],
                    tmp[1],
                  ],
                ));
                tmp.removeAt(1);
                tmp.removeAt(0);
              }
            });
            // final userCards = users
            //     .map((user) => Card(
            //           child: ListTile(
            //             leading: CircleAvatar(
            //               backgroundImage: NetworkImage(user.imageUrl),
            //             ),
            //             title: Text(user.name),
            //             subtitle: Text(user.profile),
            //             trailing: IconButton(
            //               icon: Icon(Icons.call),
            //               onPressed: () async {
            //                 await UserData.updateIsCalling(true);
            //                 await model.addCall(user.userId);
            //                 // 相手が通話できる状態か確認
            //                 final isCalling =
            //                     await UserData.isCallingUser(user.userId);
            //                 // 相手が通話できない時
            //                 if (isCalling) {
            //                   await UserData.updateIsCalling(false);
            //                   await showDialog(
            //                       context: context,
            //                       builder: (_) {
            //                         return AlertDialog(
            //                           title: Text('通話中のようです。'),
            //                           actions: [
            //                             FlatButton(
            //                               child: Text("Ok"),
            //                               onPressed: () async {
            //                                 // チャンネルを閉じる
            //                                 Navigator.pop(context);
            //                               },
            //                             ),
            //                           ],
            //                         );
            //                       });
            //                 } else {
            //                   UserData userData =
            //                       await UserData.getUser(user.userId);
            //                   await Navigator.push(
            //                       context,
            //                       MaterialPageRoute(
            //                           builder: (context) => CallNowPage(
            //                                 callerId: FirebaseAuth
            //                                     .instance.currentUser.uid,
            //                                 calledId: user.userId,
            //                                 userData: userData,
            //                               )));
            //                 }
            //               },
            //             ),
            //           ),
            //         ))
            //     .toList();
            return Column(children: userCards);
          }),
          floatingActionButton: FloatingActionButton(
            heroTag: 'voice record',
            child: Icon(Icons.mic),
            onPressed: () {},
          )),
    );
  }
}
