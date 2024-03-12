import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

Widget backButton(BuildContext context, {VoidCallback? setLoading}) {
  return Positioned(
      top: kIsWeb ? 25 : 10,
      left: kIsWeb ? -10 : -20,
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
