import 'package:bmt_ibnusina/auth/hasura.dart';
import 'package:bmt_ibnusina/db/query.dart';
import 'package:bmt_ibnusina/models/customers_model.dart';
import 'package:flutter/foundation.dart';

class Customers with ChangeNotifier {
  List<Customer>? _customers;
  bool _isLoading = false;

  List<Customer> get customers => _customers!;
  bool get isLoading => _isLoading;

  void fetchCustomer() async {
    _isLoading = true;
    final data = await Hasura.query(customerQuery);
    _customers = (data['data']['customer'] as List)
        .map((e) => Customer.fromJson(e))
        .toList();
    _isLoading = false;
    notifyListeners();
  }
}
