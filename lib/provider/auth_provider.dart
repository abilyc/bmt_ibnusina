import 'package:bmt_ibnusina/auth/hasura.dart';
import 'package:bmt_ibnusina/db/mutation.dart';
import 'package:bmt_ibnusina/models/user_model.dart';
import 'package:flutter/material.dart';

class Auth with ChangeNotifier {
  User? _user;
  User? get user => _user;
  String? get token => _user?.token;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void login(BuildContext context, String username, String password) async {
    final nav = Navigator.of(context);
    _isLoading = true;
    notifyListeners();
    try {
      _user = User.fromJson(await Hasura.mutate(loginMutation, v: {"username": username, "password": password}));
      nav.popAndPushNamed('home');
    } catch(e){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Login Gagal')));
    }
    _isLoading = false;
    notifyListeners();
  }

  void logout(BuildContext context, String username, String password){
    Navigator.pushNamedAndRemoveUntil(context, 'login', ModalRoute.withName('home'));
    _user = null;
    notifyListeners();
  }
}
