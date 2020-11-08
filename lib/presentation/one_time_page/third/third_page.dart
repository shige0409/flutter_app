import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/domain/user_data.dart';
import 'package:flutter_app/presentation/common/button_util.dart';
import 'package:flutter_app/presentation/common/textfield_util.dart';
import 'package:flutter_app/presentation/one_time_page/third/third_model.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class ThirdPage extends StatelessWidget {
  final UserData user;
  const ThirdPage({this.user});
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: ChangeNotifierProvider<ThirdModel>(
        create: (_) => ThirdModel(),
        child: Consumer<ThirdModel>(builder: (context, model, child) {
          return ModalProgressHUD(
            inAsyncCall: model.showSnipper,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    "プロフィール",
                    style: TextStyle(color: kPrimaryColor, fontSize: 20),
                  ),
                  InkWell(
                    child: Container(
                      width: size.width * 0.5,
                      height: size.width * 0.5,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: model.imageFile != null
                          ? Image.file(model.imageFile)
                          : Container(
                              child: Icon(Icons.add),
                            ),
                    ),
                    onTap: () async {
                      model.getImage();
                    },
                  ),
                  TextFieldUtil(
                    child: TextField(
                      maxLines: 5,
                      onChanged: (text) => model.updateProfile(text),
                      controller: null,
                      decoration: InputDecoration(
                        labelText: "プロフィール",
                      ),
                    ),
                  ),
                  ButtonUtil(
                      label: '登録',
                      onPressed: () async {
                        // ユーザー情報をアップデートしてHomeページに移動
                        await model.updateUser({
                          'gender': user.gender,
                          'name': user.name,
                          'profile': model.profile,
                          'image_url': model.downloadUrl,
                          'city': user.city,
                          'age': user.age,
                        });
                        await Navigator.pushReplacementNamed(
                            context, '/fourth');
                      })
                ]),
          );
        }),
      ),
    );
  }
}
