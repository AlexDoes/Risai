// ignore_for_file: avoid_print
// ignore: unused_import
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
        '/game': (context) => const GamePage(title: 'Game'),
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

  @override
  void didChangeDependencies() {
    precacheImage(background.image, context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    precacheImage(background.image, context);
    // precacheImage(
    //     const AssetImage('assets/backgrounds/background.png'), context);

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
            Size(screenSize.width * 0.6, height * 1.25),
          ),
          minimumSize: MaterialStateProperty.all<Size?>(
            Size(screenSize.width * 0.5, height * 1.25),
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
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 25,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 4
                      ..color = const Color.fromARGB(255, 113, 177, 241),
                  ),
                )
                // .animate(
                // onPlay: (controller) =>
                // controller.loop(reverse: true, count: 3))
                // .tint(color: Colors.red, blendMode: BlendMode.colorDodge),
                // Solid text as fill.
                ,
                Text(
                  text,
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

    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //   // title: Text(widget.title),
      // ),
      body: Stack(children: [
        Container(
          // height: screenSize.height,
          // width: screenSize.width * 72,
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
              // Column is also a layout widget. It takes a list of children and
              // arranges them vertically. By default, it sizes itself to fit its
              // children horizontally, and tries to be as tall as its parent.
              //
              // Column has various properties to control how it sizes itself and
              // how it positions its children. Here we use mainAxisAlignment to
              // center the children vertically; the main axis here is the vertical
              // axis because Columns are vertical (the cross axis would be
              // horizontal).
              //
              // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
              // action in the IDE, or press "p" in the console), to see the
              // wireframe for each widget.
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: screenSize.width * 0.75,
                  height: screenSize.height * 0.3,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.lightGreen,
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.asset(
                      // 'assets/images/resoplaceholder.png',
                      'assets/images/tp.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  // To provide both, use "decoration: BoxDecoration(color: color)".)
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 21, 212, 241),
                    borderRadius:
                        BorderRadius.circular(15), // Set the border radius here
                  ),
                  child: GestureDetector(
                    onTap: () => print('Reso'),
                    child: const Text(
                      'Reso',
                      style: TextStyle(
                        color: Colors.white,
                        backgroundColor: Color.fromARGB(255, 21, 212, 241),
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
                          onPlay: (controller) => controller.loop(
                            reverse: true,
                            count: 11,
                          ),
                        )
                        // .slide(curve: Curves.easeIn),
                        // .slideY(
                        //     duration: Duration(milliseconds: 1000),
                        //     begin: -0,
                        //     end: .075)
                        // .tint(color: Colors.red, curve: Curves.easeIn)
                        .scaleXY(begin: 1.1, end: 1, duration: 1.seconds),
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
                      .slideX(
                        curve: Curves.easeIn,
                        // duration: Duration(seconds: 1))
                      ),
                  // .slideY(curve: Curves.easeIn)
                  // .fadeIn(),
                ),
                const MyAudioPlayer(),
              ],
            ),
          ),
        ),
      ]),
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
      isMuted = prefs.getBool('isMuted') ?? false;
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
        player.stop(); // Stop audio if muted
      } else {
        player.setSource(
            AssetSource('music/rbgm.wav')); // Set audio source if not muted
        player.play(AssetSource('music/rbgm.wav')); // Play audio if not muted
      }
    });
  }

  void loop() {
    player.setReleaseMode(ReleaseMode.loop);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(isMuted ? Icons.volume_off : Icons.volume_up),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              const Color.fromARGB(255, 21, 212, 241),
            ),
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

class GamePage extends StatefulWidget {
  const GamePage({super.key, required this.title});

  final String title;

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Game Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            buildHiScoreButton(1000),
            const SizedBox(height: 20),
            buildHiScoreButton(2000),
            const SizedBox(height: 20),
            buildHiScoreButton(3000),
            const SizedBox(height: 20),
            buildHiScoreButton(4000),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // setState(() {
          //   _counter++;
          // });
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  TextButton buildHiScoreButton(
    // VoidCallback onPressed,
    int hiScore,
    // double widthMultiplier,
    // double height,
  ) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          const Color.fromARGB(255, 21, 212, 241),
        ),
        minimumSize: MaterialStateProperty.all<Size?>(
          const Size(100, 50),
        ),
      ),
      onPressed: () {
        print(hiScore);
      },
      child: Text(hiScore.toString()),
    );
  }
}
