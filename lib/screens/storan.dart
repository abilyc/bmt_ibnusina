import 'dart:io';

import 'package:bmt_ibnusina/auth/hasura.dart';
import 'package:bmt_ibnusina/db/mutation.dart';
import 'package:bmt_ibnusina/db/query.dart';
import 'package:bmt_ibnusina/models/customers_model.dart';
import 'package:bmt_ibnusina/models/nasabah_model.dart';
import 'package:bmt_ibnusina/provider/storan_provider.dart';
import 'package:bmt_ibnusina/screens/history.dart';
import 'package:bmt_ibnusina/tools/textfield_custom.dart';
import 'package:bmt_ibnusina/tools/wrapper.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class Penyetoran extends StatefulWidget {
  final String mode;
  const Penyetoran({Key? key, required this.mode}) : super(key: key);

  @override
  State<Penyetoran> createState() => _PenyetoranState();
}

class _PenyetoranState extends State<Penyetoran> {
  bool showDetail = false;
  bool enabled = true;
  bool hasuraLoading = false;
  bool konfirmasi = false;
  bool detailLoading = false;
  bool isLoading = false;
  Nasabah? dataNasabah;
  late List<Customer> customers;
  final TextEditingController noRek = TextEditingController();
  final TextEditingController ref = TextEditingController();
  final TextEditingController desc = TextEditingController();
  final TextEditingController tujuan = TextEditingController();
  final TextEditingController jml = TextEditingController();

