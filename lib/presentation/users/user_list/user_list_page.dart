import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/presentation/users/user_show/user_show_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'user_list_model.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

class UserListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<UserListModel>(
      create: (_) => UserListModel()..fetchUsers(),
      child: Scaffold(
          body: Consumer<UserListModel>(builder: (context, model, child) {
            final users = model.users;
            final List<Widget> userCards = [SizedBox(height: 20)];
            final tmp = [];
            users.asMap().forEach((idx, u) {
              tmp.add(GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (context) => UserShowPage(
                        user: u,
                      ),
                    ),
                  );
                },
                child: Container(
                    width: size.width * 0.45,
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: u.gender == "man" ? kBlueColor : kPinkColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Hero(
                          tag: u.imageUrl,
                          child: CircleAvatar(
                              backgroundImage: NetworkImage(u.imageUrl),
                              radius: size.width * 0.15),
                        ),
                        Text(u.name),
                        Text(
                          "${u.city} ・ ${u.age}歳",
                          style: TextStyle(color: Colors.grey),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("相性: "),
                            Text(
                              math.Random().nextInt(100).toString(),
                              style: TextStyle(
                                  color: u.gender == "man"
                                      ? kPinkColor
                                      : kBlueColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Text("%"),
                          ],
                        ),
                      ],
                    )),
              ));
              if (idx % 2 == 0) {
              } else {
                userCards.add(Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    tmp[0],
                    tmp[1],
                  ],
                ));
                tmp.clear();
              }
            });
            return SingleChildScrollView(child: Column(children: userCards));
          }),
          floatingActionButton: FloatingActionButton(
            heroTag: 'voice record',
            child: Icon(FontAwesomeIcons.slidersH),
            onPressed: () {},
          )),
    );
  }
}
