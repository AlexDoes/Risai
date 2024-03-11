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

  Future<void> _loadingScreen() async {
    await Future.delayed(const Duration(seconds: 5));
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
                SafeArea(
                  child: Column(children: [
                    Container(
                      // width: screenSize.height * 0.46220302375,
                      constraints: BoxConstraints(
                        minWidth: kIsWeb ? 500 : screenSize.width,
                        minHeight: kIsWeb ? 680 : screenSize.width,
                      ),
                      width:
                          kIsWeb ? screenSize.height * .5125 : screenSize.width,
                      height:
                          kIsWeb ? screenSize.height : screenSize.height - 50,
                      child: FutureBuilder(
                        future: Future.delayed(const Duration(seconds: 3)),
                        builder: (context, snapshot) {
                          return UnityWidget(
                            onUnityCreated: onUnityCreated,
                          );
                        },
                      ),
                    ),
                    Visibility(
                      visible: !kIsWeb,
                      child: Row(
                        children: [
                          Visibility(
                            visible: !kIsWeb,
                            child: ElevatedButton(
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
                          Visibility(
                              visible: !kIsWeb,
                              child: ElevatedButton(
                                  onPressed: () => {
                                        Provider.of<LanguageProvider>(context,
                                                listen: false)
                                            .toggleLanguage(),
                                      },
                                  style: ElevatedButton.styleFrom(
                                    shape: const CircleBorder(),
                                    backgroundColor: currentLanguage !=
                                            'English'
                                        ? const Color.fromARGB(230, 0, 76, 255)
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
                ),
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
                    child: Container(
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
                        child: game_info.GameInfo())),
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
}
