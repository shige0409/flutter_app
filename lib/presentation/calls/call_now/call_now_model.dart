import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';
import 'package:permission_handler/permission_handler.dart';

class CallNowModel extends ChangeNotifier {
  final _users = <int>[];
  final infoStrings = <String>[];
  bool muted = false;

  Future<void> initCall(String callId) async {
    await PermissionHandler().requestPermissions([PermissionGroup.microphone]);
    await AgoraRtcEngine.create(kAPP_ID);
    await AgoraRtcEngine.enableAudio();
    await AgoraRtcEngine.enableWebSdkInteroperability(true);
    await AgoraRtcEngine.setParameters(
        '''{\"che.video.lowBitRateStreamParameter\":{\"width\":320,\"height\":180,\"frameRate\":15,\"bitRate\":140}}''');
    await AgoraRtcEngine.joinChannel(kTOKEN, callId, null, 0);

    AgoraRtcEngine.onError = (dynamic code) {
      this.infoStrings.add('エラーコード: $code');
      notifyListeners();
    };
    AgoraRtcEngine.onJoinChannelSuccess =
        (String channel, int uid, int elapsed) {
      this.infoStrings.add('チャンネル: $channel, ユーザーID: $uid');
      notifyListeners();
    };
    AgoraRtcEngine.onLeaveChannel = () {
      this.infoStrings.add('退出');
      notifyListeners();
    };
    AgoraRtcEngine.onUserJoined = (int uid, int elapsed) {
      this.infoStrings.add('ユーザーが参加しました: $uid');
      notifyListeners();
    };
    AgoraRtcEngine.onUserOffline = (int uid, int reason) {
      this.infoStrings.add('ユーザーが退出しました: $uid');
      notifyListeners();
    };
  }

  @override
  void dispose() {
    _users.clear();
    AgoraRtcEngine.leaveChannel();
    AgoraRtcEngine.destroy();
    super.dispose();
  }

  void onCallEnd(BuildContext context) {
    Navigator.pop(context);
  }

  void onToggleMute() {
    this.muted = !this.muted;
    notifyListeners();
    AgoraRtcEngine.muteLocalAudioStream(muted);
  }
}
