import 'package:bmt_ibnusina/models/transaksi_model.dart';
import 'package:flutter/material.dart';

Widget history(List<Trx> data) {
  return GridView.count(
    physics: const NeverScrollableScrollPhysics(),
    childAspectRatio: 2.5,
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    mainAxisSpacing: 15,
    crossAxisSpacing: 10,
    primary: true,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      crossAxisCount: 2,
      children: List<Widget>.from(data.map((e) => Wrap(
        runSpacing: 10,
        children: [
          Center(child: Text(e.type!.toUpperCase())),
          Center(child: Text('Rp. ${e.amount}', style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18))),
          Center(child: Text('${e.date}'))
        ],
      )))
  );
}
