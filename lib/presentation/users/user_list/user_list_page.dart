import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/calls/call_now/call_now_page.dart';
import 'package:flutter_app/presentation/posts/add_post/add_post_page.dart';
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
                            await model.addCall(user.userId);
                            await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CallNowPage(
                                          callerId: FirebaseAuth
                                              .instance.currentUser.uid,
                                          calledId: user.userId,
                                        )));
                          },
                        ),
                      ),
                    ))
                .toList();
            return ListView(children: userCards);
          }),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddPostPage(),
                  fullscreenDialog: true,
                ),
              );
            },
          )),
    );
  }
}
