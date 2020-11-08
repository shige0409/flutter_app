import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/common/button_util.dart';
import 'package:flutter_app/presentation/common/textfield_util.dart';
import 'package:flutter_app/presentation/users/my_page/mypage_edit_model.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class MyPageEditPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(),
      body: ChangeNotifierProvider<MyPageEditModel>(
        create: (_) => MyPageEditModel()..init(),
        child: Consumer<MyPageEditModel>(builder: (context, model, child) {
          return ModalProgressHUD(
            inAsyncCall: model.showSnipper,
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
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
                            : CircleAvatar(
                                radius: size.width * 0.2,
                                backgroundImage:
                                    NetworkImage(model.user.imageUrl),
                              ),
                      ),
                      onTap: () async {
                        model.getImage();
                      },
                    ),
                    TextFieldUtil(
                      child: TextField(
                        onChanged: (text) => model.user.name = text,
                        controller: model.nameTextController,
                        decoration: InputDecoration(
                          labelText: "名前",
                        ),
                      ),
                    ),
                    TextFieldUtil(
                      child: TextField(
                        readOnly: true,
                        controller: model.cityController,
                        decoration: InputDecoration(labelText: "住み"),
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return CupertinoPicker(
                                itemExtent: 30,
                                children:
                                    kCityList.map((e) => Text(e)).toList(),
                                onSelectedItemChanged: (int index) {
                                  model.user.city = kCityList[index];
                                  model.cityController.text = model.user.city;
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                    TextFieldUtil(
                      child: TextField(
                        readOnly: true,
                        controller: model.ageController,
                        decoration: InputDecoration(labelText: "年齢"),
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return CupertinoPicker(
                                itemExtent: 30,
                                children:
                                    model.ageList.map((e) => Text(e)).toList(),
                                onSelectedItemChanged: (int index) {
                                  model.user.age = model.ageList[index];
                                  model.ageController.text = model.user.age;
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                    TextFieldUtil(
                      child: TextField(
                        maxLines: 5,
                        onChanged: (text) => model.user.profile = text,
                        controller: model.profileTextController,
                        decoration: InputDecoration(
                          labelText: "プロフィール",
                        ),
                      ),
                    ),
                    ButtonUtil(
                      label: '保存する',
                      onPressed: () async {
                        await model.updateUser();
                        await Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
