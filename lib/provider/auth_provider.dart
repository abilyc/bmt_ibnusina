import 'package:bmt_ibnusina/auth/hasura.dart';
import 'package:bmt_ibnusina/db/mutation.dart';
import 'package:bmt_ibnusina/models/user_model.dart';
import 'package:provider/provider.dart';
import 'package:bmt_ibnusina/provider/customer_provider.dart';
import 'package:flutter/material.dart';

class Auth with ChangeNotifier {
  User? user;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void login(BuildContext context, String username, String password) async {
    final customer = context.read<Customers>();
    _isLoading = true;
    notifyListeners();
    try {
      user = User.fromJson(await Hasura.mutate(loginMutation, v: {"username": username, "password": password}));
      Hasura.headers = {'Authorization': 'Bearer ${user!.token}'};
      customer.fetchCustomer();
    } catch(e){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Login Gagal')));
    }
    _isLoading = false;
    notifyListeners();
  }

  void logout(BuildContext context){
    Hasura.headers = null;
    user = null;
    notifyListeners();
  }
}
