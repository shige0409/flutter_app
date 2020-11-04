import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/calls/call_list/call_list_model.dart';
import 'package:provider/provider.dart';

class CallListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CallListModel>(
      create: (_) => CallListModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('通話履歴'),
        ),
        body: Consumer(builder: (context, model, child) {
          return Container();
        }),
      ),
    );
  }
}
