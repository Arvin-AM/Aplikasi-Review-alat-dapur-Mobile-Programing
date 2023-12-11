import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:uas/login/login.dart';
import 'package:uas/pages/ItemPage.dart';
import 'package:uas/pages/KategoriPage.dart';

late final FirebaseApp app;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  app = await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyBI6NqQbdkX14iwchVN7gjbn8K2Y5Dv3ag",
          appId: "1:40328635324:android:ed9f731d4eb4e50fe8c1b9",
          messagingSenderId: "40328635324",
          projectId: "project-akhir-50469"));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Colors.cyan[200]),
      home: Login(),
      routes: {
        "itemPage": (context) => ItemPage(itemId: ""),
        "kategoriPage": (context) => KategoriPage(),
      },
    );
  }
}
