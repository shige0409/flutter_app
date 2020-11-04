import 'package:cloud_firestore/cloud_firestore.dart';

class PostData {
  PostData(this.postText, this.uId, this.createAt);
  String postText;
  String uId;
  Timestamp createAt;
}
