import 'package:bmt_ibnusina/auth/hasura.dart';
import 'package:bmt_ibnusina/db/mutation.dart';
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
  bool hasuraLoading = false;
  bool konfirmasi = false;
  bool detailLoading = false;
  Nasabah? dataNasabah;
  final TextEditingController noRek = TextEditingController();
  final TextEditingController ref = TextEditingController();
  final TextEditingController desc = TextEditingController();
  final TextEditingController jml = TextEditingController();

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
            child: TextFieldCust(
                icon: Icons.search,
                controller: noRek,
                onPressed: enabled ? searchData : null),
          ),
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
      Row(
        children: [
          const SizedBox(
            width: 60,
            child: Text('Jumlah'),
          ),
          Expanded(
            child: TextFieldCust(enabled: !konfirmasi, controller: jml),
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
        if (konfirmasi && showDetail && !hasuraLoading)
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
                        // onPressed: () => ScaffoldMessenger.of(context)
                        //     .showSnackBar(const SnackBar(content: Text('Oke'))),
                        onPressed: konfirm,
                        child: const Text('Ok'))),
              ]),
            ],
          ),
        if (hasuraLoading) const CircularProgressIndicator()
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
          await Hasura.query(trxQuery, v: {'_eq': noRek.text}));
    } catch (e) {
      showSnackBar('Terjadi Kesalahan');
    }

    setState(() {
      enabled = true;
      if (dataNasabah?.nama != null) showDetail = true;
    });
  }

  void konfirm() async {
    setState(() => hasuraLoading = true);
    // final data;
    try {
      final data = await Hasura.mutate(setorMutation, v: {
        'reference': ref.text,
        'description': desc.text,
        'amount': int.parse(jml.text),
        'date': DateTime.now().toString(),
        'cashIn': dataNasabah!.id
      });

      showSnackBar(data['data']['penyetoran']['success']
          ? 'Setor Success'
          : 'Setor Gagal');

      if (data['data']['penyetoran']['success']) {
        ref.text = '';
        desc.text = '';
        jml.text = '';
      }
      konfirmasi = false;
    } catch (e) {
      showSnackBar('Terjadi Kesalahan');
    }

    setState(() => hasuraLoading = false);
  }

  void showSnackBar(String msg) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
}
