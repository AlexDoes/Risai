import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:reso/widget/loading.dart' as loading_screen;
import 'package:reso/widget/gamerules.dart' as game_rules;
import 'package:reso/widget/gameinfo.dart' as game_info;
import 'package:reso/widget/backbutton.dart' as back_button;

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
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        key: _scaffoldKey,
        body: Container(
          // maybe popscope?
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
                Container(
                  // width: screenSize.height * 0.46220302375,
                  constraints: const BoxConstraints(
                    minWidth: 500,
                    minHeight: 680,
                  ),

                  width: screenSize.height * .5125,
                  height: screenSize.height,
                  child: FutureBuilder(
                    future: Future.delayed(
                        const Duration(seconds: 3)), // Delay UnityWidget build
                    builder: (context, snapshot) {
                      return UnityWidget(
                        onUnityCreated: onUnityCreated,
                      );
                    },
                  ),
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
