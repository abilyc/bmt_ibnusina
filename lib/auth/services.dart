import 'dart:async';

import 'package:bmt_ibnusina/models/user.dart';
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
    Navigator.pushNamedAndRemoveUntil(_this.context, 'home', (route) => false);
  }

  static get userData => _user;
  static get streamError => _streamController.addError('error');
  static get parentCtx => _this.context;
  static Stream<User> get streamUser => _streamController.stream;

  factory Auth() {
    return _this;
  }

  void dispose() {
    _streamController.close();
  }

  Auth._();
}
