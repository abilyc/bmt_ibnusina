import 'package:bmt_ibnusina/auth/services.dart';
import 'package:bmt_ibnusina/tools/wrapper.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'screens/login.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
  if (!Platform.isAndroid) {
    doWhenWindowReady(() {
      const initialSize = Size(300, 450);
      appWindow.minSize = initialSize;
      appWindow.size = initialSize;
      appWindow.alignment = Alignment.center;
      appWindow.title = "BMT IBNU SINA";
      appWindow.show();
    });
  }
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
        home: Builder(builder: (context) {
          Auth.ctx(context);
          return const Wrapper(body: LoginScreen());
        }));
  }
}
