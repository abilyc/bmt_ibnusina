import 'package:bmt_ibnusina/models/user_model.dart';
import 'package:flutter/material.dart';

class Auth {
  static Auth? _this;
  static Auth get ins => _this!;

  static User? _user;

  static void user(v) => _user = User.fromJson(v);

  static User get userData => _user!;

  factory Auth() => _this ??= Auth();
}
