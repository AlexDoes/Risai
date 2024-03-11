import 'package:flutter/material.dart';

Widget textStack(String textContent,
    {Color? color, double? textSize, Color? strokeColor}) {
  return Stack(
    children: [
      Text(
        textContent,
        style: TextStyle(
          fontSize: textSize ?? 20,
          foreground: Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 3
            ..color = strokeColor ?? const Color.fromARGB(255, 113, 177, 241),
        ),
      ),
      Text(
        textContent,
        style: TextStyle(
          fontSize: textSize ?? 20,
          color: color ?? const Color.fromARGB(255, 255, 255, 252),
        ),
      ),
    ],
  );
}
