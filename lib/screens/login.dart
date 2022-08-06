import 'package:bmt_ibnusina/auth/services.dart';
import 'package:bmt_ibnusina/db/mutation.dart';
import 'package:bmt_ibnusina/tools/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:hasura_connect/hasura_connect.dart';
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
      menu: false,
      back: false,
      body: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.0)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(
                height: 70,
                width: double.infinity
              ),
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
                      prefixIcon: Icon(Icons.person, color: Theme.of(context).primaryColorDark)
                    ),
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
              const SizedBox(height: 80),
              ElevatedButton(
                onPressed: !loading
                    ? () async {
                        setState(() => loading = true);
                        await login(nameController.text,
                            passwordController.text);
                        setState(() => loading = false);
                      }
                    : null,
                child: loading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2))
                    : const Text('Login'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

login(String? username, String? password) async {
  HasuraConnect hasuraConnect =
      HasuraConnect('https://ibs-finance.hasura.app/v1/graphql');
  try {
    final data = await hasuraConnect.mutation(loginMutation,
        variables: {"username": username, "password": password});
    Auth.user(data);
  } catch (e) {
    Auth.streamError;
    ScaffoldMessenger.of(Auth.parentCtx)
        .showSnackBar(const SnackBar(content: Text('Login Gagal')));
  }
}
