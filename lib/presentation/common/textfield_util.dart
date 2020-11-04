import 'package:flutter/material.dart';

class TextFieldUtil extends StatelessWidget {
  TextFieldUtil({
    @required this.readOnly,
    @required this.controller,
    @required this.onChanged,
    @required this.label,
    @required this.suffixIconSize,
  });
  bool readOnly;
  TextEditingController controller;
  String label;
  Function(String) onChanged;
  double suffixIconSize;

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
      decoration: BoxDecoration(
          //color: kPrimaryLightColor,
          //borderRadius: BorderRadius.circular(30),
          ),
      child: TextField(
        readOnly: readOnly,
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          suffixIcon: Icon(
            Icons.edit,
            size: suffixIconSize,
          ),
        ),
      ),
    );
  }
}
