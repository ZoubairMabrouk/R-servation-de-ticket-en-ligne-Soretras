import 'package:firebase_core/firebase_core.dart';
import 'package:soretras/Signin.dart';
import 'package:flutter/material.dart';
import 'package:soretras/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Soretras',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: Signin(),
    );
  }
}
