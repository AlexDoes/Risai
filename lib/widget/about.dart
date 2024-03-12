import 'package:flutter/material.dart';
import 'package:reso/widget/opaquebox.dart';
import 'package:reso/localization/language.dart';
import 'package:reso/providers/languageprovider.dart';
import 'package:provider/provider.dart';
import 'package:reso/widget/textstack.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class AboutGame extends StatelessWidget {
  const AboutGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    String currentLanguage = Provider.of<LanguageProvider>(context).language;
    return Stack(children: [
      Container(
        height: kIsWeb ? screenSize.height : screenSize.height,
        width: kIsWeb ? screenSize.width : screenSize.width,
        padding: const EdgeInsets.all(20.0),
        child: OpaqueBox(
          boxWidth: screenSize.width * .33,
          boxHeight: kIsWeb ? screenSize.height : 200,
          content: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: textStack(
                          languageLines[currentLanguage]!['aboutRisai']!,
                          textSize: 35,
                          color: Colors.lightGreenAccent),
                    ),
                    const SizedBox(height: 25),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: textStack(
                          languageLines[currentLanguage]!['aboutRisai2']!,
                          textSize: currentLanguage == 'English' ? 20 : 20,
                          color: const Color.fromARGB(255, 244, 255, 93)),
                    ),
                    const SizedBox(height: 25),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: textStack(
                          languageLines[currentLanguage]!['aboutRisai3']!,
                          textSize: currentLanguage == 'English' ? 20 : 20,
                          color: const Color.fromARGB(255, 244, 255, 93)),
                    ),
                    const SizedBox(height: 25),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: textStack(
                          languageLines[currentLanguage]!['aboutRisai4']!,
                          textSize: currentLanguage == 'English' ? 20 : 20,
                          color: const Color.fromARGB(255, 244, 255, 93)),
                    ),
                    const SizedBox(height: 25),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: textStack(
                          languageLines[currentLanguage]!['aboutRisai5']!,
                          textSize: currentLanguage == 'English' ? 20 : 20,
                          color: const Color.fromARGB(255, 244, 255, 93)),
                    ),
                    const SizedBox(height: 25),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: textStack(
                          languageLines[currentLanguage]!['aboutRisai6']!,
                          textSize: currentLanguage == 'English' ? 20 : 20,
                          color: const Color.fromARGB(255, 244, 255, 93)),
                    ),
                    const SizedBox(height: 25),
                    // Align(
                    //   alignment: Alignment.centerLeft,
                    //   child: textStack(
                    //       languageLines[currentLanguage]!['aboutRisai7']!,
                    //       textSize: currentLanguage == 'English' ? 20 : 20,
                    //       color: const Color.fromARGB(255, 244, 255, 93)),
                    // ),
                    // const SizedBox(height: 10),
                    Image(
                      image: AssetImage('assets/images/mascotshadow.png'),
                      fit: BoxFit.cover,
                      width: 200,
                      height: 200,
                    ),
                  ],
                ),
                Positioned(
                    bottom: 10,
                    right: 0,
                    child: ElevatedButton(
                        onPressed: () => {
                              Provider.of<LanguageProvider>(context,
                                      listen: false)
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
                              ? Color.fromARGB(230, 187, 241, 253)
                              : Colors.white,
                          foregroundColor: currentLanguage != 'English'
                              ? Colors.black
                              : Colors.red,
                        ),
                        child: Text(
                            style: const TextStyle(
                              fontSize: 12.0,
                            ),
                            currentLanguage == "English" ? "日本語" : "Eng"))),
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}
