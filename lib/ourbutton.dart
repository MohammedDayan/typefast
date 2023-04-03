import 'package:flutter/material.dart';

class ourbutton extends StatelessWidget {
  ourbutton({Key? key}) : super(key: key);
  String names = "Razak";
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {}, child: Text("Click here to begin$names"));
  }
}
