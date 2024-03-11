import 'package:flutter/material.dart';

Widget backButton(BuildContext context, {VoidCallback? setLoading}) {
  return Positioned(
      top: 25,
      left: -10,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.lightGreen[300], // Update the color to a lighter shade
          shape: BoxShape.circle,
        ),
        child: ElevatedButton(
            onPressed: () => {},
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              foregroundColor: Colors.transparent,
              backgroundColor: Colors.transparent,
            ),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () => {
                // setLoading != null ? setLoading() : null,
                Navigator.pop(context)
              },
            )),
      ));
}
