import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  UnityWidgetController? _unityWidgetController;
  final _buttonValue = 1000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          UnityWidget(
            onUnityCreated: onUnityCreated,
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: () {
                sendIntValueToUnity(_buttonValue);
              },
              child: const Text('Send Int Value to Unity'),
            ),
          ),
        ],
      ),
    );
  }

  void onUnityCreated(controller) {
    _unityWidgetController = controller;
  }

  void sendIntValueToUnity(int value) {
    _unityWidgetController?.postMessage(
      'Score Manager',
      'RecieveScoreMultiplier',
      value.toString(),
    );
  }
}
