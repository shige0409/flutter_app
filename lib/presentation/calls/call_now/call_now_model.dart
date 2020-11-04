import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/domain/user_data.dart';
import 'package:permission_handler/permission_handler.dart';

class CallNowModel extends ChangeNotifier {
  final _users = <int>[];
  final infoStrings = <String>[];
  bool muted = false;
  bool yourMuted = false;
  UserData user = UserData('name', 'profile', 'gender', 'image_url', 'user_id');

  Future<void> initCall(String callerId, String calledId) async {
    await PermissionHandler().requestPermissions([PermissionGroup.microphone]);
    await AgoraRtcEngine.create(kAPP_ID);
    await AgoraRtcEngine.enableAudio();
    await AgoraRtcEngine.enableWebSdkInteroperability(true);
    // await AgoraRtcEngine.setParameters(
    //     '''{\"che.video.lowBitRateStreamParameter\":{\"width\":320,\"height\":180,\"frameRate\":15,\"bitRate\":140}}''');
    final document = await FirebaseFirestore.instance
        .collection('users')
        .where('u_id', isEqualTo: calledId)
        .get();
    this.user = document.docs
        .map((u) => UserData(u['name'], u['profile'], u['gender'],
            u['mypage_image_url'], u['u_id']))
        .toList()[0];
    await AgoraRtcEngine.joinChannel(
        kTOKEN, (callerId.hashCode + calledId.hashCode).toString(), null, 0);
    await notifyListeners();

    AgoraRtcEngine.onError = (dynamic code) {
      this.infoStrings.add('エラーコード: $code');
      notifyListeners();
    };
    AgoraRtcEngine.onJoinChannelSuccess =
        (String channel, int uid, int elapsed) {
      this.infoStrings.add('チャンネル: ${channel.hashCode} ユーザーID: $uid');
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

  void onToggleYourMute() {
    this.yourMuted = !this.yourMuted;
    notifyListeners();
    AgoraRtcEngine.muteAllRemoteAudioStreams(yourMuted);
  }
}
