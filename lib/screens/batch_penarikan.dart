import 'dart:ffi';
import 'dart:io';

import 'package:bmt_ibnusina/tools/textfield_custom.dart';
import 'package:bmt_ibnusina/tools/wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BatchPenarikan extends StatefulWidget {
  const BatchPenarikan({super.key});

  @override
  State<BatchPenarikan> createState() => _BatchPenarikanState();
}

class _BatchPenarikanState extends State<BatchPenarikan> {
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    final Map<String, List<TextEditingController>> inputController = {
      'input0': [TextEditingController(), TextEditingController()]
    };
    final halfWidth = !Platform.isAndroid
        ? (MediaQuery.of(context).size.width - 50) / 2
        : double.infinity;

    return Wrapper(
        screen: 'BATCH PENARIKAN',
        body: Column(children: [
          Wrap(
            spacing: 10,
            runSpacing: 5,
            children: [
              SizedBox(
                width: halfWidth,
                child: Row(
                  children: const [
                    SizedBox(width: 40, child: Text('Ref')),
                    Expanded(child: TextFieldCust())
                  ],
                ),
              ),
              SizedBox(
                width: halfWidth,
                child: Row(
                  children: const [
                    SizedBox(width: 40, child: Text('Date')),
                    Expanded(child: TextFieldCust())
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Row(
                  children: const [
                    SizedBox(width: 40, child: Text('Desc')),
                    Expanded(child: TextFieldCust())
                  ],
                ),
              ),
              const SizedBox(height: 10, width: double.infinity),
              for (var i = 0; i < counter + 1; i++) ...[
                SizedBox(
                  width: halfWidth,
                  child: Row(
                    children: [
                      const SizedBox(width: 40, child: Text('Code')),
                      Expanded(
                          child: TextFieldCust(
                              controller: inputController['input$i']?[0]))
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
                              controller: inputController['input$i']?[1]))
                    ],
                  ),
                ),
              ]
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                  onTap: () {
                    setState(() {
                      counter++;
                    });
                    inputController['input$counter'] = [
                      TextEditingController(),
                      TextEditingController()
                    ];
                  },
                  child: const Icon(CupertinoIcons.add_circled_solid))
            ],
          ),
          const SizedBox(height: 20),
        ]));
  }
}
