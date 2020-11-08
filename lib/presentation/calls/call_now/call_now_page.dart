import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/domain/user_data.dart';
import 'package:flutter_app/presentation/calls/call_now/call_now_model.dart';
import 'package:provider/provider.dart';

class CallNowPage extends StatelessWidget {
  final String callerId;
  final String calledId;
  final UserData userData;
  const CallNowPage({Key key, this.callerId, this.calledId, this.userData})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<CallNowModel>(
      create: (_) => CallNowModel()
        ..initCall(this.callerId, this.calledId, this.userData, context),
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: Consumer<CallNowModel>(builder: (context, model, child) {
          return SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  model.user.name,
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      .copyWith(color: Colors.white),
                ),
                Text(
                  model.callingText,
                  style: TextStyle(color: Colors.white60),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(model.user.imageUrl),
                    radius: size.width * 0.25,
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  padding: const EdgeInsets.symmetric(vertical: 48),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      //ミュートボタン
                      RawMaterialButton(
                        onPressed: () {
                          model.onToggleMute();
                        },
                        child: Icon(
                          model.muted ? Icons.mic_off : Icons.mic,
                          color: model.muted ? Colors.white : kRedColor,
                          size: 20.0,
                        ),
                        shape: CircleBorder(),
                        elevation: 2.0,
                        fillColor: model.muted ? kRedColor : Colors.white,
                        padding: const EdgeInsets.all(12.0),
                      ),
                      //通話終了ボタン
                      RawMaterialButton(
                        onPressed: () async {
                          await model.onCallEnd(context);
                          await Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.call_end,
                          color: Colors.white,
                          size: 35.0,
                        ),
                        shape: CircleBorder(),
                        elevation: 2.0,
                        fillColor: kRedColor,
                        padding: const EdgeInsets.all(15.0),
                      ),
                      RawMaterialButton(
                        onPressed: () {
                          model.onToggleYourMute();
                        },
                        child: Icon(
                          Icons.volume_mute,
                          color: model.yourMuted ? Colors.white : kRedColor,
                          size: 20.0,
                        ),
                        shape: CircleBorder(),
                        elevation: 2.0,
                        fillColor: model.yourMuted ? kRedColor : Colors.white,
                        padding: EdgeInsets.all(12.0),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
