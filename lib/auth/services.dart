// ignore_for_file: prefer_typing_uninitialized_variables
// import 'dart:async';

import 'package:bmt_ibnusina/models/user_model.dart';
import 'package:flutter/material.dart';

class Auth {
  static Auth? _this;
  static Auth get ins => _this!;

  static User? _user;
  // static final StreamController<User> _streamController =
  //     StreamController.broadcast();

  final GlobalKey<ScaffoldState> _parentKey;
  final BuildContext _parentContext;
  static GlobalKey<ScaffoldState> get parentKey => ins._parentKey;
  static BuildContext get parentContext => ins._parentContext;

  static void user(v) {
    _user = User.fromJson(v);
    // _streamController.sink.add(_user);
    Navigator.pushNamedAndRemoveUntil(
        ins._parentContext, 'home', (route) => false);
  }

  static User get userData => _user!;
  // static get streamError => _streamController.addError('error');
  // static BuildContext get parentCtx => context;
  static GlobalKey<ScaffoldState> get prnKey => ins._parentKey;
  // static Stream<User> get streamUser => _streamController.stream;

  Auth._init(this._parentKey, this._parentContext);
  factory Auth([key, context]) => _this ??= Auth._init(key, context);
}
