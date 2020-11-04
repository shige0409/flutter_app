import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/posts/add_post/add_post_page.dart';
import 'package:flutter_app/presentation/posts/post_list/post_list_model.dart';
import 'package:provider/provider.dart';

class PostListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PostListModel>(
      create: (_) => PostListModel()..readTimeFetchPosts(),
      child: Scaffold(
          appBar: AppBar(
            title: Text("投稿一覧"),
          ),
          body: Consumer<PostListModel>(builder: (context, model, child) {
            final posts = model.posts;
            final postCards = posts
                .map((post) => Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://i0.wp.com/sozaikoujou.com/wordpress/wp-content/uploads/2020/02/th_ca_recruitmen202.png?w=600&ssl=1"),
                        ),
                        title: Text(model.now
                                .difference(post.createAt.toDate())
                                .inMinutes
                                .toString() +
                            "分前"),
                        subtitle: Text(post.postText),
                        trailing: IconButton(
                          icon: Icon(Icons.label),
                          onPressed: () {},
                        ),
                      ),
                    ))
                .toList();
            return ListView(
              children: postCards,
              controller: ScrollController(),
            );
          }),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddPostPage(),
                  fullscreenDialog: true,
                ),
              );
            },
          )),
    );
  }
}
