import 'dart:io';

import 'package:bmt_ibnusina/auth/hasura.dart';
import 'package:bmt_ibnusina/db/mutation.dart';
import 'package:bmt_ibnusina/db/query.dart';
import 'package:bmt_ibnusina/models/customers_model.dart';
import 'package:bmt_ibnusina/tools/my_formatter.dart';
import 'package:bmt_ibnusina/tools/textfield_custom.dart';
import 'package:bmt_ibnusina/tools/wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  final List<TextEditingController> idController = [TextEditingController()];

  final List<TextEditingController> refDateDesc = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];

  void mutate() async {
    setState(()=>loading=true);
    final List<Map<String, dynamic>> data = [];
    for (int i = 0; i < idController.length; i++) {
      data.add({'customerId': idController[i].text, 'amount': int.parse(amountController[i].text)});
    }

    final message = ScaffoldMessenger.of(context);

    try{
      await Hasura.mutate(batchPenarikanMutation, v: {'date': DateFormat('yyyy-MM-dd').parse(refDateDesc[1].text).toString(), 'description': refDateDesc[2].text, 'reference': refDateDesc[0].text, 'input': data});
      message.showSnackBar(const SnackBar(content: Text('Berhasil')));
    }catch(e){
      message.showSnackBar(const SnackBar(content: Text('Gagal')));
    }
    setState((){
      loading=false;
      konfirmasi=false;
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
    final halfWidth = !Platform.isAndroid
        ? (MediaQuery.of(context).size.width - 50) / 2
        : double.infinity;

    return Wrapper(
        screen: 'BATCH PENARIKAN',
        body: SingleChildScrollView(
          child: Column(children: [
            Wrap(
              spacing: 5,
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
                            controller: refDateDesc[1],
                            keyboardType: TextInputType.datetime,
                            inputFormatter: [
                              MyFormatter(sample: 'xx-xx-xxxx', sparator: '-')
                            ],
                        )
                      )
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
                  for (int i = 0; i <= counter; i++) 
                  ...[
                    SizedBox(
                      width: halfWidth,
                      child: Row(
                        children: [
                          const SizedBox(width: 40, child: Text('Code')),
                          Expanded(
                            child: RawAutocomplete<Customer>(
                              focusNode: node[i],
                              textEditingController: codeController[i],
                              onSelected: (e) => idController[i].text = e.id,
                              optionsBuilder: (TextEditingValue v) =>
                                  v.text.isEmpty
                                      ? []
                                      : customers
                                          .where((e) => e.name
                                              .toLowerCase()
                                              .startsWith(v.text.toLowerCase()))
                                          .toList(),
                              displayStringForOption: (option) => option.name,
                              fieldViewBuilder: (context, textEditingController,
                                      focusNode, onFieldSubmitted) =>
                                  TextField(
                                controller: textEditingController,
                                focusNode: focusNode,
                                decoration: InputDecoration(
                                  isDense: true,
                                  isCollapsed: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 10),
                                  fillColor: Theme.of(context).primaryColorLight,
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
                                      AutocompleteOnSelected<Customer> onSelected,
                                      Iterable<Customer> options) =>
                                  Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 2.0),
                                  child: Container(
                                    width: halfWidth,
                                    color: Colors.amber,
                                    child: Material(
                                      child: ListView(
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
                    ),
                    SizedBox(
                      width: halfWidth,
                      child: Row(
                        children: [
                          const SizedBox(width: 40, child: Text('Jml')),
                          Expanded(
                              child: TextFieldCust(
                                  controller: amountController[i],
                                  keyboardType: TextInputType.number)),
                          SizedBox.shrink(child: TextField(controller: idController[i]))
                        ],
                      ),
                    ),
                    const SizedBox(height: 8)
                  ]
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
            if(konfirmasi && !loading)
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
            if(loading) const CircularProgressIndicator(),
            const SizedBox(height: 20),
          ]),
        ));
  }
}
