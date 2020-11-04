import 'package:firebase_auth/firebase_auth.dart';

class MyData {
  MyData(this.name, this.profile, this.gender, this.imageUrl, this.userId,
      this.documentId);
  String name;
  String profile;
  String gender;
  String imageUrl;
  String userId;
  String documentId;
}
