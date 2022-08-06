import 'package:bmt_ibnusina/auth/services.dart';
import 'package:bmt_ibnusina/tools/wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrapper(back: false, body: Text("Welcome ${Auth.userData.userName}"));
  }
}
