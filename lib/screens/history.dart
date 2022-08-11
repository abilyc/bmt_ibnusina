import 'package:bmt_ibnusina/models/nasabah_model.dart';
import 'package:flutter/material.dart';

Widget hisstory(Nasabah? data) => DataTable(
    columns: const [
      // DataColumn(label: Text('No.')),
      DataColumn(label: Text('Penyetoran')),
      // DataColumn(label: Text('Penarikan')),
      // DataColumn(label: Text('Transfer')),
      // DataColumn(label: Text('Tgl.'))
    ], 
    // rows: const [
    //   DataRow(cells: [DataCell(Text('data')), DataCell(Text('data')), DataCell(Text('data')), DataCell(Text('data')), DataCell(Text('data'))])
    // ]
    rows: data!.trxIn!.map((e) => DataRow(cells: [DataCell(Text(e.amount.toString()))])).toList(),
  );

