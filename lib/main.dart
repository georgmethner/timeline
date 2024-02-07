import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:service_reddit_2/pages/login.dart';
import 'package:service_reddit_2/pages/scroll_calendar.dart';
import 'package:service_reddit_2/utilities/entry_manager.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
  FirebaseFirestore.instance.enablePersistence(const PersistenceSettings(synchronizeTabs: true));

  initializeDateFormatting("de");

  await EntryManager.start();

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
          seedColor: Colors.amber,
          // ···
          brightness: Brightness.dark,
        ),
        textTheme: const TextTheme(
            titleLarge: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            headlineSmall: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFAAE78B))),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FirebaseAuth.instance.currentUser != null ? ScrollCalendar() : const Login();
  }
}
