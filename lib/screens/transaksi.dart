import 'package:bmt_ibnusina/models/seach_nasabah.dart';
import 'package:bmt_ibnusina/tools/wrapper.dart';
import 'package:flutter/material.dart';

class Transaksi extends StatefulWidget {
  const Transaksi({Key? key}) : super(key: key);

  @override
  State<Transaksi> createState() => _TransaksiState();
}

class _TransaksiState extends State<Transaksi> {
  final dataNasabah = Nasabah(nama: 'Wiwin Sumiwin', ref: '', desc: '');
  final TextEditingController noRek = TextEditingController();
  final TextEditingController refController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Wrapper(
      body: Column(
        children: [
          Row(
            children: [
              const SizedBox(
                width: 60,
                child: Text('No. Rek'),
              ),
              Expanded(
                  child: TextField(
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () {
                          print('seacrh');
                        },
                        icon: const Icon(Icons.search)),
                    enabledBorder: const OutlineInputBorder()),
              )),
            ],
          ),
          const SizedBox(height: 35),
          Text(dataNasabah.nama,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Row(
            children: [
              const SizedBox(
                width: 60,
                child: Text('Ref'),
              ),
              Expanded(
                  child: TextField(
                    controller: refController,
                decoration:
                    const InputDecoration(enabledBorder: OutlineInputBorder()),
              )),
            ],
          ),
          Row(
            children: [
              const SizedBox(
                width: 60,
                child: Text('Desc'),
              ),
              Expanded(
                  child: TextField(
                    controller: descController,
                decoration:
                    const InputDecoration(enabledBorder: OutlineInputBorder()),
              )),
            ],
          ),
          Row(
            children: [
              const SizedBox(
                width: 60,
                child: Text('Jumlah'),
              ),
              Expanded(
                  child: TextField(
                    controller: descController,
                decoration:
                    const InputDecoration(enabledBorder: OutlineInputBorder()),
              )),
            ],
          )
          // TextField(
          //   decoration: InputDecoration(
          //     labelText: 'No. Rek'
          //   ),
          // ),
          // TextField(
          //   decoration: InputDecoration(
          //     labelText: 'Ref'
          //   ),
          // )
        ],
      ),
    );
  }
}
