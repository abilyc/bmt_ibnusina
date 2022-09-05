import 'package:bmt_ibnusina/provider/auth_provider.dart';
import 'package:bmt_ibnusina/provider/customer_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (BuildContext context) => Customers()),
  ChangeNotifierProvider(create: (BuildContext context) => Auth()),
];
