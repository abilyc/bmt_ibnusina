import 'package:bmt_ibnusina/screens/home.dart';
import 'package:bmt_ibnusina/screens/storan.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'screens/login.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:bmt_ibnusina/db/mutation.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (!Platform.isAndroid) {
    doWhenWindowReady(() {
      const initialsize = Size(600, 480);
      appWindow.size = initialsize;
      appWindow.maxSize = initialsize;
      appWindow.minSize = initialsize;
      appWindow.size = initialsize;
      appWindow.alignment = Alignment.center;
      appWindow.title = "BMT IBNU SINA";
      appWindow.show();
    });
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BMT Ibnu Sina',
      theme: ThemeData(
          primarySwatch: Colors.orange,
          primaryColor: Colors.orange,
          primaryColorLight: Colors.orange[200],
          primaryColorDark: Colors.orange[850],
          disabledColor: Colors.orange[100],
          backgroundColor: const Color.fromARGB(255, 255, 236, 209),
          canvasColor: Colors.transparent,
          scaffoldBackgroundColor: Colors.transparent,
          inputDecorationTheme: const InputDecorationTheme(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 8, vertical: 10)),
          listTileTheme: ListTileThemeData(
            contentPadding: const EdgeInsets.only(left: 25),
            horizontalTitleGap: 5,
            iconColor: Colors.orange[850],
          )),
      routes: {
        'home': (context) => const Home(),
        'login': (context) => const LoginScreen(),
        'setor': (context) => const Penyetoran(mode: 'penyetoran'),
        'penarikan': (context) => const Penyetoran(mode: 'penarikan'),
        'transfer': (context) => const Penyetoran(mode: 'transfer')
      },
      initialRoute: 'login',
    );
  }
}
