import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/domain/user_data.dart';
import 'package:flutter_app/presentation/common/button_util.dart';
import 'package:flutter_app/presentation/common/textfield_util.dart';
import 'package:flutter_app/presentation/one_time_page/second/second_model.dart';
import 'package:flutter_app/presentation/one_time_page/third/third_page.dart';
import 'package:provider/provider.dart';

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: ChangeNotifierProvider<SecondModel>(
        create: (_) => SecondModel(),
        child: Consumer<SecondModel>(builder: (context, model, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "プロフィール",
                style: TextStyle(color: kPrimaryColor, fontSize: 20),
              ),
              Container(
                margin: EdgeInsets.all(10),
                width: size.width * 0.9,
                padding: EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 20,
                ),
                child: DropdownButtonFormField(
                    decoration: InputDecoration(labelText: "性別"),
                    items: [
                      DropdownMenuItem(child: Text("男性"), value: "man"),
                      DropdownMenuItem(child: Text('女性'), value: "woman")
                    ],
                    onChanged: (val) {
                      model.updateGender(val);
                    }),
              ),
              TextFieldUtil(
                child: TextField(
                  onChanged: (text) => model.updateName(text),
                  controller: null,
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
                          children: kCityList.map((e) => Text(e)).toList(),
                          onSelectedItemChanged: (int index) {
                            model.updateCity(index);
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
                          children: model.ageList.map((e) => Text(e)).toList(),
                          onSelectedItemChanged: (int index) {
                            model.updateAge(index);
                          },
                        );
                      },
                    );
                  },
                ),
              ),
              ButtonUtil(
                label: '次へ',
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ThirdPage(
                                user: UserData(
                                  gender: model.gender,
                                  name: model.name,
                                  city: model.city,
                                  age: model.age,
                                ),
                              )));
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                    child: Text(
                      "プロフィールの登録をスキップ",
                      style: TextStyle(color: Colors.redAccent),
                    ),
                  )
                ],
              ),
            ],
          );
        }),
      ),
    );
  }
}
