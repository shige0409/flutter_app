import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/presentation/common/button_util.dart';
import 'package:flutter_app/presentation/one_time_page/introduce/introduce_model.dart';
import 'package:provider/provider.dart';

class IntroducePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<IntroduceModel>(
        create: (_) => IntroduceModel(),
        child: Consumer<IntroduceModel>(builder: (context, model, child) {
          return Column(
            children: [
              Container(
                child: model.imageList[model.pageIndex],
                width: double.infinity,
                height: 400,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: model.isNowPage.map((b) {
                  return Builder(builder: (BuildContext context) {
                    return AnimatedContainer(
                      duration: Duration(milliseconds: 100),
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      height: b ? 10 : 8,
                      width: b ? 10 : 8,
                      decoration: BoxDecoration(
                        color: b ? kBlueColor : kGrayColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    );
                  });
                }).toList(),
              ),
              SizedBox(height: 50),
              model.nextCount != 3
                  ? ButtonUtil(label: "つぎへ", onPressed: () => model.nextPage())
                  : ButtonUtil(
                      label: "はじめる",
                      onPressed: () async {
                        // DBにユーザーを作成して、端末にuserIdに保存する
                        await model.createUser();
                        await Navigator.pushReplacementNamed(
                            context, '/second');
                      }),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/signin');
                    },
                    child: Text(
                      "すでにアカウントを持っている",
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
