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
      title: 'Salad Scorer',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'Salad Scorer'),
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

  @override
  Widget build(BuildContext context) {
    return Container(
      // Create a background image
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/Salad.jpg'),
          fit: BoxFit.cover,
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent, // Enables the background image to be seen
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          centerTitle: true,
          title: Text(
            widget.title,
            style: const TextStyle(
              color: Colors.black,
              fontFamily: "Rubik",
              fontSize: 40
            ),
          ),
        ),
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 50, bottom: 20),
                width: 250,
                height: 100,
                child: ElevatedButton(
                  onPressed: () {

                  },
                  child: const Text(
                    "New Game",
                    style: TextStyle(
                      fontSize: 40,
                      fontFamily: "Rubik",
                      color: Colors.black,
                    ),
                  )
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, bottom: 50),
                width: 250,
                height: 100,
                child: ElevatedButton(
                  onPressed: () {

                  },
                  child: const Text(
                    "How to Play",
                    style: TextStyle(
                      fontSize: 35,
                      fontFamily: "Rubik",
                      color: Colors.black,
                    ),
                  )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
