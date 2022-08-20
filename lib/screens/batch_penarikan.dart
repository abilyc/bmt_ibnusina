import 'package:bmt_ibnusina/tools/wrapper.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class BatchPenarikan extends StatefulWidget {
  const BatchPenarikan({super.key});

  @override
  State<BatchPenarikan> createState() => _BatchPenarikanState();
}

class _BatchPenarikanState extends State<BatchPenarikan> {
  @override
  Widget build(BuildContext context) {
    return Wrapper(
      screen: 'BATCH PENARIKAN',
      body: Container()
    );
  }
}