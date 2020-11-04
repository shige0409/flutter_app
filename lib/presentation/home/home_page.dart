import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/presentation/home/home_model.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeModel>(
      create: (_) => HomeModel()..createPage(),
      child: Consumer<HomeModel>(builder: (context, model, chile) {
        return Scaffold(
          body: model.pageList[model.index],
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
              BottomNavigationBarItem(icon: Icon(Icons.people), label: 'users'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.record_voice_over), label: 'calling'),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: 'mypage')
            ],
            currentIndex: model.index,
            selectedItemColor: kPrimaryColor,
            unselectedItemColor: kPrimaryLightColor,
            onTap: (int index) {
              model.changePage(index);
            },
          ),
        );
      }),
    );
  }
}
