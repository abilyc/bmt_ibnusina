import 'dart:io';

import 'package:bmt_ibnusina/auth/hasura.dart';
import 'package:bmt_ibnusina/db/mutation.dart';
import 'package:bmt_ibnusina/db/query.dart';
import 'package:bmt_ibnusina/models/customers_model.dart';
import 'package:bmt_ibnusina/tools/my_formatter.dart';
import 'package:bmt_ibnusina/tools/textfield_custom.dart';
import 'package:bmt_ibnusina/tools/wrapper.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class BatchPenarikan extends StatefulWidget {
  const BatchPenarikan({super.key});

  @override
  State<BatchPenarikan> createState() => _BatchPenarikanState();
}

class _BatchPenarikanState extends State<BatchPenarikan> {
  int counter = 0;
  bool konfirmasi = false;
  bool isLoading = false;
  bool loading = false;
  // String? _selected;
  late List<Customer> customers;
  final List<TextEditingController> codeController = [TextEditingController()];
  final List<FocusNode> node = [FocusNode()];
  final List<TextEditingController> amountController = [
    TextEditingController()
  ];
  final List<TextEditingController> balanceController = [
    TextEditingController()
  ];
  final List<TextEditingController> idController = [TextEditingController()];

  final List<TextEditingController> refDateDesc = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];

  void mutate() async {
    setState(() => loading = true);
    final List<Map<String, dynamic>> data = [];
    for (int i = 0; i < idController.length; i++) {
      if (codeController[i].text.isNotEmpty) {
        data.add({
          'customerId': idController[i].text,
          'amount': int.parse(amountController[i].text.replaceAll('.', ''))
        });
      }
    }

    final message = ScaffoldMessenger.of(context);

    try {
      await Hasura.mutate(batchPenarikanMutation, v: {
        'date': DateFormat('yyyy-MM-dd').parse(refDateDesc[1].text).toString(),
        'description': refDateDesc[2].text,
        'reference': refDateDesc[0].text,
        'input': data
      });
      message.showSnackBar(const SnackBar(content: Text('Berhasil')));
    } catch (e) {
      message.showSnackBar(const SnackBar(content: Text('Gagal')));
    }
    setState(() {
      loading = false;
      konfirmasi = false;
    });
  }

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
    getCustomer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double width = Platform.isAndroid ? 85 : 150;
    final halfWidth = !Platform.isAndroid
        ? (MediaQuery.of(context).size.width - 50) / 2
        : 150.0;

    return Wrapper(
        screen: 'BATCH PENARIKAN',
        body: SingleChildScrollView(
          child: Column(children: [
            Wrap(
              spacing: 10,
              runSpacing: 5,
              children: [
                SizedBox(
                  width: halfWidth,
                  child: Row(
                    children: [
                      const SizedBox(width: 40, child: Text('Ref')),
                      Expanded(child: TextFieldCust(controller: refDateDesc[0]))
                    ],
                  ),
                ),
                SizedBox(
                  width: halfWidth,
                  child: Row(
                    children: [
                      const SizedBox(width: 40, child: Text('Date')),
                      Expanded(
                          child: TextFieldCust(
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101));
                          if (pickedDate != null) {
                            refDateDesc[1].text =
                                DateFormat('dd-MM-yyyy').format(pickedDate);
                          }
                        },
                        controller: refDateDesc[1],
                        keyboardType: TextInputType.datetime,
                        inputFormatter: [
                          MyFormatter(sample: 'xx-xx-xxxx', sparator: '-')
                        ],
                      ))
                    ],
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: [
                      const SizedBox(width: 40, child: Text('Desc')),
                      Expanded(child: TextFieldCust(controller: refDateDesc[2]))
                    ],
                  ),
                ),
                const SizedBox(height: 10, width: double.infinity),
                if (!isLoading)
                  Container(
                    padding:
                        const EdgeInsets.only(top: 30, left: 20, right: 20),
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // for (int i = 0; i <= counter; i++)
                        // ...[
                        //   SizedBox(
                        //     width: halfWidth - 40,
                        //     child: Row(
                        //       children: [
                        //         const SizedBox(width: 40, child: Text('Code')),
                        //         Expanded(
                        //           child: RawAutocomplete<Customer>(
                        //             focusNode: node[i],
                        //             textEditingController: codeController[i],
                        //             onSelected: (e) => idController[i].text = e.id,
                        //             optionsBuilder: (TextEditingValue v) =>
                        //                 v.text.isEmpty
                        //                     ? []
                        //                     : customers
                        //                         .where((e) => e.name
                        //                             .toLowerCase()
                        //                             .startsWith(v.text.toLowerCase()))
                        //                         .toList(),
                        //             displayStringForOption: (option) => option.name,
                        //             fieldViewBuilder: (context, textEditingController,
                        //                     focusNode, onFieldSubmitted) =>
                        //                 TextField(
                        //               controller: textEditingController,
                        //               focusNode: focusNode,
                        //               decoration: InputDecoration(
                        //                 isDense: true,
                        //                 isCollapsed: true,
                        //                 contentPadding: const EdgeInsets.symmetric(
                        //                     vertical: 8, horizontal: 10),
                        //                 fillColor: Theme.of(context).primaryColorLight,
                        //                 filled: true,
                        //                 enabledBorder: const OutlineInputBorder(
                        //                     borderSide: BorderSide(
                        //                   color: Colors.transparent,
                        //                 )),
                        //                 focusedBorder: const OutlineInputBorder(
                        //                   borderSide: BorderSide(
                        //                     color: Colors.transparent,
                        //                   ),
                        //                 ),
                        //               ),
                        //             ),
                        //             optionsViewBuilder: (BuildContext context,
                        //                     AutocompleteOnSelected<Customer> onSelected,
                        //                     Iterable<Customer> options) =>
                        //                 Align(
                        //               alignment: Alignment.topLeft,
                        //               child: Padding(
                        //                 padding: const EdgeInsets.only(top: 2.0),
                        //                 child: Container(
                        //                   width: halfWidth,
                        //                   color: Colors.amber,
                        //                   child: Material(
                        //                     child: ListView(
                        //                       shrinkWrap: true,
                        //                       children: options
                        //                           .map((e) => Listener(
                        //                               onPointerDown: (_) =>
                        //                                   onSelected(e),
                        //                               child: ListTile(
                        //                                   title: Text(e.name))))
                        //                           .toList(),
                        //                     ),
                        //                   ),
                        //                 ),
                        //               ),
                        //             ),
                        //           ),
                        //         )
                        //       ],
                        //     ),
                        //   ),
                        //   SizedBox(
                        //     width: halfWidth,
                        //     child: Row(
                        //       children: [
                        //         const SizedBox(width: 40, child: Text('Jml')),
                        //         Expanded(
                        //             child: TextFieldCust(
                        //               inputFormatter: [
                        //                 FilteringTextInputFormatter.digitsOnly,
                        //                 CurrencyTextInputFormatter(
                        //                   locale: 'id',
                        //                   decimalDigits: 0,
                        //                   symbol: 'Rp. '
                        //                 ),
                        //               ],
                        //                 controller: amountController[i],
                        //                 keyboardType: TextInputType.number)),
                        //         SizedBox.shrink(child: TextField(controller: idController[i]))
                        //       ],
                        //     ),
                        //   ),
                        //   const SizedBox(height: 8)
                        // ],
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Text('Code'),
                            Text('Balance'),
                            Text('Jml'),
                          ],
                        ),

                        const SizedBox(height: 10),

                        for (int i = 0; i <= counter; i++) ...[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 34,
                                width: width,
                                child: RawAutocomplete<Customer>(
                                  focusNode: node[i],
                                  textEditingController: codeController[i],
                                  onSelected: (e) {
                                    idController[i].text = e.id;
                                    balanceController[i].text =
                                        CurrencyTextInputFormatter(
                                      locale: 'id',
                                      decimalDigits: 0,
                                      symbol: '',
                                    ).format(e.balance.toString());
                                  },
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
                                        width: halfWidth,
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
                              ),
                              TextFieldCust(
                                  width: width,
                                  controller: balanceController[i],
                                  readOnly: true),
                              TextFieldCust(
                                width: width,
                                controller: amountController[i],
                                inputFormatter: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  CurrencyTextInputFormatter(
                                    locale: 'id',
                                    decimalDigits: 0,
                                    symbol: '',
                                  )
                                ],
                              ),
                            ],
                          ),
                          Visibility(
                              visible: false,
                              child: TextField(controller: idController[i], focusNode: FocusNode())),
                          const SizedBox(height: 10)
                        ],
                        const SizedBox(width: double.infinity, height: 20)
                      ],
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 10),
            if (!isLoading)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                      onTap: () {
                        counter++;
                        codeController.add(TextEditingController());
                        node.add(FocusNode());
                        balanceController.add(TextEditingController());
                        amountController.add(TextEditingController());
                        idController.add(TextEditingController());
                        setState(() {});
                      },
                      child: const Icon(CupertinoIcons.add_circled_solid))
                ],
              ),
            const SizedBox(height: 20),
            if (!konfirmasi && !loading)
              SizedBox(
                height: 40,
                // width: 150,
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
            if (konfirmasi && !loading)
              Column(
                children: [
                  const Text('Apakah anda yakin?'),
                  const SizedBox(height: 10),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    SizedBox(
                        height: 40,
                        width: 100,
                        child: ElevatedButton(
                            onPressed: () => setState(() => konfirmasi = false),
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
                            onPressed: mutate,
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
            if (loading) const CircularProgressIndicator(),
            const SizedBox(height: 20),
          ]),
        ));
  }
}
