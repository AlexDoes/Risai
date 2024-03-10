import 'package:flutter/material.dart';

// ignore: ThreeColumnsLayout
class ThreeColumnsLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          flex: 1,
          child: Container(
            color: Colors.blue,
            child: Center(child: Text('Column 1')),
          ),
        ),
        Container(
          width: screenSize.height * .5125,
          height: screenSize.height,
          child: Container(
            color: Colors.green,
            child: Center(child: Text('Column 2')),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            color: Colors.red,
            child: Center(child: Text('Column 3')),
          ),
        ),
      ],
    );
  }
}
