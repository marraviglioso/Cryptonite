import 'package:cryptonite/screens/about_page.dart';
import 'package:flutter/material.dart';
import 'package:cryptonite/screens/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cryptonite',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: const Color(0xFFEFEFEF),
      ),
      home: const HomeScreen(),
      routes: {
        '/home': (BuildContext context) => const HomeScreen(),
        '/about': (BuildContext context) => const AboutScreen(),
      },
    );
  }
}
