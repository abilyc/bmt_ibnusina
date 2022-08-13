import 'package:bmt_ibnusina/models/nasabah_model.dart';
import 'package:bmt_ibnusina/models/transaksi_model.dart';
import 'package:flutter/material.dart';

Widget history(List<Trx>? data, String mode) {
  late List<DataColumn> kolom;
  switch (mode) {
    case 'penyetoran':
      kolom = [
        const DataColumn(label: Text('Penyetoran')),
        // const DataColumn(label: Text('Transfer Masuk'))
      ];
      break;
    case 'penarikan':
      kolom = [
        const DataColumn(label: Text('Penarikan')),
        // const DataColumn(label: Text('Transfer Keluar'))
      ];
      break;
    case 'transfer':
      kolom = [
        const DataColumn(label: Text('Transfer Masuk')),
        // const DataColumn(label: Text('Transfer Keluar'))
      ];
      break;
    default:
  }
  return DataTable(
    columns: kolom,
    // rows: const [DataRow(cells: [DataCell(Text('data')), DataCell(Text('data'))])],
    rows: data!.map((e)=>DataRow(cells: [DataCell(Text('${e.amount}'))])).toList()
  );
}
