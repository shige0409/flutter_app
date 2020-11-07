import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/presentation/common/button_util.dart';
import 'package:flutter_app/presentation/one_time_page/second/second_model.dart';
import 'package:provider/provider.dart';

class ThirdPage extends StatelessWidget {
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
                const Text(
                  "興味ある？",
                  style: TextStyle(color: kPrimaryColor, fontSize: 20),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    HobbyCard(size: size, emoji: "⚽", text: "スポーツ"),
                    HobbyCard(size: size, emoji: "🎮", text: "ゲーム"),
                    HobbyCard(size: size, emoji: "🎶", text: "歌"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    HobbyCard(size: size, emoji: "📺", text: "動画"),
                    HobbyCard(size: size, emoji: "💻", text: "PC"),
                    HobbyCard(size: size, emoji: "🎶", text: "歌"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    HobbyCard(size: size, emoji: "⚽", text: "スポーツ"),
                    HobbyCard(size: size, emoji: "🎮", text: "ゲーム"),
                    HobbyCard(size: size, emoji: "🎶", text: "歌"),
                  ],
                ),
                ButtonUtil(
                    label: '登録',
                    onPressed: () {
                      print(model.gender);
                      print(model.name);
                      print(model.age);
                    })
              ]);
        }),
      ),
    );
  }
}

class HobbyCard extends StatelessWidget {
  const HobbyCard({
    Key key,
    @required this.size,
    @required this.emoji,
    @required this.text,
  }) : super(key: key);

  final Size size;
  final String emoji;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.3,
      height: size.width * 0.3,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(emoji, style: TextStyle(fontSize: 40)),
          Text(
            text,
            style: TextStyle(color: kBlackColor, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
