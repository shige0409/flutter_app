import 'package:flutter/material.dart';

import '../../constants.dart';

class ButtonUtil extends StatelessWidget {
  const ButtonUtil({
    @required this.label,
    @required this.onPressed,
  });
  final String label;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.all(10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Container(
          color: kPrimaryColor,
          child: FlatButton(
            padding: EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 20,
            ),
            onPressed: onPressed,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
