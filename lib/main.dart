import 'package:flutter/material.dart';
import 'package:myapp/pages/home.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  // init the hive
  await Hive.initFlutter();

  await Hive.openBox('blackbox');

  runApp(MaterialApp(
    home: const Home(),
    theme: ThemeData(
      textTheme: GoogleFonts.lexendTextTheme(),
    ),
    debugShowCheckedModeBanner: false,
  ));
}
