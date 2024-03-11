import 'package:flutter/material.dart';
//ignore: constant_identifier_names
import 'package:reso/widget/opaquebox.dart';
import 'package:reso/localization/language.dart';
import 'package:reso/providers/languageprovider.dart';
import 'package:provider/provider.dart';
import 'package:reso/widget/textstack.dart';

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
    double imageSizing = screenSize.height <= 696 ? 75 : 100;
    String currentLanguage = Provider.of<LanguageProvider>(context).language;
    return Stack(children: [
      Container(
        height: screenSize.height * .75,
        width: screenSize.width * .40,
        padding: const EdgeInsets.all(20.0),
        child: OpaqueBox(
          boxWidth: 0,
          boxHeight: 0,
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              textStack(
                languageLines[currentLanguage]!['legend']!,
                textSize: currentLanguage == 'English' ? 20 : 35,
              ),
              for (var i = 0; i < characters.length - 1; i += 2)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      characters[i],
                      height: imageSizing,
                      width: imageSizing,
                    ),
                    Image.asset(
                      'assets/images/arrow.png',
                      height: imageSizing,
                      width: 50,
                    ),
                    Image.asset(
                      characters[i + 1],
                      height: imageSizing,
                      width: imageSizing,
                    )
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
                    textStack(languageLines[currentLanguage]!['points']!),
                  ]),
            ],
          ),
        ),
      ),
      // Positioned(
      //     top: 10,
      //     left: 10,
      //     child: ElevatedButton(
      //         onPressed: () => {Navigator.pop(context)},
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
      //         child: IconButton(
      //           icon: Icon(
      //             Icons.arrow_back,
      //             color:
      //                 currentLanguage != 'English' ? Colors.white : Colors.red,
      //           ),
      //           onPressed: () => {Navigator.pop(context)},
      //         )))
    ]);
  }
}
