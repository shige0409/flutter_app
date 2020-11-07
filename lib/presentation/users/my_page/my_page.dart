import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/common/button_util.dart';
import 'package:flutter_app/presentation/common/textfield_util.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
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
          title: Text("My Page"),
        ),
        body: Consumer<MyPageModel>(builder: (context, model, child) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: ModalProgressHUD(
              inAsyncCall: model.showSnipper,
              child: SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      CircleAvatar(
                        child: InkWell(
                          child: model.isUpdated
                              ? Icon(
                                  Icons.add,
                                  size: size.width * 0.4,
                                  color: Colors.white.withOpacity(0.4),
                                )
                              : Icon(Icons.add, size: 0),
                          onTap: () async {
                            model.getImage();
                          },
                        ),
                        radius: size.width * 0.25,
                        backgroundImage: NetworkImage(model.user.imageUrl),
                      ),
                      model.isUpdated
                          ? ButtonUtil(
                              label: "保存する",
                              onPressed: () async {
                                model.edited();
                                await model.updateUser();
                                model.getUser();
                              },
                            )
                          : ButtonUtil(
                              label: "編集する",
                              onPressed: () {
                                model.editing();
                              }),
                      TextFieldUtil(
                        child: TextField(
                          readOnly: !model.isUpdated,
                          controller: model.nameTextController,
                          onChanged: (text) => {model.user.name = text},
                          decoration: InputDecoration(labelText: 'name'),
                        ),
                      ),
                      TextFieldUtil(
                        child: TextField(
                          maxLength: 3,
                          readOnly: !model.isUpdated,
                          controller: model.profileTextController,
                          onChanged: (text) => {model.user.profile = text},
                          decoration: InputDecoration(labelText: 'name'),
                        ),
                      ),
                      FlatButton(
                        textColor: Colors.white,
                        onPressed: () async {
                          await model.signOut();
                          await Navigator.pushReplacementNamed(
                              context, '/init_page');
                        },
                        child: Text("ログアウト"),
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
