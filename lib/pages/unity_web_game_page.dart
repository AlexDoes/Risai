import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:reso/widget/loading.dart' as loading_screen;
import 'package:reso/widget/gamerules.dart' as game_rules;
import 'package:reso/widget/gameinfo.dart' as game_info;
import 'package:reso/widget/backbutton.dart' as back_button;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:reso/providers/languageprovider.dart';
import 'package:provider/provider.dart';
import 'package:reso/widget/textstack.dart';
import 'package:reso/localization/language.dart';
import 'package:reso/widget/gameover.dart' as gameover;

class UnityWebGamePage extends StatefulWidget {
  const UnityWebGamePage({Key? key}) : super(key: key);

  @override
  State<UnityWebGamePage> createState() => _UnityWebGamePageState();
}

// class CustomSplashScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//       ),
//       child: Center(
//         child: Text(
//           style: TextStyle(color: Colors.white, fontSize: 24.0),
//         ),
//       ),
//     );
//   }
// }

class _UnityWebGamePageState extends State<UnityWebGamePage> {
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();
  UnityWidgetController? _unityWidgetController;
  bool isLoading = true; // Set to true when the page is loading.
  // bool isLoading = false;
  @override
  void initState() {
    super.initState();
    _loadingScreen();
  }

  bool showGameOver = false;
  int recentScore = 0;

