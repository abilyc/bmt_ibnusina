import 'package:bmt_ibnusina/models/transaksi_model.dart';

class Nasabah {
  String? id;
  String? nama;
  List<Trx>? trxIn;
  List<Trx>? trxOut;

  Nasabah({this.nama, this.id, this.trxIn, this.trxOut});

  Nasabah.fromJson(Map<String, dynamic> json)
      : nama = json['data']['customer'][0]['name'],
        id = json['data']['customer'][0]['id'],
        trxIn = List<Trx>.from(
            (json['data']['customer'][0]['trx_TABREG_cash_in']).map((e)=>Trx.fromJson(e))).toList(),
        trxOut = List<Trx>.from(
            (json['data']['customer'][0]['trx_TABREG_cash_out']).map((e)=>Trx.fromJson(e))).toList();

  Map<String, dynamic> toJson() => {'id': id, 'nama': nama};

  void clear() {
    id = null;
    nama = null;
    trxIn = null;
    trxOut = null;
  }
}
