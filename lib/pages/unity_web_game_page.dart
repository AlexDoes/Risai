import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';

class UnityWebGamePage extends StatefulWidget {
  const UnityWebGamePage({Key? key}) : super(key: key);

  @override
  State<UnityWebGamePage> createState() => _UnityWebGamePageState();
}

class _UnityWebGamePageState extends State<UnityWebGamePage> {
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();
  UnityWidgetController? _unityWidgetController;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: SizedBox(
                width: screenSize.height * 0.46220302375,
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Callback that connects the created controller to the unity controller
  void onUnityCreated(controller) {
    _unityWidgetController = controller;
  }
}
