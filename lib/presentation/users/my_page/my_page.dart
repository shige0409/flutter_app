import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/common/button_util.dart';
import 'package:provider/provider.dart';

import 'my_page_model.dart';

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<MyPageModel>(
      create: (_) => MyPageModel()..getUser(),
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          leading: Icon(Icons.notifications),
          title: Text("マイページ"),
          actions: [IconButton(icon: Icon(Icons.settings), onPressed: null)],
        ),
        body: Consumer<MyPageModel>(builder: (context, model, child) {
          return SingleChildScrollView(
            child: Container(
              width: double.infinity,
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  CircleAvatar(
                    radius: size.width * 0.2,
                    backgroundImage: NetworkImage(model.user.imageUrl),
                  ),
                  Text(model.user.name),
                  Text(
                    "${model.user.city} ・ ${model.user.age}歳",
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(model.user.profile),
                  ButtonUtil(
                    label: "編集する",
                    onPressed: () {
                      // to edit page
                    },
                  ),
                  Container(
                    child: Image.asset("assets/icons/AppIcon.png"),
                  ),
                  FlatButton(
                    textColor: Colors.white,
                    child: Text("ログアウト"),
                    color: Colors.red,
                    onPressed: () async {
                      await model.signOut();
                      await Navigator.pushReplacementNamed(context, '/init');
                    },
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
