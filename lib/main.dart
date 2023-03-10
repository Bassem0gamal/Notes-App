import 'package:flutter/material.dart';
import 'package:note_app/screens/add_note_screen.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Note App',
      home: const Home(),
      routes: {
        MyNotes.id: (context) => const MyNotes(),
      },
    );
  }
}
