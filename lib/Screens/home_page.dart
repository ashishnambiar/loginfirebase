import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loginfirebase/Extra/snackbar_handler.dart';
import 'package:loginfirebase/Extra/validation_handler.dart';
import 'package:loginfirebase/Screens/recycler_view.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  static const route = '/';

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        log('User is currently signed out!');
        Navigator.popUntil(context, ModalRoute.withName(HomePage.route));
        snackBarHandler(context, SnackBar(content: Text('Logged Out')));
      } else {
        log('User is signed in!');
        Navigator.pushNamed(context, RecyclerView.route);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Login with firebase'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                label: Text("Email"),
              ),
              controller: _emailController,
              validator: (String? str) {
                return validationHandler(
                  str: str,
                  fieldName: "Email",
                  email: true,
                );
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                label: Text("UserName"),
              ),
              controller: _userNameController,
              validator: (String? str) {
                return validationHandler(
                  str: str,
                  fieldName: "UserName",
                  length: 10,
                );
              },
            ),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                label: Text("Password"),
              ),
              controller: _passwordController,
              validator: (String? str) {
                return validationHandler(
                  str: str,
                  fieldName: "Password",
                  length: 7,
                  password: true,
                );
              },
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  snackBarHandler(
                      context, const SnackBar(content: Text("validated")));
                  await Future.delayed(Duration(seconds: 2));

                  try {
                    final credential = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                      email: _emailController.text,
                      password: _passwordController.text,
                    );
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'email-already-in-use') {
                      print('The account already exists for that email.');
                      try {
                        final credential = await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                          email: _emailController.text,
                          password: _passwordController.text,
                        );
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          print('No user found for that email.');
                        } else if (e.code == 'wrong-password') {
                          print('Wrong password provided for that user.');
                        }
                      }
                    }
                  } catch (e) {
                    log('Error: ', error: '$e');
                  }
                } else {
                  snackBarHandler(
                      context,
                      const SnackBar(
                          backgroundColor: Colors.red,
                          content: Text("not validate")));
                }
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
