import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/home/manager_model.dart';
import 'package:provider/provider.dart';

class ManagerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ManagerModel>(
      create: (context) => ManagerModel()..realTimeFetchCallData(context),
      child: Consumer<ManagerModel>(builder: (context, model, child) {
        return Container();
      }),
    );
  }
}
