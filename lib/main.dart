import 'dart:math';

import 'package:flutter/material.dart';

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
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 20, 255, 118)),
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    ElevatedButton buildElevatedButton({
      required VoidCallback onPressed,
      required String text,
      required double widthMultiplier,
      required double height,
    }) {
      return ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          maximumSize: MaterialStateProperty.all<Size?>(
            Size(screenSize.width * 0.9, double.infinity),
          ),
          minimumSize: MaterialStateProperty.all<Size?>(
            Size(screenSize.width * widthMultiplier, height),
          ),
        ),
        child: Text(text),
      );
    }

    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //   // title: Text(widget.title),
      // ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: const AssetImage('assets/backgrounds/background.png'),
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
                // width: screenSize.width * 0.75,
                // height: screenSize.height * 0.3,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.lightGreen,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Image.asset(
                  'assets/images/demo-button-2.png',
                  fit: BoxFit.cover,
                ),
              ),
              const Text(
                'You have pushed the button this many times:',
                style: TextStyle(
                    color: Colors.white, backgroundColor: Colors.black),
              ),
              const SizedBox(height: 10), // Add vertical space between buttons
              buildElevatedButton(
                onPressed: () => log(1),
                text: 'Play now',
                widthMultiplier: 0.4,
                height: 50,
              ),
              const SizedBox(height: 10), // Add vertical space between buttons
              buildElevatedButton(
                onPressed: () => log(1),
                text: 'Leaderboard',
                widthMultiplier: 0.4,
                height: 50,
              ),
              const SizedBox(height: 10), // Add vertical space between buttons
              buildElevatedButton(
                onPressed: () => log(1),
                text: 'Settings',
                widthMultiplier: 0.4,
                height: 50,
              ),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
