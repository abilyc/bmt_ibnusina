import 'package:bmt_ibnusina/tools/wrapper.dart';
import 'package:bmt_ibnusina/provider/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrapper(back: false, body: Text("Welcome ${context.read<Auth>().user!.userName}"), screen: 'Home');
  }
}
