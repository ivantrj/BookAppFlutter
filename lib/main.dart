import 'package:flutter/material.dart';
import 'package:flutter_tabs_starter/navigation/router.dart';
import 'package:flutter_tabs_starter/style/style.dart';

void main() async {
  // init hive
  // await Hive.initFlutter();

  // var box = await Hive.openBox('books');

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter App',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
