import 'package:bmt_ibnusina/models/transaksi_model.dart';

class Nasabah {
  String? id;
  String? nama;
  List<Trx>? trxIn;
  List<Trx>? trIn;
  List<Trx>? trxOut;
  List<Trx>? trOut;

  Nasabah({this.nama, this.id, this.trxIn, this.trxOut});

  Nasabah.fromJson(Map<String, dynamic> json)
      : nama = json['data']['customer'][0]['name'],
        id = json['data']['customer'][0]['id'],
        trxIn = List<Trx>.from(
            (json['data']['customer'][0]['trx_TABREG_cash_in']).map((e) {
          if (e['customer_cash_out'] == null) return Trx.fromJson(e, 'trxIn');
        })).toList(),
        trIn = List<Trx>.from(
            (json['data']['customer'][0]['trx_TABREG_cash_in']).map((e) {
          if (e['customer_cash_out'] != null) return Trx.fromJson(e, 'trIn');
        })).toList(),
        trxOut = List<Trx>.from(
            (json['data']['customer'][0]['trx_TABREG_cash_out']).map((e) { if(e['customer_cash_out'] == null) return Trx.fromJson(e, 'trxOut');})).toList(),
        trOut = List<Trx>.from(
            (json['data']['customer'][0]['trx_TABREG_cash_out']).map((e) { if(e['customer_cash_out'] != null) return Trx.fromJson(e, 'trOut');})).toList();

  Map<String, dynamic> toJson() => {'id': id, 'nama': nama};

  void clear() {
    id = null;
    nama = null;
    trxIn = null;
    trxOut = null;
  }
}
