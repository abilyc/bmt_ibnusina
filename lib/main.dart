import 'package:bmt_ibnusina/auth/services.dart';
import 'package:bmt_ibnusina/screens/transaksi.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'screens/login.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (!Platform.isAndroid) {
    doWhenWindowReady(() {
      const initialsize = Size(600, 450);
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
    Auth();
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'BMT Ibnu Sina',
        theme: ThemeData(
          primarySwatch: Colors.orange,
          primaryColor: Colors.orange[1200],
          primaryColorLight: Colors.orange[200],
          primaryColorDark: Colors.orange[850],
          backgroundColor: const Color.fromARGB(255, 255, 236, 209),
          canvasColor: Colors.transparent,
          scaffoldBackgroundColor: Colors.transparent,
        ),
        home: Builder(builder: (context) => const Transaksi()));
  }
}
