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
                        readOnly: !model.isUpdated,
                        controller: model.nameTextController,
                        onChanged: (text) => {model.user.name = text},
                        label: 'name',
                        suffixIconSize: model.isUpdated ? size.width * 0.07 : 0,
                      ),
                      TextFieldUtil(
                        readOnly: !model.isUpdated,
                        controller: model.profileTextController,
                        onChanged: (text) => {model.user.profile = text},
                        label: 'profile',
                        suffixIconSize: model.isUpdated ? size.width * 0.07 : 0,
                      ),
                      ButtonUtil(
                        label: 'Log Out',
                        onPressed: () async {
                          await model.signOut();
                          await Navigator.pushReplacementNamed(
                              context, '/first_page');
                        },
                      )
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
