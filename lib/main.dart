import 'dart:ui';

import 'package:file_storage_mini_project/home/appTheme/theme_const_for_storage.dart';
import 'package:file_storage_mini_project/home/homePage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home/appTheme/appTheme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences sharedPrefernces =
      await SharedPreferences.getInstance();
  runApp(
    MyApp(sharedPreferences: sharedPrefernces),
  );
}

class MyApp extends StatefulWidget {
  final SharedPreferences sharedPreferences;

  const MyApp({
    super.key,
    required this.sharedPreferences,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final String? theme = widget.sharedPreferences
        .getString(keyForGetTheme);

    return MaterialApp(
      scrollBehavior: ScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.trackpad,
        },
      ),
      title: 'Flutter Demo',
      themeMode: getTheme(theme),
      theme: AppTheme.lightTheme(),
      darkTheme: AppTheme.dartTheme(),
      home: Homepage(
        themeChange: (theme) {
          widget.sharedPreferences.setString(
            keyForGetTheme,
            theme,
          );

          setState(() {
            getTheme(theme);
          });
        },
      ),
    );
  }

  ThemeMode getTheme(String? theme) {
    switch (theme) {
      case "light":
        return ThemeMode.light;

      case "dark":
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}
