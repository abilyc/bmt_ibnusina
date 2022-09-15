import 'package:bmt_ibnusina/auth/hasura.dart';
import 'package:bmt_ibnusina/db/mutation.dart';
import 'package:bmt_ibnusina/db/query.dart';
import 'package:bmt_ibnusina/models/nasabah_model.dart';
import 'package:bmt_ibnusina/provider/customer_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


class Storan with ChangeNotifier{
  Nasabah? dataNasabah;
  List<TextEditingController>? controller;
  String? mode;
  BuildContext? ctx;
  bool isConfirm = false;
  bool isShowDetail = false;
  bool isEnabled = true;
  bool isLoading = false;
  bool hasuraLoading = false;
  bool konfimasiButton = false;

  set setConfirm(bool data) {
    isConfirm = data;
    notifyListeners();
  }

  void checkValue(){
    bool result = controller!.getRange(0, mode != 'transfer' ? 4 : 5).where((e) => e.text == '').isEmpty;
    if(konfimasiButton != result){
      konfimasiButton = result;
      notifyListeners();
    }
  }

  void init(BuildContext ctx, String mode, List<TextEditingController> input){
    controller = input;
    this.mode = mode;
    this.ctx = ctx;
  }

  Future<void> getDetail(String input) async {
    isLoading = true;
    isShowDetail = false;
    dataNasabah = null;
    notifyListeners();
    final ScaffoldMessengerState messenger = ScaffoldMessenger.of(ctx!);
    try{
      dataNasabah = Nasabah.fromJson(await Hasura.query(trxQuery, v: {'code':input}));
      isShowDetail = true;
      notifyListeners();

    }catch(e){
      messenger.showSnackBar(const SnackBar(content: Text('Terjadi Kesalahan')));
    }
    isLoading = false;
    konfimasiButton = false;
    notifyListeners();
  }

  void konfirm() async {
    final snackbar = ScaffoldMessenger.of(ctx!);
    final ctxRead = ctx!.read<Customers>();
    Map<String, dynamic> konfirmData = {
      'penyetoran': [
        setorMutation,
        {
          'reference': controller![0].text,
          'description': controller![1].text,
          'date': DateFormat('dd-MM-yyyy').parse(controller![2].text).toString(),
          'amount': int.parse(controller![3].text.replaceAll('.', '')),
          'cashIn': dataNasabah!.id
        }
      ],
      'penarikan': [
        penarikanMutation,
        {
          'reference': controller![0].text,
          'description': controller![1].text,
          'date': DateFormat('dd-MM-yyyy').parse(controller![2].text).toString(),
          'amount': int.parse(controller![3].text.replaceAll('.', '')),
          'cashOut': dataNasabah!.id
        }
      ],
      'transfer': [
        transferMutation,
        {
          'reference': controller![0].text,
          'description': controller![1].text,
          'date': DateFormat('dd-MM-yyyy').parse(controller![2].text).toString(),
          'amount': int.parse(controller![3].text.replaceAll('.', '')),
          'capitalAccountFROM': dataNasabah!.id,
          'capitalAccountTO': controller![4].text
        }
      ]
    };
    hasuraLoading = true;
    notifyListeners();
    // final data;
    try {
      final data = await Hasura.mutate(konfirmData[mode][0],
          v: konfirmData[mode][1]);

      snackbar.showSnackBar(SnackBar(content: Text(data['data'][mode]['success']
          ? '$mode success'
          : '$mode gagal')));

      if (data['data'][mode]['success']) {
        controller![0].text = '';
        controller![1].text = '';
        controller![2].text = '';
        controller![3].text = '';
        controller![4].text = '';
      }

      isConfirm = false;
      notifyListeners();
    } catch (e) {
      snackbar.showSnackBar(const SnackBar(content: Text('Terjadi Kesalahan')));
    }

    hasuraLoading = false;
    notifyListeners();

    try{
      dataNasabah = Nasabah.fromJson(await Hasura.query(trxQuery, v: {'code':ctxRead.customers!.where((e) => e.name == dataNasabah!.nama).first.code}));
      notifyListeners();
    }catch(e){
      snackbar.showSnackBar(const SnackBar(content: Text('Tidak dapat mengambil data nasabah')));
    }
  }


}

