import 'package:flutter/material.dart';
//ignore: constant_identifier_names
import 'package:reso/widget/opaquebox.dart';
import 'package:reso/localization/language.dart';
import 'package:reso/providers/languageprovider.dart';
import 'package:provider/provider.dart';

class GameRules extends StatelessWidget {
  const GameRules({Key? key}) : super(key: key);
  static const characters = [
    // "assets/images/mascotshadow.png",
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
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 173, 251, 254),
              Color.fromARGB(255, 202, 247, 196),
              Color.fromARGB(255, 202, 247, 196)
            ],
          ),
        ),
        height: screenSize.height,
        width: screenSize.width,
        padding: const EdgeInsets.all(20.0),
        child: OpaqueBox(
          boxWidth: screenSize.width,
          boxHeight: 200,
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                languageLines[currentLanguage]!['gameRules']!,
                style: const TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              for (var i = 0; i < characters.length - 1; i += 2)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(characters[i], height: 100),
                    // Icon(arrow, size: 50),
                    Image.asset(
                      'assets/images/arrow.png',
                      height: 100,
                      width: 50,
                    ),
                    Image.asset(characters[i + 1], height: 100)
                  ],
                ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(characters[7], height: 100),
                    // Icon(arrow, size: 50),
                    Image.asset(
                      'assets/images/arrow.png',
                      height: 100,
                      width: 50,
                    ),
                    Text(languageLines[currentLanguage]!['points']!,
                        style: const TextStyle(fontSize: 25.0)),
                  ]),
            ],
          ),
        ),
      ),
      // Positioned(
      //     bottom: 10,
      //     right: 10,
      //     child: ElevatedButton(
      //         onPressed: () => {
      //               Provider.of<LanguageProvider>(context, listen: false)
      //                   .toggleLanguage(),
      //             },
      //         style: ElevatedButton.styleFrom(
      //           shape: const CircleBorder(),
      //           padding: const EdgeInsets.all(10),
      //           minimumSize: const Size(60.0, 60.0),
      //           maximumSize: const Size(60.0, 60.0),
      //           backgroundColor: currentLanguage != 'English'
      //               ? const Color.fromARGB(230, 0, 76, 255)
      //               : Colors.white,
      //           foregroundColor:
      //               currentLanguage != 'English' ? Colors.white : Colors.red,
      //         ),
      //         child: Text(
      //             style: const TextStyle(
      //               fontSize: 10.0,
      //             ),
      //             currentLanguage == "English" ? "日本語" : "Eng"))),
    ]);
  }
}
