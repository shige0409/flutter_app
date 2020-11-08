import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/home/home_page.dart';
import 'package:flutter_app/presentation/one_time_page/introduce/introduce_page.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitRootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initialize(),
      builder: (context, snapshot) {
        // アカウントを作成したことがないとき
        if (snapshot.hasError) {
          return IntroducePage();
        }
        // すでにアカウント作成済みの場合
        if (snapshot.connectionState == ConnectionState.done) {
          return HomePage();
        }
        // ローディング画面
        return ModalProgressHUD(
          inAsyncCall: true,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset('assets/icons/AppIcon.png'),
          ),
        );
      },
    );
  }

  Future<String> initialize() async {
    final pref = await SharedPreferences.getInstance();
    if (pref.getString('u_id') == null) {
      throw Error();
    }
    print(pref.getString('u_id'));
    return pref.getString('u_id');
  }
}
