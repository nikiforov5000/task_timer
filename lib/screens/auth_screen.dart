import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import 'create_edit_task_screen.dart';

class AuthScreen extends StatelessWidget {
  final _auth = FirebaseAuth.instance;

  late String email;
  late String password;

  static String id = '/auth_screen';

  @override
  Widget build(BuildContext context) {
    TextEditingController controllerLogin = TextEditingController();
    TextEditingController controllerRegister = TextEditingController();
    return Scaffold(
      body: Container(
        color: kDarkGreyColor,
        child: SafeArea(
          child: Column(
            children: [
              TextField(
                // controller: controllerLogin,
                onChanged: (value) {
                  email = value;
                },
                textAlign: TextAlign.center,
                autofocus: true,
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        width: 1,
                        color: kLightGreyColor,
                      )),
                  hintText: 'Enter Email',
                  hintStyle: TextStyle(
                      color: kLightGreyColor, fontWeight: FontWeight.w100),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                // controller: controllerLogin,
                obscureText: true,

                onChanged: (value) {
                  password = value;
                },
                textAlign: TextAlign.center,
                autofocus: true,
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        width: 1,
                        color: kLightGreyColor,
                      )),
                  hintText: 'Enter Password',
                  hintStyle: TextStyle(
                      color: kLightGreyColor, fontWeight: FontWeight.w100),
                ),
              ),
              Row(
                children: [
                  AddTaskScreenButton(
                    label: 'Login',
                    color: Colors.green,
                    onTap: () async {
                      print(email + ' ' + password);
                      try {
                        final user = await _auth.signInWithEmailAndPassword(
                          email: email,
                          password: password,
                        );
                        if (user != null) {
                          print('user != null');
                          // Navigator.pushNamed(context, EcommerceDemoApp.id);
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  AddTaskScreenButton(
                    label: 'Register',
                    color: Colors.blue,
                    onTap: () async {
                      print(email + ' ' + password);
                      try {
                        final newUser =
                            await _auth.createUserWithEmailAndPassword(
                          email: email,
                          password: password,
                        );
                        if (newUser != null) {
                          // Navigator.pushNamed(context, EcommerceDemoApp.id);
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
