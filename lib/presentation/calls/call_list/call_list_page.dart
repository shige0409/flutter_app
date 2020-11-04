import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/presentation/calls/call_list/call_list_model.dart';
import 'package:flutter_app/presentation/calls/call_now/call_now_page.dart';
import 'package:provider/provider.dart';

class CallListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CallListModel>(
      create: (_) => CallListModel()..fetchCallList(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('通話履歴'),
        ),
        body: Consumer<CallListModel>(builder: (context, model, child) {
          final callCards = model.callLists
              .map((callCard) => Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(kFirstImageUrl),
                      ),
                      subtitle: Text(callCard.callId),
                      trailing: IconButton(
                        icon: Icon(Icons.call),
                        onPressed: () async {
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CallNowPage(
                                        callId: callCard.callerUserId +
                                            FirebaseAuth
                                                .instance.currentUser.uid,
                                      )));
                        },
                      ),
                    ),
                  ))
              .toList();
          return ListView(
            children: callCards,
          );
        }),
      ),
    );
  }
}
