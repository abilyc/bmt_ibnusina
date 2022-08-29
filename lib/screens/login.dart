import 'package:bmt_ibnusina/auth/hasura.dart';
import 'package:bmt_ibnusina/auth/services.dart';
import 'package:bmt_ibnusina/db/mutation.dart';
import 'package:bmt_ibnusina/tools/wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'dart:io';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    login(String? username, String? password) async {
      final nav = Navigator.of(context);
      try {
        await Hasura.mutate(loginMutation,
            v: {"username": username, "password": password});
        Auth.user(Hasura.result);
        Hasura.headers = {'Authorization': 'Bearer ${Auth.userData.token}'};
        nav.popAndPushNamed('home');
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Login Gagal')));
      }
    }

    return Wrapper(
      screen: 'login',
      menu: false,
      back: false,
      body: Center(
        child: Wrap(
          runSpacing: 10,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                width: 300,
                child: TextField(
                  controller: nameController,
                  style: TextStyle(color: Theme.of(context).primaryColorDark),
                  decoration: InputDecoration(
                      // labelText: 'User Name',
                      hintText: 'User Name',
                      hintStyle:
                          TextStyle(color: Theme.of(context).primaryColorDark),
                      fillColor: Theme.of(context).primaryColorLight,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.5)),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.transparent,
                      )),
                      prefixIcon: Icon(Icons.person,
                          color: Theme.of(context).primaryColorDark)),
                ),
              ),
            ),
            // const SizedBox(height: 10),
            Center(
              child: SizedBox(
                width: 300,
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  style: TextStyle(color: Theme.of(context).primaryColorDark),
                  decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle:
                          TextStyle(color: Theme.of(context).primaryColorDark),
                      fillColor: Theme.of(context).primaryColorLight,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.5)),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.transparent,
                      )),
                      prefixIcon: Icon(Icons.lock,
                          color: Theme.of(context).primaryColorDark)),
                ),
              ),
            ),
            const Center(child: SizedBox(height: 20)),
            Center(
              child: SizedBox(
                width: 120,
                height: 45,
                child: ElevatedButton(
                  onPressed: !loading
                      ? () async {
                          setState(() => loading = true);
                          await login(
                              nameController.text, passwordController.text);
                          setState(() => loading = false);
                        }
                      : null,
                  child: loading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator())
                      : Center(
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            spacing: 10,
                            children: const [
                              Icon(CupertinoIcons
                                  .arrowtriangle_right_circle_fill),
                              Text('MASUK'),
                            ],
                          ),
                        ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
