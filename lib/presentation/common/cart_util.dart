import 'package:flutter/cupertino.dart';

import '../../constants.dart';

class CardUtil extends StatelessWidget {
  Widget child;
  CardUtil({@required this.child});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: child,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: kGrayColor,
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
