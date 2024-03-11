import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:reso/widget/loading.dart' as loading_screen;
import 'package:reso/widget/gamerules.dart' as game_rules;
import 'package:reso/widget/gameinfo.dart' as game_info;

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
        body: Stack(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Expanded(
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
                child: game_rules.GameRules(),
              ),
              Center(
                  child: Container(
                // width: screenSize.height * 0.46220302375,
                constraints: const BoxConstraints(
                  minWidth: 500,
                  minHeight: 700,
                ),

                width: screenSize.height * .5125,
                height: screenSize.height,
                // bottom: false,
                child: PopScope(
                  // onWillPop: () async {
                  //   // Pop the category page if Android back button is pressed.
                  //   return true;
                  // },
                  child: Container(
                    color: Colors.yellow,
                    child: UnityWidget(
                      onUnityCreated: onUnityCreated,
                    ),
                  ),
                ),
              )),
              const Expanded(
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
                  child: game_info.GameInfo()),
            ],
          )
              .animate(delay: 5.seconds)
              .fadeIn(duration: 500.ms, curve: Curves.easeIn),
          isLoading
              ? const loading_screen.CharactersStackAnimation()
              : Container(),
        ]));
  }

  void onUnityCreated(controller) {
    _unityWidgetController = controller;
  }
}
