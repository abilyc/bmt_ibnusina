import 'package:bmt_ibnusina/auth/services.dart';
import 'package:bmt_ibnusina/db/mutation.dart';
import 'package:flutter/material.dart';
import 'package:hasura_connect/hasura_connect.dart';
// import 'dart:io';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.0)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Wrap(
          alignment: WrapAlignment.center,
          runAlignment: WrapAlignment.center,
          runSpacing: 20,
          children: [
            TextField(
              controller: nameController,
              style: TextStyle(color: Theme.of(context).primaryColorDark),
              decoration: InputDecoration(
                  // labelText: 'User Name',
                  hintText: 'User Name',
                  hintStyle: TextStyle(color: Theme.of(context).primaryColorDark),
                  fillColor: Theme.of(context).primaryColorLight,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.5)
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    )
                  ),
                  prefixIcon: Icon(Icons.person, color: Theme.of(context).primaryColorDark)),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              style: TextStyle(color: Theme.of(context).primaryColorDark),
              decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: TextStyle(color: Theme.of(context).primaryColorDark),
                  fillColor: Theme.of(context).primaryColorLight,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.5)
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    )
                  ),
                  prefixIcon: Icon(Icons.lock, color: Theme.of(context).primaryColorDark)),
            ),
            const SizedBox(height: 80),
            ElevatedButton(
              onPressed: () =>
                  login(context, nameController.text, passwordController.text),
              child: const Text('Login'),
            )
          ],
        ),
      ),
    );
  }
}

login(BuildContext context, String? username, String? password) async {
  HasuraConnect hasuraConnect =
      HasuraConnect('https://ibs-finance.hasura.app/v1/graphql');
  try {
    final data = await hasuraConnect.mutation(loginMutation,
        variables: {"username": username, "password": password});
    Auth.user(data);
  } catch (e) {
    Auth.streamError;
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Login Gagal')));
  }
}
