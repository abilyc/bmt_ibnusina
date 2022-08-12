import 'package:bmt_ibnusina/auth/hasura.dart';
import 'package:bmt_ibnusina/db/mutation.dart';
import 'package:bmt_ibnusina/db/query.dart';
import 'package:bmt_ibnusina/models/nasabah_model.dart';
import 'package:bmt_ibnusina/screens/history.dart';
import 'package:bmt_ibnusina/tools/textfield_custom.dart';
import 'package:bmt_ibnusina/tools/wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  Nasabah? dataNasabah;
  final TextEditingController noRek = TextEditingController();
  final TextEditingController ref = TextEditingController();
  final TextEditingController desc = TextEditingController();
  final TextEditingController tujuan = TextEditingController();
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
            child: TextFieldCust(enabled: !konfirmasi, controller: jml),
          ),
        ],
      )
    ];

    return Wrapper(
      screen: widget.mode.toUpperCase(),
      body: Wrap(alignment: WrapAlignment.center, runSpacing: 5, children: [
        ...data,
        const SizedBox(height: 60),
        if (!enabled) const CircularProgressIndicator(),
        if (showDetail) ...detail,
        const SizedBox(height: 60),
        if (showDetail && !konfirmasi)
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
                        // onPressed: () => ScaffoldMessenger.of(context)
                        //     .showSnackBar(const SnackBar(content: Text('Oke'))),
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
        if(showDetail) Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [hisstory(dataNasabah)]
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
    Map<String, dynamic> konfirmData = {
      'penyetoran': [
        setorMutation,
        {
          'reference': ref.text,
          'description': desc.text,
          'amount': int.parse(jml.text),
          'date': DateTime.now().toString(),
          'cashIn': dataNasabah!.id
        }
      ],
      'penarikan': [
        penarikanMutation,
        {
          'reference': ref.text,
          'description': desc.text,
          'amount': int.parse(jml.text),
          'date': DateTime.now().toString(),
          'cashOut': dataNasabah!.id
        }
      ],
      'transfer': [
        transferMutation,
        {
          'reference': ref.text,
          'description': desc.text,
          'amount': int.parse(jml.text),
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
      }
      konfirmasi = false;
    } catch (e) {
      // print(e);
      showSnackBar('Terjadi Kesalahan');
    }

    setState(() => hasuraLoading = false);
  }

  void showSnackBar(String msg) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
}
