import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Select extends StatefulWidget {
  const Select({super.key});

  @override
  State<Select> createState() => _SelectState();
}

class _SelectState extends State<Select> {
  String dropdownvalue = "Easy";
  List items = ['Easy', 'Moderate', 'Difficult'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text("Select Level"),
            DropdownButton(
              value: dropdownvalue,
              items:items.map((String item) {
              return DropdownMenuItem(value:items child: Text(item));
            }).toList(),
            onChanged: (String? newvalue){
              setState(() {
                dropdownvalue=newvalue;
              });
            }),
            
          ],
        ),
      ),
    );
  }
}
