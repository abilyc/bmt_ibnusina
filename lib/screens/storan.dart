import 'package:bmt_ibnusina/auth/hasura.dart';
import 'package:bmt_ibnusina/db/query.dart';
import 'package:bmt_ibnusina/models/nasabah_model.dart';
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
  bool enabled = true;
  bool konfirmasi = false;
  bool detailLoading = false;
  Nasabah? dataNasabah;
  final Map<String, TextEditingController> controller = {
    'noRek': TextEditingController(),
    'refController': TextEditingController(),
    'descController': TextEditingController(),
    'jmlController': TextEditingController(),
  };

  @override
  void dispose() {
    controller.forEach((k, v) => v.dispose());
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
            child: TextFieldCust(
                icon: Icons.search,
                controller: controller['noRek'],
                onPressed: enabled ? searchData : null),
          ),
        ],
      ),
    ];
    final List<Widget> detail = [
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
            child: TextFieldCust(controller: controller['refController']),
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
            child: TextFieldCust(controller: controller['descController']),
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
            child: TextFieldCust(controller: controller['jmlController']),
          ),
        ],
      )
    ];

    return Wrapper(
      screen: 'penyetoran'.toUpperCase(),
      body: Wrap(alignment: WrapAlignment.center, runSpacing: 5, children: [
        ...data,
        const SizedBox(height: 60),
        if (!enabled) const CircularProgressIndicator(),
        if (showDetail) ...detail,
        const SizedBox(height: 60),
        if (showDetail && !konfirmasi)
          ElevatedButton(
              onPressed: () => setState(() => konfirmasi = true),
              child: const Text('Konfirmasi')),
        if (konfirmasi && showDetail)
          Column(
            children: [
              const Text('Apakah anda yakin?'),
              const SizedBox(height: 10),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                SizedBox(
                    width: 100,
                    child: ElevatedButton(
                        onPressed: () => setState(() => konfirmasi = false),
                        style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.red)),
                        child: const Text('Batal'))),
                const SizedBox(width: 10),
                SizedBox(
                    width: 100,
                    child: ElevatedButton(
                        onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Oke'))),
                        child: const Text('Ok'))),
              ]),
            ],
          )
      ]),
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
          await Hasura.query(trxQuery, v: {'_eq': controller['noRek']!.text}));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Terjadi Kesalahan')));
    }

    setState(() {
      enabled = true;
      if (dataNasabah?.nama != null) showDetail = true;
    });
  }
}