  Future<void> _loadingScreen() async {
    await Future.delayed(const Duration(seconds: 6));
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var currentLanguage = Provider.of<LanguageProvider>(context).language;
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        key: _scaffoldKey,
        body: Container(
          // maybe popscope?
          decoration: !kIsWeb
              ? const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromARGB(255, 252, 239, 255),
                      Color.fromARGB(255, 202, 247, 196),
                      // Color.fromARGB(255, 173, 251, 254),
                      // pastel lilac
                    ],
                  ),
                )
              : null,
          height: screenSize.height,
          child: Stack(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                    flex: 1,
                    child: Stack(children: [
                      Container(
                        height: screenSize.height,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color.fromARGB(255, 173, 251, 254),
                            Color.fromARGB(255, 202, 247, 196),
                            Color.fromARGB(255, 202, 247, 196)
                          ],
                        )),
                        child: const game_rules.GameRules(),
                      ),
                      back_button.backButton(context, setLoading: () {
                        setState(() {
                          isLoading = true;
                        });
                      }),
                    ])),
                Stack(children: [
                  Column(children: [
                    Stack(children: [
                      // recentScore == 0
                      //     ? gameover.GameOver(recentScore: recentScore)
                      //     : Text('sadasds'),
                      Container(
                        constraints: BoxConstraints(
                          minWidth: kIsWeb ? 735 : screenSize.width,
                          minHeight: kIsWeb ? 790 : screenSize.height - 50,
                        ),
                        width:
                            kIsWeb ? screenSize.height * .75 : screenSize.width,
                        height:
                            kIsWeb ? screenSize.height : screenSize.height - 50,
                        child: FutureBuilder(
                          future: Future.delayed(const Duration(seconds: 3)),
                          builder: (context, snapshot) {
                            return UnityWidget(
                              onUnityCreated: onUnityCreated,
                              onUnityMessage: onUnityMessage,
                            );
                          },
                        ),
                      ),
                    ]),
                    Visibility(
                      visible: !kIsWeb,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Visibility(
                            visible: !kIsWeb,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 181, 241, 228),
                              ),
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (BuildContext context) {
                                    return SizedBox(
                                      height: screenSize.height,
                                      width: screenSize.width,
                                      // padding: const EdgeInsets.all(20.0),
                                      child: const game_rules.GameRules(),
                                    );
                                  },
                                );
                              },
                              child: textStack(
                                currentLanguage == 'English'
                                    ? 'Points'
                                    : 'ポイント',
                                textSize: 20,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: !kIsWeb,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 239, 213, 247),
                              ),
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (BuildContext context) {
                                    return SizedBox(
                                      height: screenSize.height,
                                      width: screenSize.width,
                                      // padding: const EdgeInsets.all(20.0),
                                      child: const game_info.GameInfo(),
                                    );
                                  },
                                );
                              },
                              child: textStack(
                                currentLanguage == 'English'
                                    ? 'How to play'
                                    : '遊び方',
                                textSize: 20,
                              ),
                            ),
                          ),
                          ElevatedButton(
                              onPressed: () => {triggerGameOver('RestartGame')},
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color.fromARGB(255, 255, 193, 193),
                              ),
                              child: Icon(
                                Icons.refresh,
                                color: Colors.white,
                              )),
                          Visibility(
                              visible: !kIsWeb,
                              child: ElevatedButton(
                                  onPressed: () => {
                                        Provider.of<LanguageProvider>(context,
                                                listen: false)
                                            .toggleLanguage(),
                                      },
                                  style: ElevatedButton.styleFrom(
                                    // shape: const CircleBorder(),
                                    backgroundColor:
                                        currentLanguage != 'English'
                                            ? const Color.fromARGB(
                                                230, 15, 157, 188)
                                            : Colors.white,
                                    foregroundColor:
                                        currentLanguage != 'English'
                                            ? Colors.white
                                            : Colors.red,
                                  ),
                                  child: Text(
                                      style: const TextStyle(
                                        fontSize: 10.0,
                                      ),
                                      currentLanguage == "English"
                                          ? "日本語"
                                          : "Eng"))),
                        ],
                      ),
                    ),
                  ]),
                  // Visibility(
                  //   visible: !kIsWeb,
                  //   child: back_button.backButton(context),
                  // )
                ]),
                Expanded(
                    flex: 1,
                    // child: Container(
                    //   decoration: const BoxDecoration(
                    //     gradient: LinearGradient(
                    //       begin: Alignment.topCenter,
                    //       end: Alignment.bottomCenter,
                    //       colors: [
                    //         Color.fromARGB(255, 173, 251, 254),
                    //         Color.fromARGB(255, 202, 247, 196),
                    //         Color.fromARGB(255, 202, 247, 196)
                    //       ],
                    //     ),
                    //   ),
                    // )),
                    child: Stack(
                      children: [
                        Container(
                            height: screenSize.height,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                                gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color.fromARGB(255, 173, 251, 254),
                                Color.fromARGB(255, 202, 247, 196),
                                Color.fromARGB(255, 202, 247, 196)
                              ],
                            )),
                            child: const game_info.GameInfo()),
                        Visibility(
                          visible: kIsWeb,
                          child: Positioned(
                            bottom: 10,
                            child: ElevatedButton(
                                onPressed: () =>
                                    {triggerGameOver('RestartGame')},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Color.fromARGB(255, 255, 193, 193),
                                ),
                                child: Icon(
                                  Icons.refresh,
                                  color: Colors.white,
                                )),
                          ),
                        ),
                      ],
                    )),
              ],
            )
                .animate(delay: 0.seconds) // swap to 5
                .fadeIn(duration: 500.ms, curve: Curves.easeIn),
            isLoading
                ? const loading_screen.CharactersStackAnimation()
                : Container(),
          ]),
        ));
  }

  void onUnityCreated(controller) {
    _unityWidgetController = controller;
  }

  void onUnityMessage(message) {
    // I/flutter (15038): Received message from unity: GameOver
    // I/flutter (15038): Received message from unity: Score:10124
    if (message.toString() == 'GameOver') {
      setState(() {
        showGameOver = true;
      });
    }
    // print('Received message from unity: $message');
    if (message.toString().contains('Score:')) {
      String scoreMessage = message.toString();
      String score = scoreMessage.split(":").last.trim();
      recentScore = int.parse(score);
      showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return !kIsWeb
              ? SizedBox(
                  height: 600,
                  width: MediaQuery.of(context).size.width,
                  child: gameover.GameOver(
                      boxwidth: MediaQuery.of(context).size.width,
                      recentScore: recentScore,
                      restartGame: () {
                        triggerGameOver('RestartGame');
                        Navigator.pop(context);
                      }),
                )
              : gameover.GameOver(
                  boxwidth: MediaQuery.of(context).size.width,
                  recentScore: recentScore,
                  restartGame: () {
                    triggerGameOver('RestartGame');
                    Navigator.pop(context);
                  });
        },
      );
    }
  }

  void sendIntValueToUnity(String value) {
    // print(value);
    _unityWidgetController?.postMessage(
      'Game Manager',
      'GetLanguageState',
      value,
    );
  }

  void triggerGameOver(String value) {
    // print(value);
    _unityWidgetController?.postMessage(
      'UI Manager',
      'RestartGame',
      value,
    );
  }
}
