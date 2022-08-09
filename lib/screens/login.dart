import 'package:bmt_ibnusina/auth/hasura.dart';
import 'package:bmt_ibnusina/auth/services.dart';
import 'package:bmt_ibnusina/db/mutation.dart';
import 'package:bmt_ibnusina/tools/wrapper.dart';
import 'package:flutter/material.dart';
// import 'dart:io';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    return Wrapper(
      screen: 'login',
      menu: false,
      back: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // const SizedBox(height: 70, width: double.infinity),
            SizedBox(
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
            const SizedBox(height: 20),
            SizedBox(
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
            const SizedBox(height: 40),
            SizedBox(
              width: 150,
              height: 40,
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
                      child: Row(
                        children: const [
                          Icon(Icons.arrow_circle_right_rounded),
                          Text('MASUK'),
                        ],
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

login(String? username, String? password) async {
  try {
    final data = await Hasura.mutate(loginMutation,
        v: {"username": username, "password": password});
    Auth.user(data);
    Hasura.headers = {'Authorization': 'Bearer ${Auth.userData.token}'};
  } catch (e) {
    // Auth.streamError;
    // print(Auth.context);
    ScaffoldMessenger.of(Auth.parentContext)
        .showSnackBar(const SnackBar(content: Text('Login Gagal')));
  }
}
