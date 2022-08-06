import 'package:bmt_ibnusina/models/seach_nasabah.dart';
import 'package:bmt_ibnusina/tools/textfield_custom.dart';
import 'package:bmt_ibnusina/tools/wrapper.dart';
import 'package:flutter/material.dart';

class Penyetoran extends StatefulWidget {
  const Penyetoran({Key? key}) : super(key: key);

  @override
  State<Penyetoran> createState() => _PenyetoranState();
}

class _PenyetoranState extends State<Penyetoran> {
  bool showDetail = false;
  final dataNasabah = Nasabah(nama: 'Wiwin Sumiwin', ref: '', desc: '');
  final TextEditingController noRek = TextEditingController();
  final TextEditingController refController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController jmlController = TextEditingController();
  final Map screenData = {'penyetoran': []};

  @override
  void initState() {
    super.initState();
    setState(() => showDetail = true);
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
            child: TextFieldCust(icon: Icons.search, controller: noRek),
          ),
        ],
      ),
    ];
    final List<Widget> detail = [
      const SizedBox(height: 60),
      Text(dataNasabah.nama,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      const SizedBox(height: 30),
      Row(
        children: [
          const SizedBox(
            width: 60,
            child: Text('Ref'),
          ),
          Expanded(
            child: TextFieldCust(controller: refController),
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
            child: TextFieldCust(controller: descController),
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
            child: TextFieldCust(controller: jmlController),
          ),
        ],
      )
    ];

    return Wrapper(
      screen: 'penyetoran'.toUpperCase(),
      body: Wrap(alignment: WrapAlignment.center, runSpacing: 5, children: [
        ...data,
        const SizedBox(height: 60),
        if (showDetail) ...detail,
        const SizedBox(height: 60),
        if (showDetail)
          const ElevatedButton(onPressed: null, child: Text('Konfirmasi'))
      ]),
    );
  }
}
