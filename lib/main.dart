// Main app
// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/widgets/app_theme.dart';
import 'screens/todo_screen.dart';



void main() {
  runApp(
    ProviderScope(  // Essential: Wrap your app in ProviderScope
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  void _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    });
  }

  void _toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
    prefs.setBool('isDarkMode', _isDarkMode);
  }
  @override
  Widget build(BuildContext context,) {

      
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo List',
      theme: Apptheme.lightTheme(),
      darkTheme: Apptheme.darkTheme(),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      // theme: ThemeData(
      //   primarySwatch: Colors.teal,
      //   useMaterial3: true,
      // ),
      home: TodoScreen( _isDarkMode, _toggleTheme),
    );
  }
}
