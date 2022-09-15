import 'dart:io';

import 'package:bmt_ibnusina/models/customers_model.dart';
import 'package:bmt_ibnusina/provider/customer_provider.dart';
import 'package:bmt_ibnusina/provider/storan_provider.dart';
import 'package:bmt_ibnusina/screens/history.dart';
import 'package:bmt_ibnusina/tools/my_formatter.dart';
import 'package:bmt_ibnusina/tools/textfield_custom.dart';
import 'package:bmt_ibnusina/tools/wrapper.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Stor extends StatelessWidget {
  final String mode;
  const Stor({super.key, required this.mode});

  @override
  Widget build(BuildContext context) {
    final TextEditingController noRek = TextEditingController();
    final TextEditingController ref = TextEditingController();
    final TextEditingController desc = TextEditingController();
    final TextEditingController date = TextEditingController();
    final TextEditingController tujuan = TextEditingController();
    final TextEditingController jml = TextEditingController();
    final customers = context.watch<Customers>().customers;
    context.read<Storan>().init(context, mode, [ref, desc, date, jml, tujuan]);
    context.read<Storan>().isShowDetail = context.read<Storan>().isShowDetail == true ? false : false;
    
    return Wrapper(
      screen: mode.toUpperCase(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Wrap(
              alignment: WrapAlignment.center,
              runSpacing: 5,
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 60,
                      child: Text('Code'),
                    ),
                    Expanded(
                      child: RawAutocomplete<Customer>(
                        focusNode: FocusNode(),
                        textEditingController: noRek,
                        onSelected: (e) => context.read<Storan>().getDetail(e.code),
                        optionsBuilder: (TextEditingValue v) => v
                                .text.isEmpty
                            ? []
                            : customers!
                                .where((e) => e.code
                                    .toLowerCase()
                                    .startsWith(v.text.toLowerCase()))
                                .toList(),
                        displayStringForOption: (option) =>
                            option.code,
                        fieldViewBuilder: (context,
                                textEditingController,
                                focusNode,
                                onFieldSubmitted) =>
                            TextField(
                              enabled: !context.watch<Customers>().isLoading,
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
                                              title: Text(e.code))))
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
                const SizedBox(height: 60),
              ],
            ),
            Consumer<Storan>(
              builder: (_, v, child) { 
                if(v.isLoading) return const Center(child: CircularProgressIndicator());
                if(!v.isLoading && v.isShowDetail){
                  return Wrap(
                    alignment: WrapAlignment.center,
                    runSpacing: 5,
                    children: [
                      const SizedBox(height: 20),
                      Text(v.dataNasabah!.nama!,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(width: double.infinity),
                      Text("Rp. ${CurrencyTextInputFormatter(locale: 'id',decimalDigits: 0,symbol: '').format(v.dataNasabah!.balance!.toString())}",
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          const SizedBox(
                            width: 60,
                            child: Text('Ref'),
                          ),
                          Expanded(
                            child: TextFieldCust(enabled: !v.isConfirm, controller: ref, onChanged: (e) => v.checkValue()),
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
                            child: TextFieldCust(enabled: !v.isConfirm, controller: desc, onChanged: (e) => v.checkValue()),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 60,
                            child: Text('date'),
                          ),
                          Expanded(
                            child: TextFieldCust(
                              enabled: !v.isConfirm,
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2019),
                                    lastDate: DateTime(2025));
                                if (pickedDate != null) {
                                  date.text = DateFormat('dd-MM-yyyy').format(pickedDate);
                                  v.checkValue();
                                }
                              },
                              controller: date,
                              keyboardType: TextInputType.datetime,
                              inputFormatter: [
                                MyFormatter(sample: 'xx-xx-xxxx', sparator: '-')
                              ],
                            )
                          ),
                        ],
                      ),
                      if (mode == 'transfer')
                        Row(
                          children: [
                            const SizedBox(
                              width: 60,
                              child: Text('Tujuan'),
                            ),
                            Expanded(
                              child: TextFieldCust(enabled: !v.isConfirm, controller: tujuan, onChanged: (e) => v.checkValue()),
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
                              onChanged: (e) => v.checkValue(),
                              enabled: !v.isConfirm,
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
                      ),
                      if(!v.isConfirm)
                      SizedBox(
                        height: 40,
                        child: ElevatedButton(
                          onPressed: !v.konfimasiButton ? null : () => v.setConfirm = true,
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            spacing: 5,
                            children: const [
                              Icon(CupertinoIcons.cursor_rays),
                              Text('Konfirmasi')
                            ],
                          )
                        ),
                      ),
                      if(v.isConfirm && !v.hasuraLoading)
                      Column(
                        children: [
                          const Text('Apakah anda yakin?'),
                          const SizedBox(height: 10),
                          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                            SizedBox(
                                height: 40,
                                width: 100,
                                child: ElevatedButton(
                                    onPressed: () => v.setConfirm = false,
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
                                onPressed: () => context.read<Storan>().konfirm(),
                                child: Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  spacing: 5,
                                  children: const [
                                    Icon(CupertinoIcons.checkmark_seal_fill),
                                    Text('Ok'),
                                  ],
                                )
                              )
                            ),
                          ]),
                        ],
                      ),
                    if (v.hasuraLoading) const CircularProgressIndicator(),
                    if (v.isShowDetail && v.dataNasabah!.history!.isNotEmpty) ...[
                      const SizedBox(height: 90),
                      const Center(
                          child: Text('History',
                              style: TextStyle(fontWeight: FontWeight.w800))),
                      const SizedBox(height: 40),
                      history(v.dataNasabah!.history!),

                    ],
                    const SizedBox(height: 200)
                    ],
                  );
                }
                return const SizedBox();
                },
              child: const SizedBox(height: 100),
            ),
          ]
        ),
      )
    );
  }
}