import 'package:firebase_auth/firebase_auth.dart';

class UserData {
  UserData(this.name, this.profile, this.gender, this.imageUrl, this.documtnId);
  String name;
  String profile;
  String gender;
  String imageUrl;
  String documtnId;
}
