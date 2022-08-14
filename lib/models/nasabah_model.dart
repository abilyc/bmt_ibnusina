import 'package:bmt_ibnusina/models/transaksi_model.dart';

class Nasabah {
  String? id;
  String? nama;
  int? balance;
  List<Trx>? history;

  Nasabah({this.nama, this.id, this.balance ,this.history});

  Nasabah.fromJson(Map<String, dynamic> json)
      : nama = json['data']['getTrxByCustomerId']['name'],
        id = json['data']['getTrxByCustomerId']['id'],
        balance = json['data']['getTrxByCustomerId']['balance'],
        history = List<Trx>.from(json['data']['getTrxByCustomerId']['history'].map((e) => Trx.fromJson(e)).toList());

  Map<String, dynamic> toJson() => {'id': id, 'nama': nama, 'balance': balance};

  void clear() {
    id = null;
    nama = null;
    history = null;
  }
}
