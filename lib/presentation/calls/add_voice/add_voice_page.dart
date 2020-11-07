import 'package:flutter/material.dart';

class AddVoicePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          GestureDetector(
            child: Icon(Icons.mic_sharp),
            onLongPress: () {},
            onLongPressStart: null,
          ),
        ],
      ),
    );
  }
}
