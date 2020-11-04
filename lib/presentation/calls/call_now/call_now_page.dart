import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/calls/call_now/call_now_model.dart';
import 'package:provider/provider.dart';

class CallNowPage extends StatelessWidget {
  final String callId;
  const CallNowPage({Key key, this.callId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CallNowModel>(
      create: (_) => CallNowModel()..initCall(this.callId),
      child: Consumer<CallNowModel>(builder: (context, model, child) {
        return Stack(
          children: [
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
                      color: model.muted ? Colors.white : Colors.blueAccent,
                      size: 20.0,
                    ),
                    shape: CircleBorder(),
                    elevation: 2.0,
                    fillColor: model.muted ? Colors.blueAccent : Colors.white,
                    padding: const EdgeInsets.all(12.0),
                  ),

                  //通話終了ボタン
                  RawMaterialButton(
                    onPressed: () => model.onCallEnd(context),
                    child: Icon(
                      Icons.call_end,
                      color: Colors.white,
                      size: 35.0,
                    ),
                    shape: CircleBorder(),
                    elevation: 2.0,
                    fillColor: Colors.redAccent,
                    padding: const EdgeInsets.all(15.0),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 120),
              child: ListView.builder(
                reverse: true,
                itemCount: model.infoStrings.length,
                itemBuilder: (BuildContext context, int index) {
                  if (model.infoStrings.isEmpty) {
                    return null;
                  }
                  return Text(
                    model.infoStrings[index],
                    style: TextStyle(
                        fontSize: 10,
                        color: Colors.black,
                        backgroundColor: Color.fromARGB(255, 255, 255, 255)),
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
