import 'dart:async';

import 'package:bmt_ibnusina/models/user.dart';
import 'package:bmt_ibnusina/screens/home.dart';
import 'package:bmt_ibnusina/tools/wrapper.dart';
import 'package:flutter/material.dart';

class Auth {
  static final Auth _this = Auth._();
  static User _user = User();
  static final StreamController<User> _streamController =
      StreamController.broadcast();
  late BuildContext context;
  static void ctx(v) => _this.context = v;
  static void user(v) {
    _user = User.fromJson(v);
    _streamController.sink.add(_user);
    Navigator.pushReplacement(
        _this.context,
        MaterialPageRoute(
            builder: (context) => const Wrapper(body: Home(), menu: true)));
  }

  static get userData => _user;
  static get streamError => _streamController.addError('error');
  static Stream<User> get streamUser => _streamController.stream;

  factory Auth() {
    return _this;
  }

  void dispose() {
    _streamController.close();
  }

  Auth._();
}
