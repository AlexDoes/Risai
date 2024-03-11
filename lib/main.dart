// ignore_for_file: avoid_print
// ignore: unused_import
import 'dart:js' as js;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:reso/pages/unity_web_game_page.dart';
import 'package:reso/pages/testpage.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:reso/localization/language.dart';
import 'package:reso/widget/musicplayer.dart';
import 'package:provider/provider.dart';
import 'package:reso/providers/languageprovider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    // precacheImage((bg), context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Risai',
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
        '/test': (context) => ThreeColumnsLayout(),
      },
      home: MyHomePage(title: 'Risai'),
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
  final mascotShadow = Image.asset("assets/images/mascotshadow.png");
  final coffeecup = Image.asset("assets/images/coffeecup.png");
  final plasticbag = Image.asset("assets/images/plasticbag.png");
  final toiletpaper = Image.asset("assets/images/toiletpaper.png");
  final chips = Image.asset("assets/images/chips.png");
  final milkcarton = Image.asset("assets/images/milkcarton.png");
  final waterbottle = Image.asset("assets/images/waterbottle.png");
  final sodacan = Image.asset("assets/images/sodacan.png");
  final newspaper = Image.asset("assets/images/newspaper.png");
  late double maxWidth;
  late double maxHeight;
  String currentLanguage = 'English';
  @override
  void didChangeDependencies() {
    precacheImage(background.image, context);
    super.didChangeDependencies();
  }

  // @override
  // void initState() {}

  @override
  Widget build(BuildContext context) {
    print(Provider.of<LanguageProvider>(context).language);

    String lang = (Localizations.localeOf(context).toString());

    if (lang.contains('ja-JP') || lang.contains('ja')) {
      Provider.of<LanguageProvider>(context, listen: false)
          .setLanguage('Japanese');
    }

    currentLanguage = Provider.of<LanguageProvider>(context).language;

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
        ? (maxHeight = screenSize.height, maxWidth = 500)
        : (
            maxWidth = 500,
            maxHeight = 500,
          );

    return Scaffold(
      body: SafeArea(
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                flex: 1,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromARGB(255, 173, 251, 254),
                        Color.fromARGB(255, 202, 247, 196),
                        Color.fromARGB(255, 202, 247, 196),
                      ],
                    ),
                  ),
                )),
            Center(
              // heightFactor: 1,
              child: Stack(children: [
                Container(
                  height: screenSize.height,
                  width: screenSize.width < 400 ? 400 : screenSize.width,
                  constraints: kIsWeb
                      ? BoxConstraints(
                          maxWidth: maxWidth,
                          maxHeight: maxHeight,
                          minWidth: 400,
                          minHeight: 700,
                        )
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
                          alignment: Alignment.center,
                          width: screenSize.width * 0.6,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 73, 94, 97),
                            backgroundBlendMode: BlendMode.overlay,
                            borderRadius: BorderRadius.circular(
                                15), // Set the border radius here
                          ),
                          child: GestureDetector(
                            onTap: () => print('Reso'),
                            child: Text(
                              languageLines[currentLanguage]!['title']!,
                              style: const TextStyle(
                                color: Colors.white,
                                // backgroundColor:
                                // Color.fromARGB(255, 21, 212, 241),
                                fontSize: 35,
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
                              text: languageLines[currentLanguage]!['play']!,
                              widthMultiplier: 0.4,
                              height: 50,
                            )
                                .animate(
                                  delay: 1.seconds,
                                  onPlay: (controller) => controller.loop(
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
                              onPressed: () => print(
                                {currentLanguage, 'hello'},
                              ),
                              text: languageLines[currentLanguage]![
                                  'init']!, // Hello world
                              widthMultiplier: 0.4,
                              height: 50,
                            ),
                            const SizedBox(height: 10),
                            buildTextButton(
                              onPressed: () => {
                                Provider.of<LanguageProvider>(context,
                                        listen: false)
                                    .toggleLanguage(),
                                js.context.callMethod('eval', [
                                  "document.title = `${languageLines[currentLanguage == "English" ? "Japanese" : "English"]!['title']!}`"
                                ])
                              },
                              text:
                                  languageLines[currentLanguage]!['language']!,
                              widthMultiplier: 0.4,
                              height: 50,
                            ),
                          ]
                              .animate(
                                delay: const Duration(milliseconds: 300),
                                interval: const Duration(milliseconds: 250),
                              )
                              .slideX(curve: Curves.easeIn, begin: -.35),
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
            Expanded(
                flex: 1,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromARGB(255, 173, 251, 254),
                        Color.fromARGB(255, 202, 247, 196),
                        Color.fromARGB(255, 202, 247, 196),
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
