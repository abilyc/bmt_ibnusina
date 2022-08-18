import 'package:bmt_ibnusina/models/user_model.dart';
import 'package:flutter/material.dart';

class Auth {
  static Auth? _this;
  static Auth get ins => _this!;

  static User? _user;
  final GlobalKey<ScaffoldState> _parentKey;
  final BuildContext _parentContext;
  static GlobalKey<ScaffoldState> get parentKey => ins._parentKey;
  static BuildContext get parentContext => ins._parentContext;

  static void user(v) {
    _user = User.fromJson(v);
    Navigator.pushNamedAndRemoveUntil(
        ins._parentContext, 'home', (route) => false);
  }

  static User get userData => _user!;
  static GlobalKey<ScaffoldState> get prnKey => ins._parentKey;

  Auth._init(this._parentKey, this._parentContext);
  factory Auth([key, context]) => _this ??= Auth._init(key, context);
}
