import 'package:flutter/material.dart';
import 'dart:ui';

class OpaqueBox extends StatelessWidget {
  const OpaqueBox(
      {Key? key,
      required this.boxWidth,
      required this.boxHeight,
      required this.content})
      : super(key: key);

  final double boxWidth;
  final double boxHeight;
  final Widget content; // double check this later

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
        // width: boxWidth,
        // height: boxHeight,
        color: Color.fromARGB(98, 244, 184, 241),
        child: Stack(
          children: [
            // Image.asset('assets/images/mascotcoral.png',
            //     fit: BoxFit.cover, width: boxWidth, height: boxHeight),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 3),
              child: Container(),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white.withOpacity(0.13)),
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withOpacity(0.10),
                      Colors.white.withOpacity(0.05),
                    ]),
              ),
            ),
            Center(child: content),
          ],
        ),
      ),
    );
  }
}
