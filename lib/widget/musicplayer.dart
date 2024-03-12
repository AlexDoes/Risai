import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class MyAudioPlayer extends StatefulWidget {
  const MyAudioPlayer({Key? key}) : super(key: key);

  @override
  State<MyAudioPlayer> createState() => _MyAudioPlayerState();
}

class _MyAudioPlayerState extends State<MyAudioPlayer> {
  bool isMuted = false;
  late AudioPlayer player;

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
    kIsWeb ? isMuted = true : isMuted = false;
    _loadMutedState();
  }

  @override
  void didUpdateWidget(MyAudioPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.key != widget.key) {
      player.dispose();
      player = AudioPlayer();
      _loadMutedState();
    }
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  _loadMutedState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      !kIsWeb ? isMuted = prefs.getBool('isMuted') ?? false : false;
      if (!isMuted) {
        player.setSource(AssetSource('music/rbgm.wav'));
        player.setReleaseMode(ReleaseMode.loop);
        player.play(AssetSource('music/rbgm.wav'));
      }
    });
  }

  _toggleMute() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isMuted = !isMuted;
      prefs.setBool('isMuted', isMuted);
      if (isMuted) {
        player.stop();
      } else {
        player.setSource(AssetSource('music/rbgm.wav'));
        player.setReleaseMode(ReleaseMode.loop);
        player.play(AssetSource('music/rbgm.wav'));
      }
    });
  }

  void loop() {
    player.setReleaseMode(ReleaseMode.loop);
  }

  @override
  Widget build(BuildContext context) {
    // double deviceWidth = MediaQuery.of(context).size.width;
    // double deviceHeight = MediaQuery.of(context).size.height;
    return IconButton(
        icon: Icon(isMuted ? Icons.music_off : Icons.music_note),
        // iconSize: 5,
        // iconSize: deviceHeight * 0.05,
        style: ButtonStyle(
            // maximumSize: MaterialStateProperty.all(Size(100, 100)),
            // minimumSize: MaterialStateProperty.all(Size(3, 3)),
            backgroundColor: isMuted
                ? MaterialStateProperty.all<Color>(
                    const Color.fromARGB(255, 19, 90, 102))
                : MaterialStateProperty.all<Color>(
                    const Color.fromARGB(255, 30, 144, 164),
                  ),
            animationDuration: const Duration(milliseconds: 300),
            textStyle: MaterialStateProperty.all<TextStyle>(
              const TextStyle(
                color: Colors.white,
              ),
            ),
            iconColor: MaterialStateProperty.all<Color>(
              const Color.fromARGB(255, 254, 254, 254),
            )),
        onPressed: () async {
          _toggleMute();
        });
  }
}
