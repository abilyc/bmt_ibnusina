import 'package:bmt_ibnusina/auth/hasura.dart';
import 'package:bmt_ibnusina/db/mutation.dart';
import 'package:bmt_ibnusina/db/query.dart';
import 'package:bmt_ibnusina/models/nasabah_model.dart';
import 'package:flutter/material.dart';

class Storan with ChangeNotifier{
  Nasabah? dataNasabah;
  bool isConfirm = false;
  bool isShowDetail = false;
  bool isEnabled = true;
  bool isLoading = false;

  Future<void> getDetail(BuildContext context, String input) async {
    isShowDetail = false;
    dataNasabah = null;
    isEnabled = false;
    notifyListeners();
    final ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);
    try{
      dataNasabah = Nasabah.fromJson(await Hasura.query(trxQuery, v: {'code':input}));
    }catch(e){
      messenger.showSnackBar(const SnackBar(content: Text('Terjadi Kesalahan')));
    }
    isShowDetail = true;
    isEnabled = true;
    notifyListeners();
  }

}

