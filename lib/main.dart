// ignore_for_file: avoid_print
// ignore: unused_import
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:audioplayers/audioplayers.dart';
// import 'package:reso/pages/game_page.dart';
import 'package:reso/pages/unity_web_game_page.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:auto_size_text/auto_size_text.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Locale currentLocale = Localizations.localeOf(context);
    return MaterialApp(
      title: 'Reso',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 185, 231, 238),
        primaryColor: Colors.blue,
        primaryColorDark: Colors.blue[900],
        primaryColorLight: Colors.blue[100],
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 20, 255, 118)),
        primarySwatch: Colors.blue,
        useMaterial3: true,
        fontFamily: 'NampulaCity',
        fontFamilyFallback: const ['MondayRamen'],
      ),
      routes: {
        //   '/': (context) => const MyHomePage(title: 'Reso'),
        // '/game': (context) => const GamePage(),
        '/game': (context) => const UnityWebGamePage(),
      },
      home: const MyHomePage(title: 'Reso Game Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final background = Image.asset("assets/backgrounds/background.png");
  final mascot = Image.asset("assets/images/mascot.png");
  late double maxWidth;
  late double maxHeight;
  @override
  void didChangeDependencies() {
    precacheImage(background.image, context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // var fontSize = maxWidth * 0.1;
    Size screenSize = MediaQuery.of(context).size;
    precacheImage(background.image, context);
    precacheImage(mascot.image, context);
    TextButton buildTextButton({
      required VoidCallback onPressed,
      required String text,
      required double widthMultiplier,
      required double height,
    }) {
      return TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          maximumSize: MaterialStateProperty.all<Size?>(
            Size(maxWidth * 0.6, height * 1.25),
          ),
          minimumSize: MaterialStateProperty.all<Size?>(
            Size(maxWidth * 0.5, height * 1.25),
          ),
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xfffaf2a3), Color(0xffffca6f)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(19.0),
            border: Border.all(
              color: const Color(0xff2c7dbf),
              width: 2.5,
            ),
          ),
          child: Container(
            alignment: Alignment.center,
            child: Stack(
              children: <Widget>[
                // Stroked text as border.
                AutoSizeText(
                  text,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 25,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 4
                      ..color = const Color.fromARGB(255, 113, 177, 241),
                  ),
                ),
                AutoSizeText(
                  text,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 25,
                    color: Color.fromARGB(255, 255, 252, 252),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    kIsWeb
        ? (
            maxHeight = screenSize.height,
            maxWidth = screenSize.height * .60,
          )
        : (
            maxWidth = 500,
            maxHeight = 500,
          );

    return Scaffold(
      body: SafeArea(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              // heightFactor: 1,
              child: Stack(children: [
                Container(
                  height: screenSize.height,
                  width: screenSize.width,
                  constraints: kIsWeb
                      ? BoxConstraints(maxWidth: maxWidth, maxHeight: maxHeight)
                      : null,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: background.image,
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      const Color.fromARGB(255, 10, 241, 214).withOpacity(0.8),
                      BlendMode.darken,
                    ),
                  )),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: screenSize.width * 0.75,
                          height: screenSize.height * 0.5,
                          constraints: BoxConstraints(
                            maxHeight: maxHeight,
                            maxWidth: maxWidth,
                          ),
                          decoration: BoxDecoration(
                            // border: Border.all(
                            //   color: Colors.lightGreen,
                            //   // width: 3,
                            // ),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(40),
                            child:
                                Image(image: mascot.image, fit: BoxFit.cover),
                          ),
                        )
                            .animate(
                              delay: const Duration(milliseconds: 300),
                              onPlay: (controller) => controller.loop(
                                reverse: true,
                                count: 12,
                              ),
                            )
                            .slideX(
                                curve: Curves.easeIn,
                                duration: 1200.ms,
                                begin: 0,
                                end: .005)
                            .slideY(
                                curve: Curves.easeIn,
                                duration: 1200.ms,
                                begin: 0,
                                end: -.01),
                        const SizedBox(height: 10),
                        Container(
                          // To provide both, use "decoration: BoxDecoration(color: color)".)
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 21, 212, 241),
                            borderRadius: BorderRadius.circular(
                                15), // Set the border radius here
                          ),
                          child: GestureDetector(
                            onTap: () => print('Reso'),
                            child: const Text(
                              'Reso',
                              style: TextStyle(
                                color: Colors.white,
                                backgroundColor:
                                    Color.fromARGB(255, 21, 212, 241),
                                fontSize: 40,
                                fontWeight: FontWeight.w100,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Column(
                          children: [
                            buildTextButton(
                              onPressed: () {
                                print('Let\'s play');
                                Navigator.pushNamed(context, '/game');
                              },
                              text: 'Play now',
                              widthMultiplier: 0.4,
                              height: 50,
                            )
                                .animate(
                                  delay: 1.seconds,
                                  onPlay: (controller) => controller.loop(
                                    // reverse: true,
                                    count: 6,
                                  ),
                                )
                                .shimmer(
                                  duration: 2000.ms,
                                  size: .5,
                                  // color: Color.fromARGB(90, 50, 50, 4),
                                  // color: Colors.purple,
                                  // size: 0.1
                                )
                                .animate(
                                  onPlay: (controller) => controller.loop(
                                    reverse: true,
                                    count: 11,
                                  ),
                                )
                                .scaleXY(
                                    begin: 1.03, end: 1, duration: 2.seconds),
                            const SizedBox(height: 10),
                            buildTextButton(
                              onPressed: () => print('hello world'),
                              text: 'こんにちは、世界', // Hello world
                              widthMultiplier: 0.4,
                              height: 50,
                            ),
                            const SizedBox(height: 10),
                            buildTextButton(
                              onPressed: () => print('Settings engaged'),
                              text: 'Settings',
                              widthMultiplier: 0.4,
                              height: 50,
                            ),
                          ]
                              .animate(
                                delay: const Duration(milliseconds: 300),
                                interval: const Duration(milliseconds: 250),
                              )
                              .slideX(curve: Curves.easeIn, begin: -.35
                                  // duration: Duration(seconds: 1))
                                  ),
                          // .slideY(curve: Curves.easeIn)
                          // .fadeIn(),
                        ),
                      ],
                    ),
                  ),
                ),
                const Positioned(
                  right: 20,
                  top: 20,
                  child: MyAudioPlayer(),
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

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
      // Widget is being recreated, dispose old resources and initialize new ones
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
        player.setSource(
            AssetSource('music/rbgm.wav')); // Set audio source if not muted
        player.play(AssetSource('music/rbgm.wav')); // Play audio if not muted
      } // If no value found, default to false
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
        player.play(AssetSource('music/rbgm.wav'));
      }
    });
  }

  void loop() {
    player.setReleaseMode(ReleaseMode.loop);
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return IconButton(
        icon: Icon(isMuted ? Icons.volume_off : Icons.volume_up),
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
              Color.fromARGB(255, 254, 254, 254),
            )),
        onPressed: () async {
          _toggleMute();
        });
  }
}
