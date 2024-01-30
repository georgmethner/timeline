import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:service_reddit_2/components/appbar.dart';
import 'package:service_reddit_2/pages/login.dart';

import 'pages/calendar.dart';
import 'pages/register.dart';
import 'firebase_options.dart';
import 'components/day.dart';

Future<void> main() async {
  //Initialize Firebase
  await Firebase.initializeApp( options: DefaultFirebaseOptions.currentPlatform, );
  await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);


  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.orangeAccent,
          // ···
          brightness: Brightness.dark,
        ),
        textTheme: const TextTheme(titleLarge: TextStyle(fontWeight: FontWeight.bold, color: Colors.white), headlineSmall: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFAAE78B))),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FirebaseAuth.instance.currentUser != null ? Calendar() : Login();
  }

}


