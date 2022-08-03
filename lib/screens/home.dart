import 'package:bmt_ibnusina/auth/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Welcome ${Auth.userData.userName}"),
    );
  }
}
