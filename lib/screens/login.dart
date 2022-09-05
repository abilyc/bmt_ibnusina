import 'package:bmt_ibnusina/provider/auth_provider.dart';
import 'package:bmt_ibnusina/tools/wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'dart:io';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
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
                  focusNode: FocusNode(),
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
                  focusNode: FocusNode(),
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
                child: Consumer<Auth>(
                  builder: (context, value, child) => ElevatedButton(
                    onPressed: !value.isLoading ? () async => value.login(context, nameController.text, passwordController.text) : null, 
                    child: !value.isLoading ? Center(
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
                    ) : const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator()
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