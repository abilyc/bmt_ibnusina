import 'dart:io';

import 'package:bmt_ibnusina/auth/hasura.dart';
import 'package:bmt_ibnusina/auth/services.dart';
import 'package:bmt_ibnusina/db/mutation.dart';
import 'package:bmt_ibnusina/tools/bloc.dart';
import 'package:bmt_ibnusina/tools/textfield_custom.dart';
import 'package:bmt_ibnusina/tools/wrapper.dart';
import 'package:flutter/material.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({super.key, required this.mode});
  final String mode;

  @override
  Widget build(BuildContext context) {
    final bloc = Bloc();
    final TextEditingController namaController = TextEditingController();
    final TextEditingController passController = TextEditingController();
    final TextEditingController confPassController = TextEditingController();
    final double width = Platform.isAndroid
        ? double.infinity
        : MediaQuery.of(context).size.width / 2;

    void simpan() async {
      final String uName = namaController.text.isNotEmpty
          ? namaController.text
          : Auth.userData.userName;
      final message = ScaffoldMessenger.of(context);
      bloc.setLoading(true);
      try {
        mode == 'profile' ? await Hasura.mutate(gantiPwMutation, v: {'newUserName': uName, 'newPass': passController.text})
        : await Hasura.mutate(newCustomer, v: {'username': namaController.text, 'password': passController.text, 'code': namaController.text});
        message.showSnackBar(const SnackBar(content: Text('Berhasil menyimpan')));
      } catch (e) {
        message.showSnackBar(const SnackBar(content: Text('Gagal menyimpan')));
      }
      bloc.setLoading(false);
    }

    return Wrapper(
        screen: mode.toUpperCase(),
        body: Column(
          mainAxisAlignment: Platform.isAndroid ? MainAxisAlignment.start : MainAxisAlignment.center,
          children: [
            SizedBox(
                width: width,
                child: TextFieldCust(
                    controller: namaController,
                    align: TextAlign.center,
                    hint: mode == 'profile'
                        ? 'Ganti nama ${Auth.userData.userName}'
                        : 'Masukan nama baru')),
            const SizedBox(height: 5),
            SizedBox(
                width: width,
                child: TextFieldCust(
                    controller: passController,
                    hint: 'Password baru',
                    align: TextAlign.center,
                    obscure: true)),
            const SizedBox(height: 5),
            SizedBox(
                width: width,
                child: TextFieldCust(
                    obscure: true,
                    controller: confPassController,
                    hint: 'Ulangi Password baru',
                    align: TextAlign.center,
                    onChanged: (e) => bloc.compare(e, passController.text))),
            const SizedBox(height: 5),
            StreamBuilder(
              initialData: false,
              stream: bloc.changed,
              builder: (context, snapshot) => SizedBox(
                  height: 20,
                  child: confPassController.text.isNotEmpty
                      ? Text(
                          snapshot.data == false
                              ? 'Password tidak sama'
                              : 'Password Cocok',
                          style: TextStyle(
                              fontSize: 12,
                              color: snapshot.data == false
                                  ? Colors.red
                                  : Colors.green))
                      : const SizedBox()),
            ),
            const SizedBox(height: 20),
            StreamBuilder(
                stream: bloc.isLoading,
                initialData: false,
                builder: (context, snapshot) => SizedBox(
                    width: 100,
                    child: ElevatedButton(
                        onPressed: snapshot.data == false ? simpan : null,
                        child: snapshot.data == false
                            ? const Text('Simpan')
                            : const SizedBox(
                                width: 10,
                                height: 10,
                                child: CircularProgressIndicator(
                                  strokeWidth: 3,
                                ))))),
          ],
        ));
  }
}
