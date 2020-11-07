import 'package:cloud_firestore/cloud_firestore.dart';

class MyData {
  MyData(this.name, this.profile, this.gender, this.imageUrl, this.userId,
      this.documentId);
  String name;
  String profile;
  String gender;
  String imageUrl;
  String userId;
  String documentId;

  static Future<MyData> getUser(String userId) async {
    final document = await FirebaseFirestore.instance
        .collection('users')
        .where('u_id', isEqualTo: userId)
        .get();
    final uLists = document.docs
        .map((u) => MyData(u['name'], u['profile'], u['gender'], u['image_url'],
            u['u_id'], u.id))
        .toList();
    return uLists[0];
  }

  static Future<void> updateUser(
      String documentId, Map<String, dynamic> userDict) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(documentId)
        .update(userDict);
  }
}
