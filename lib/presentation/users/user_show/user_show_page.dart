import 'package:flutter/material.dart';
import 'package:flutter_app/domain/my_data.dart';
import 'package:flutter_app/domain/user_data.dart';
import 'package:flutter_app/presentation/calls/call_now/call_now_page.dart';

class UserShowPage extends StatelessWidget {
  final UserData user;
  const UserShowPage({this.user});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
        actions: [
          IconButton(icon: Icon(Icons.chat), onPressed: null),
          IconButton(
            icon: Icon(Icons.call),
            onPressed: () async {
              await UserData.updateIsCalling(true);
              // await model.addCall(user.userId);
              final isCalling = await UserData.isCallingUser(user.userId);
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
                UserData userData = await UserData.getUser(user.userId);
                final userId = await MyData.getCurrenUserId();
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CallNowPage(
                              callerId: userId,
                              calledId: user.userId,
                              userData: userData,
                            )));
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Hero(
                tag: user.imageUrl,
                child: CircleAvatar(
                  radius: size.width * 0.2,
                  backgroundImage: NetworkImage(user.imageUrl),
                ),
              ),
              Text(user.name),
              Text(
                "${user.city} ・ ${user.age}歳",
                style: TextStyle(color: Colors.grey),
              ),
              Text(user.profile),
              Container(
                child: Image.asset("assets/icons/AppIcon.png"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
