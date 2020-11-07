import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/presentation/home/home_model.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("create Home");
    return ChangeNotifierProvider<HomeModel>(
      create: (context) => HomeModel()..initPages(context),
      child: Consumer<HomeModel>(builder: (context, model, chile) {
        return Scaffold(
          body: IndexedStack(
            index: model.index,
            children: model.pageList,
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'ホーム'),
              BottomNavigationBarItem(icon: Icon(Icons.search), label: 'さがす'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.record_voice_over), label: '通話'),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: 'マイページ')
            ],
            currentIndex: model.index,
            selectedItemColor: kPrimaryColor,
            selectedFontSize: 8,
            unselectedFontSize: 0,
            unselectedItemColor: kGrayColor,
            onTap: (int index) {
              model.changePage(index);
            },
          ),
        );
      }),
    );
  }
}
