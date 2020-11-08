import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/presentation/common/button_util.dart';
import 'package:flutter_app/presentation/one_time_page/fourth/fourth_model.dart';
import 'package:flutter_app/presentation/one_time_page/second/second_model.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class FourthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: ChangeNotifierProvider<FourthModel>(
        create: (_) => FourthModel(),
        child: Consumer<FourthModel>(builder: (context, model, child) {
          return ModalProgressHUD(
            inAsyncCall: model.showSnipper,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(height: 50),
                  const Text(
                    "興味ある？",
                    style: TextStyle(color: kPrimaryColor, fontSize: 20),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      HobbyCard(
                          emoji: "⚽",
                          text: "スポーツ",
                          isCheck: model.checkList[0],
                          onTap: () => model.updateCheck(0)),
                      HobbyCard(
                          emoji: "🎮",
                          text: "ゲーム",
                          isCheck: model.checkList[1],
                          onTap: () => model.updateCheck(1)),
                      HobbyCard(
                          emoji: "🏩",
                          text: "恋愛",
                          isCheck: model.checkList[2],
                          onTap: () => model.updateCheck(2)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      HobbyCard(
                          emoji: "📺",
                          text: "動画",
                          isCheck: model.checkList[3],
                          onTap: () => model.updateCheck(3)),
                      HobbyCard(
                          emoji: "💻",
                          text: "PC・IT",
                          isCheck: model.checkList[4],
                          onTap: () => model.updateCheck(4)),
                      HobbyCard(
                          emoji: "🎶",
                          text: "歌",
                          isCheck: model.checkList[5],
                          onTap: () => model.updateCheck(5)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      HobbyCard(
                          emoji: "🍕",
                          text: "グルメ",
                          isCheck: model.checkList[6],
                          onTap: () => model.updateCheck(6)),
                      HobbyCard(
                          emoji: "📖",
                          text: "漫画",
                          isCheck: model.checkList[7],
                          onTap: () => model.updateCheck(7)),
                      HobbyCard(
                          emoji: "🚊",
                          text: "旅行",
                          isCheck: model.checkList[8],
                          onTap: () => model.updateCheck(8)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      HobbyCard(
                          emoji: "📷",
                          text: "写真",
                          isCheck: model.checkList[9],
                          onTap: () => model.updateCheck(9)),
                      HobbyCard(
                          emoji: "🛒",
                          text: "ショッピング",
                          isCheck: model.checkList[10],
                          onTap: () => model.updateCheck(10)),
                      HobbyCard(
                          emoji: "🎨",
                          text: "デザイン",
                          isCheck: model.checkList[11],
                          onTap: () => model.updateCheck(11)),
                    ],
                  ),
                  ButtonUtil(
                      label: '登録',
                      onPressed: () async {
                        await model.createHobby();
                        await Navigator.pushReplacementNamed(context, '/home');
                      }),
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
              ),
            ),
          );
        }),
      ),
    );
  }
}

class HobbyCard extends StatelessWidget {
  const HobbyCard({
    Key key,
    @required this.emoji,
    @required this.text,
    @required this.isCheck,
    @required this.onTap,
  }) : super(key: key);

  final String emoji;
  final String text;
  final bool isCheck;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size.width * 0.3,
        height: size.width * 0.3,
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: isCheck ? kGrayColor : Colors.white,
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
      ),
    );
  }
}
