import 'dart:async';

import 'package:bmt_ibnusina/models/user.dart';
import 'package:flutter/cupertino.dart';

class Auth {
  static final Auth _this = Auth._();
  static User _user = User();
  static final StreamController<User> _streamController =
      StreamController.broadcast();
  static BuildContext? _context;
  static void user(v) {
    _user = User.fromJson(v);
    _streamController.sink.add(_user);
  }

  static get userData => _user;
  static get streamError => _streamController.addError('error');
  static Stream<User> get streamUser => _streamController.stream;

  factory Auth({context}) {
    _context = context;
    // _streamController.add(userData);
    return _this;
  }

  void dispose() {
    _streamController.close();
  }

  Auth._();
}