  Future getCustomer() async {
    setState(() => isLoading = true);
    final data = await Hasura.query(customerQuery);
    customers = (data['data']['customer'] as List)
        .map((e) => Customer.fromJson(e))
        .toList();
    setState(() => isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    getCustomer();
  }

  @override
  void dispose() {
    // controller.forEach((k, v) => v.dispose());
    noRek.dispose();
    ref.dispose();
    desc.dispose();
    jml.dispose();
    dataNasabah?.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> data = [
      Row(
        children: [
          const SizedBox(
            width: 60,
            child: Text('No. Rek'),
          ),
          Expanded(
            child: RawAutocomplete<Customer>(
              focusNode: FocusNode(),
              textEditingController: noRek,
              onSelected: (e) => searchData(),
              optionsBuilder: (TextEditingValue v) => v
                      .text.isEmpty
                  ? []
                  : customers
                      .where((e) => e.name
                          .toLowerCase()
                          .startsWith(v.text.toLowerCase()))
                      .toList(),
              displayStringForOption: (option) =>
                  option.name,
              fieldViewBuilder: (context,
                      textEditingController,
                      focusNode,
                      onFieldSubmitted) =>
                  TextField(
                    enabled: !isLoading,
                    style: Platform.isAndroid ? const TextStyle(fontSize: 12) : null,
                controller: textEditingController,
                focusNode: focusNode,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 10),
                  isDense: true,
                  isCollapsed: true,
                  fillColor:
                      Theme.of(context).primaryColorLight,
                  filled: true,
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.transparent,
                  )),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                ),
              ),
              optionsViewBuilder: (BuildContext context,
                      AutocompleteOnSelected<Customer>
                          onSelected,
                      Iterable<Customer> options) =>
                  Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 1.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width - 120,
                    color: Colors.amber,
                    child: Material(
                      child: ListView(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        shrinkWrap: true,
                        children: options
                            .map((e) => Listener(
                                onPointerDown: (_) =>
                                    onSelected(e),
                                child: ListTile(
                                    title: Text(e.name))))
                            .toList(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    ];
    List<Widget> detail = [
      const SizedBox(height: 60),
      Text(dataNasabah?.nama != null ? dataNasabah!.nama! : '',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      const SizedBox(height: 30),
      Row(
        children: [
          const SizedBox(
            width: 60,
            child: Text('Ref'),
          ),
          Expanded(
            child: TextFieldCust(enabled: !konfirmasi, controller: ref),
          ),
        ],
      ),
      Row(
        children: [
          const SizedBox(
            width: 60,
            child: Text('Desc'),
          ),
          Expanded(
            child: TextFieldCust(enabled: !konfirmasi, controller: desc),
          ),
        ],
      ),
      if (widget.mode == 'transfer')
        Row(
          children: [
            const SizedBox(
              width: 60,
              child: Text('Tujuan'),
            ),
            Expanded(
              child: TextFieldCust(enabled: !konfirmasi, controller: tujuan),
            ),
          ],
        ),
      Row(
        children: [
          const SizedBox(
            width: 60,
            child: Text('Jumlah'),
          ),
          Expanded(
            child: TextFieldCust(
              keyboardType: TextInputType.number,
              enabled: !konfirmasi,
              controller: jml, inputFormatter: [
              FilteringTextInputFormatter.digitsOnly,
              CurrencyTextInputFormatter(
                locale: 'id',
                decimalDigits: 0,
                symbol: ''
              )
            ]),
          ),
        ],
      )
    ];

    return Wrapper(
      screen: widget.mode.toUpperCase(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Wrap(alignment: WrapAlignment.center, runSpacing: 5, children: [
              ...data,
              const SizedBox(height: 60),
              Consumer<Storan>(builder: (_,v,__) => !v.isEnabled ? const CircularProgressIndicator() : const SizedBox()),
              if (!enabled) const CircularProgressIndicator(),
              if (showDetail) ...detail,
              const SizedBox(height: 60),
              if (showDetail && !konfirmasi)
                SizedBox(
                  height: 40,
                  child: ElevatedButton(
                      onPressed: () => setState(() => konfirmasi = true),
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 5,
                        children: const [
                          Icon(CupertinoIcons.cursor_rays),
                          Text('Konfirmasi')
                        ],
                      )),
                ),
              if (konfirmasi && showDetail && !hasuraLoading)
                Column(
                  children: [
                    const Text('Apakah anda yakin?'),
                    const SizedBox(height: 10),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      SizedBox(
                          height: 40,
                          width: 100,
                          child: ElevatedButton(
                              onPressed: () =>
                                  setState(() => konfirmasi = false),
                              style: const ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.red)),
                              child: Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                spacing: 5,
                                children: const [
                                  Icon(CupertinoIcons.xmark_seal_fill),
                                  Text('Batal'),
                                ],
                              ))),
                      const SizedBox(width: 10),
                      SizedBox(
                          height: 40,
                          width: 100,
                          child: ElevatedButton(
                              onPressed: konfirm,
                              child: Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                spacing: 5,
                                children: const [
                                  Icon(CupertinoIcons.checkmark_seal_fill),
                                  Text('Ok'),
                                ],
                              ))),
                    ]),
                  ],
                ),
              if (hasuraLoading) const CircularProgressIndicator(),
              if (showDetail && dataNasabah?.history != null) ...[
                const SizedBox(height: 95),
                const Center(
                    child: Text('History',
                        style: TextStyle(fontWeight: FontWeight.w800))),
                const SizedBox(height: 40),
                history(dataNasabah!.history!)
              ]
            ]),
            const SizedBox(height: 100)
          ],
        ),
      ),
    );
  }

  void searchData() async {
    dataNasabah?.clear();
    setState(() {
      showDetail = false;
      enabled = false;
    });

    try {
      dataNasabah = Nasabah.fromJson(
          await Hasura.query(trxQuery, v: {'code': noRek.text}));
    } catch (e) {
      showSnackBar('Terjadi Kesalahan');
    }

    setState(() {
      enabled = true;
      if (dataNasabah?.nama != null) showDetail = true;
    });
  }

  void konfirm() async {
    Map<String, dynamic> konfirmData = {
      'penyetoran': [
        setorMutation,
        {
          'reference': ref.text,
          'description': desc.text,
          'amount': int.parse(jml.text.replaceAll('.', '')),
          'date': DateTime.now().toString(),
          'cashIn': dataNasabah!.id
        }
      ],
      'penarikan': [
        penarikanMutation,
        {
          'reference': ref.text,
          'description': desc.text,
          'amount': int.parse(jml.text.replaceAll('.', '')),
          'date': DateTime.now().toString(),
          'cashOut': dataNasabah!.id
        }
      ],
      'transfer': [
        transferMutation,
        {
          'reference': ref.text,
          'description': desc.text,
          'amount': int.parse(jml.text.replaceAll('.', '')),
          'date': DateTime.now().toString(),
          'capitalAccountFROM': dataNasabah!.id,
          'capitalAccountTO': tujuan.text
        }
      ]
    };
    setState(() => hasuraLoading = true);
    // final data;
    try {
      final data = await Hasura.mutate(konfirmData[widget.mode][0],
          v: konfirmData[widget.mode][1]);

      showSnackBar(data['data'][widget.mode]['success']
          ? '${widget.mode[1]} success'
          : '${widget.mode[1]} gagal');

      if (data['data'][widget.mode]['success']) {
        ref.text = '';
        desc.text = '';
        jml.text = '';
        tujuan.text = '';
        noRek.text = '';
      }

      konfirmasi = false;
    } catch (e) {
      showSnackBar('Terjadi Kesalahan');
    }

    setState(() => hasuraLoading = false);
  }

  void showSnackBar(String msg) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
}
