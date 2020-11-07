import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/presentation/common/textfield_util.dart';
import 'background.dart';
import 'signin_model.dart';
import 'package:flutter_app/presentation/one_time_page/signup/signup_page.dart';
import 'package:provider/provider.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SigninPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<SigninModel>(
        create: (_) => SigninModel(),
        child: Consumer<SigninModel>(builder: (context, model, child) {
          return ModalProgressHUD(
            inAsyncCall: model.showSpinner,
            child: Background(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    "assets/icons/AppIcon.png",
                    height: size.height * 0.4,
                  ),
                  TextFieldUtil(
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      controller: model.emailTextController,
                      onChanged: (text) => {model.email = text},
                      decoration: InputDecoration(labelText: "メールアドレス"),
                    ),
                  ),
                  TextFieldUtil(
                    child: TextField(
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      controller: model.passwordTextController,
                      onChanged: (text) => {model.password = text},
                      decoration: InputDecoration(labelText: "パスワード"),
                    ),
                  ),
                  Container(
                    //Button
                    margin: EdgeInsets.all(10),
                    width: size.width * 0.8,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        color: kPrimaryColor,
                        child: FlatButton(
                          padding: EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 20,
                          ),
                          onPressed: () async {
                            await model.signin();
                            await Navigator.of(context)
                                .pushReplacementNamed('/home');
                          },
                          child: Text(
                            "ログイン",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "アカウントを持ってないなら",
                        style: TextStyle(
                          color: kPinkColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignupPage()));
                        },
                        child: Text(
                          "登録ページへ",
                          style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        }));
  }
}
