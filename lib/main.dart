import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_movie_app_origin/screens/catogory_screen.dart';
import 'package:flutter_movie_app_origin/screens/hompage_screen.dart';
import 'package:flutter_movie_app_origin/screens/movie_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // to thid status bar and button
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF0F111D)),
      routes: {
        "/": (context) => const HomePage(),
        "categoryPage": (context) => const CategoryPage(),
        "moviePage": (context) => const MoviePage(),
      },
    );
  }
}
