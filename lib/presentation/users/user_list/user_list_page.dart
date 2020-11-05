import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/domain/user_data.dart';
import 'package:flutter_app/presentation/calls/call_now/call_now_page.dart';
import 'user_list_model.dart';
import 'package:provider/provider.dart';

class UserListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserListModel>(
      create: (_) => UserListModel()..fetchUsers(),
      child: Scaffold(
          appBar: AppBar(
            title: Text("ユーザー一覧"),
          ),
          body: Consumer<UserListModel>(builder: (context, model, child) {
            final users = model.users;
            final userCards = users
                .map((user) => Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(user.imageUrl),
                        ),
                        title: Text(user.name),
                        subtitle: Text(user.profile),
                        trailing: IconButton(
                          icon: Icon(Icons.call),
                          onPressed: () async {
                            await UserData.updateIsCalling(true);
                            await model.addCall(user.userId);
                            // 相手が通話できる状態か確認
                            final isCalling =
                                await UserData.isCallingUser(user.userId);
                            // 相手が通話できない時
                            if (isCalling) {
                              await UserData.updateIsCalling(false);
                              await showDialog(
                                  context: context,
                                  builder: (_) {
                                    return AlertDialog(
                                      title: Text('通話中のようです。'),
                                      actions: [
                                        FlatButton(
                                          child: Text("Ok"),
                                          onPressed: () async {
                                            // チャンネルを閉じる
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    );
                                  });
                            } else {
                              UserData userData =
                                  await UserData.getUser(user.userId);
                              await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CallNowPage(
                                            callerId: FirebaseAuth
                                                .instance.currentUser.uid,
                                            calledId: user.userId,
                                            userData: userData,
                                          )));
                            }
                          },
                        ),
                      ),
                    ))
                .toList();
            return ListView(children: userCards);
          }),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.mic),
            onPressed: () {},
          )),
    );
  }
}
