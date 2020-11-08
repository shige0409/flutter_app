import 'package:flutter/material.dart';

class TextFieldUtil extends StatelessWidget {
  const TextFieldUtil({@required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
        //TextField
        margin: EdgeInsets.all(10),
        width: size.width * 0.9,
        padding: EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 20,
        ),
        child: child);
  }
}
