import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/foundation.dart' show kIsWeb;

class OpaqueBox extends StatelessWidget {
  const OpaqueBox(
      {Key? key,
      required this.boxWidth,
      required this.content,
      required this.boxHeight})
      : super(key: key);

  final double boxWidth;
  final Widget content; // double check this later
  final double boxHeight;

  @override
  Widget build(BuildContext context) {
    // final parentHeight = MediaQuery.of(context).size.height;

    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
        // width: 400,
        // height: 900,
        color: kIsWeb
            ? const Color.fromARGB(97, 240, 236, 239)
            : Color.fromARGB(86, 255, 140, 129),
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
                      Color.fromARGB(255, 255, 175, 1).withOpacity(0.10),
                      Color.fromARGB(255, 2, 0, 0).withOpacity(0.05),
                    ]),
              ),
            ),
            Container(child: content),
          ],
        ),
      ),
    );
  }
}
