import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';
import 'background.dart';
import 'signin_model.dart';
import 'package:flutter_app/presentation/one_time_page/signup/signup_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SigninPage extends StatelessWidget {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Login",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SvgPicture.asset(
                    "assets/icons/login.svg",
                    height: size.height * 0.3,
                  ),
                  Container(
                    //TextField
                    margin: EdgeInsets.all(10),
                    width: size.width * 0.8,
                    padding: EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration(
                      color: kPrimaryLightColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextField(
                      controller: emailTextController,
                      onChanged: (text) => {model.email = text},
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.person,
                          color: kPrimaryColor,
                        ),
                        hintText: "Your Email",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    //TextField
                    margin: EdgeInsets.all(10),
                    width: size.width * 0.8,
                    padding: EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration(
                      color: kPrimaryLightColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextField(
                      controller: passwordTextController,
                      onChanged: (text) => {model.password = text},
                      obscureText: true,
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.lock,
                            color: kPrimaryColor,
                          ),
                          hintText: "PASSWORD",
                          border: InputBorder.none,
                          suffixIcon: GestureDetector(
                            onTap: () {
                              print("lock");
                            },
                            child: Icon(
                              Icons.visibility,
                              color: kPrimaryColor,
                            ),
                          )),
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
                            "LOGIN",
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
                        "Don't have an Account ? ",
                        style: TextStyle(
                          color: kPrimaryLightColor,
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
                          "Sign Up",
                          style: TextStyle(
                            color: kPrimaryColor,
                          ),
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
