import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/posts/add_post/add_post_model.dart';
import 'package:flutter_app/presentation/home/home_page.dart';
import 'package:provider/provider.dart';

class AddPostPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ChangeNotifierProvider<AddPostModel>(
      create: (_) => AddPostModel(),
      child: Scaffold(
          appBar: AppBar(
            title: Text("投稿一覧"),
            actions: [],
          ),
          body: Consumer<AddPostModel>(builder: (context, model, child) {
            return Column(
              children: [
                TextField(
                  style: TextStyle(fontSize: 20),
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  onChanged: (text) {
                    model.postText = text;
                  },
                ),
                RaisedButton(
                    child: Text("追加"),
                    onPressed: () async {
                      await model.addPost();
                      Navigator.pop(context);
                    }),
              ],
            );
          })),
    );
  }
}
