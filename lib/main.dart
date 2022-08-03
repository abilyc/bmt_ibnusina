import 'package:bmt_ibnusina/auth/services.dart';
import 'package:bmt_ibnusina/models/user.dart';
import 'package:bmt_ibnusina/screens/home.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'screens/login.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
  if (!Platform.isAndroid) {
    doWhenWindowReady(() {
      const initialSize = Size(600, 450);
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
    Auth(context: context);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'BMT Ibnu Sina',
        theme: ThemeData( 
          primarySwatch: Colors.orange,
          canvasColor: Colors.transparent,
          scaffoldBackgroundColor: Colors.transparent,
        ),
        home: SafeArea(
          child: Scaffold(
              appBar: AppBar(
                title: const Text('BMT IBNU SINA'),
                centerTitle: true,
              ),
              body: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                      // borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.0)),
                      color: Colors.white),
                  child: StreamBuilder(
                      stream: Auth.streamUser,
                      builder: (context, AsyncSnapshot<User> snapshot) {
                        if (snapshot.hasData) {
                          return const Home();
                        }else{
                          return const LoginScreen();
                        }
                      }))),
        ));
  }
}
