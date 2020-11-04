import 'package:flutter/material.dart';
import 'first_page_model.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FirstPageModel>(
      create: (context) => FirstPageModel()..createPage(context),
      child: Consumer<FirstPageModel>(
        builder: (context, model, child) {
          return ModalProgressHUD(
            inAsyncCall: model.showSnipper,
            child: Container(
              width: double.infinity,
              color: Colors.white,
            ),
          );
        },
      ),
    );
  }
}
