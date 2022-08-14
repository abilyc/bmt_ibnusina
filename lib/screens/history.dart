import 'package:bmt_ibnusina/models/transaksi_model.dart';
import 'package:flutter/material.dart';

Widget history(List<Trx> data) => GridView.count(
  padding: const EdgeInsets.symmetric(horizontal: 10),
  crossAxisCount: 2,
  children: data.map((e) => Column(
    children: [
      Row(
        children: [
          Text(e.type!),
          Text(e.ref!),
          Text('${e.amount!}')
        ],
      ),
    ],
  )).toList()
); 
