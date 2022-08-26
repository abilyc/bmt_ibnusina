import 'dart:io';

import 'package:bmt_ibnusina/models/transaksi_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget history(List<Trx> data) {
  final bool isAndroid =  Platform.isAndroid;
  return GridView.count(
    physics: const NeverScrollableScrollPhysics(),
    childAspectRatio: 2.5,
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    mainAxisSpacing: 50,
    crossAxisSpacing: 10,
    primary: true,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      crossAxisCount: isAndroid ? 2 : 4,
      children: List<Widget>.from(data.map((e) => Wrap(
        runSpacing: 10,
        children: [
          Center(child: Text(e.type!.toUpperCase(), style: TextStyle(fontSize: isAndroid ? 11 : 13))),
          Center(child: Text('Rp. ${e.amount}', style: TextStyle(fontWeight: FontWeight.w900, fontSize: isAndroid ? 13 : 15))),
          Center(child: Text(DateFormat('dd-MM-yyyy').format(DateTime.parse(e.date!)).toString(), style: TextStyle(fontSize: isAndroid ? 10 : 12)))
        ],
      ))
    )
  );
}
