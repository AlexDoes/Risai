import 'package:add_to_google_wallet/widgets/add_to_google_wallet_button.dart';
import 'package:flutter/material.dart';
import 'package:reso/widget/textstack.dart';
import 'package:reso/widget/pass.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:reso/localization/language.dart';
import 'package:reso/providers/languageprovider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';

class GameOver extends StatelessWidget {
  final int recentScore;
  void Function() restartGame;
  final double? boxwidth;

  GameOver(
      {Key? key,
      required this.recentScore,
      required this.restartGame,
      this.boxwidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    var currentLanguage = Provider.of<LanguageProvider>(context).language;

    return Scaffold(
      body: Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  // height: kIsWeb ? screenSize.height * .75 : 600,
                  // width: kIsWeb ? boxwidth : screenSize.width,
                  child: Container(
                    // width: boxwidth,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xfffaf2a3), Color(0xffffca6f)],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        textStack(
                          "${languageLines[currentLanguage]!['score']!}: $recentScore",
                          textSize: 35,
                          color: const Color.fromARGB(255, 181, 252, 181),
                        )
                            .animate(
                              delay: 1.seconds,
                              onPlay: (controller) => controller.loop(
                                count: 6,
                              ),
                            )
                            .shimmer(
                              duration: 3000.ms,
                              size: .5,
                            ),
                        const SizedBox(height: 10),
                        textStack(
                            recentScore < 1000
                                ? languageLines[currentLanguage]!['gameOver']!
                                : languageLines[currentLanguage]!['wellDone']!,
                            textSize: currentLanguage == 'English' ? 30 : 30),
                        const SizedBox(height: 10),
                        Visibility(
                          visible: recentScore > 1000,
                          child: textStack(
                              languageLines[currentLanguage]!['youWon']!,
                              color: Color.fromARGB(255, 251, 230, 251),
                              textSize: 30),
                        ),
                        const SizedBox(height: 20),
                        Visibility(
                          visible: recentScore > 1000,
                          child: kIsWeb
                              ? Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: textStack(
                                          languageLines[currentLanguage]![
                                              'gameOverSorry']!,
                                          textSize: 15,
                                          color: const Color(0xffb5fcb5),
                                          strokeColor: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : AddToGoogleWalletButton(
                                      pass: generatePass(
                                          recentScore: recentScore.toString(),
                                          passLanguage:
                                              currentLanguage == 'Japanese'
                                                  ? 'ja'
                                                  : 'en'),
                                      // onSuccess: () => ScaffoldMessenger.of(context)
                                      //     .showSnackBar(
                                      //         const SnackBar(content: Text('Success!'))),
                                      // onCanceled: () => ScaffoldMessenger.of(context)
                                      //     .showSnackBar(const SnackBar(
                                      //         content: Text('Action canceled.'))),
                                      onError: (Object error) =>
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content:
                                                      Text(error.toString()))),
                                      locale: currentLanguage == 'English'
                                          ? const Locale('en', 'US')
                                          : const Locale('jp', 'JP'))
                                  .animate(
                                    delay: 1.seconds,
                                    onPlay: (controller) => controller.loop(
                                      count: 3,
                                    ),
                                  )
                                  .shimmer(
                                    duration: 2400.ms,
                                    size: .5,
                                  ),
                        ),
                        Visibility(
                          visible: recentScore <= 1000,
                          child: Center(
                            child: textStack(
                                languageLines[currentLanguage]!['scoreHigher']!,
                                textSize: 30,
                                align: true),
                          ),
                        ),
                        const SizedBox(height: 25),
                        textStack(languageLines[currentLanguage]!['keepUp']!,
                            textSize: 30, color: const Color(0xffb5fcb5)),
                        const SizedBox(height: 25),
                        ElevatedButton(
                          onPressed: () => restartGame(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffb5fcb5),
                            padding: const EdgeInsets.all(15),
                            minimumSize: const Size(200, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: textStack(
                            languageLines[currentLanguage]!['playAgain']!,
                            textSize: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
