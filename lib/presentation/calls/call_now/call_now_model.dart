import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/domain/user_data.dart';
import 'package:permission_handler/permission_handler.dart';

class CallNowModel extends ChangeNotifier {
  final _users = <int>[];
  String callingText = "Calling...";
  bool muted = false;
  bool yourMuted = false;
  UserData user = UserData(name: 'name', userId: 'id');

  Future<void> initCall(String callerId, String calledId, UserData userData,
      BuildContext context) async {
    await PermissionHandler().requestPermissions([PermissionGroup.microphone]);
    await AgoraRtcEngine.create(kAPP_ID);
    await AgoraRtcEngine.enableAudio();
    await AgoraRtcEngine.enableWebSdkInteroperability(true);
    // await AgoraRtcEngine.setParameters(
    //     '''{\"che.video.lowBitRateStreamParameter\":{\"width\":320,\"height\":180,\"frameRate\":15,\"bitRate\":140}}''');
    this.user = userData;

    await AgoraRtcEngine.joinChannel(
        kTOKEN, (callerId.hashCode + calledId.hashCode).toString(), null, 0);
    await notifyListeners();

    AgoraRtcEngine.onError = (dynamic code) {
      print('エラーコード: $code');
    };
    AgoraRtcEngine.onJoinChannelSuccess =
        (String channel, int uid, int elapsed) {
      print('チャンネル: $channel ユーザーID: $uid');
      this._users.add(uid);
    };
    AgoraRtcEngine.onLeaveChannel = () {
      print('退出');
    };
    AgoraRtcEngine.onUserJoined = (int uid, int elapsed) {
      print('ユーザーが参加しました: $uid');
      this._users.add(uid);
      if (this._users.length == 2) {
        this.callingText = "通話中";
      }
      notifyListeners();
    };
    AgoraRtcEngine.onUserOffline = (int uid, int reason) {
      print('ユーザーが退出しました: $uid');
      this._users.remove(uid);
      if (this._users.length == 1) {
        this.callingText = "通話終了";
      }
      notifyListeners();
      onCallEnd(context);
    };
  }

  @override
  void dispose() {
    _users.clear();
    AgoraRtcEngine.leaveChannel();
    AgoraRtcEngine.destroy();
    super.dispose();
  }

  Future<void> onCallEnd(BuildContext context) async {
    await UserData.updateIsCalling(false);
    await Navigator.popUntil(context, ModalRoute.withName('/home'));
  }

  void onToggleMute() {
    this.muted = !this.muted;
    notifyListeners();
    AgoraRtcEngine.muteLocalAudioStream(muted);
  }

  void onToggleYourMute() {
    this.yourMuted = !this.yourMuted;
    notifyListeners();
    AgoraRtcEngine.muteAllRemoteAudioStreams(yourMuted);
  }
}
