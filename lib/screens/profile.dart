import 'package:bmt_ibnusina/tools/textfield_custom.dart';
import 'package:bmt_ibnusina/tools/wrapper.dart';
import 'package:flutter/material.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController namaController = TextEditingController();
    final TextEditingController passController = TextEditingController();
    final TextEditingController confPassController = TextEditingController();
    return Wrapper(
        screen: 'PROFILE',
        body: Wrap(
          alignment: WrapAlignment.center,
          runAlignment: WrapAlignment.center,
          children: [
            TextFieldCust(controller: namaController),
            TextFieldCust(controller: passController),
            TextFieldCust(controller: confPassController)
          ],
        ));
  }
}
