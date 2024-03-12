import 'package:flutter/material.dart';
// ignore: avoid_web_libraries_in_flutter
// import 'dart:js' as js;
// import 'dart:html' as html;
import 'package:reso/widget/opaquebox.dart';
import 'package:reso/localization/language.dart';
import 'package:reso/providers/languageprovider.dart';
import 'package:provider/provider.dart';
import 'package:reso/widget/textstack.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class GameInfo extends StatelessWidget {
  const GameInfo({Key? key}) : super(key: key);
  static const characters = [
    "assets/images/plasticbag.png",
    "assets/images/chips.png",
    "assets/images/milkcarton.png",
    "assets/images/coffeecup.png",
    "assets/images/toiletpaper.png",
    "assets/images/waterbottle.png",
    "assets/images/sodacan.png",
    "assets/images/newspaper.png",
  ];

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    String currentLanguage = Provider.of<LanguageProvider>(context).language;
    return Stack(children: [
      Container(
        height: kIsWeb ? screenSize.height * .6 : screenSize.height,
        width: kIsWeb ? screenSize.width * .40 : screenSize.width,
        padding: const EdgeInsets.all(20.0),
        child: OpaqueBox(
          boxWidth: screenSize.width * .33,
          boxHeight: 200,
          content: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    textStack(languageLines[currentLanguage]!['gameRules']!,
                        textSize: 35, color: Colors.lightGreenAccent),
                  ],
                ),
                const SizedBox(height: 10),
                for (var i = 1; i < 6; i++)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textStack(
                          languageLines[currentLanguage]!['gameRules${i}']!),
                      const SizedBox(height: 15),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
      Positioned(
          bottom: 10,
          right: 10,
          child: ElevatedButton(
              onPressed: () => {
                    Provider.of<LanguageProvider>(context, listen: false)
                        .toggleLanguage(),
                    // kIsWeb
                    //     ? html.document.title = languageLines[
                    //         currentLanguage == "English"
                    //             ? "Japanese"
                    //             : "English"]!['title']!
                    //     : null
                  },
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(10),
                minimumSize: const Size(60.0, 60.0),
                maximumSize: const Size(60.0, 60.0),
                backgroundColor: currentLanguage != 'English'
                    ? const Color.fromARGB(230, 0, 76, 255)
                    : Colors.white,
                foregroundColor:
                    currentLanguage != 'English' ? Colors.white : Colors.red,
              ),
              child: Text(
                  style: const TextStyle(
                    fontSize: 10.0,
                  ),
                  currentLanguage == "English" ? "日本語" : "Eng"))),
    ]);
  }
}
