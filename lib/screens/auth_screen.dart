import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:totoey/screens/tasks_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../constants.dart';
import 'create_edit_task_screen.dart';

class AuthScreen extends StatelessWidget {
  final _googleSignIn = GoogleSignIn();

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
                          Navigator.pushNamed(context, TasksScreen.id);
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
                          Navigator.pushNamed(context, TasksScreen.id);
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                  ),
                ],
              ),
              AddTaskScreenButton(
                label: 'Sign in with Google',
                color: Colors.teal,
                onTap: () async {
                  try {
                    final googleUser = await _googleSignIn.signIn();
                    if (googleUser != null) {
                      final googleAuth = await googleUser.authentication;
                      final credential = GoogleAuthProvider.credential(
                        accessToken: googleAuth.accessToken,
                        idToken: googleAuth.idToken,
                      );
                      await _auth.signInWithCredential(credential);
                      Navigator.pushNamed(context, TasksScreen.id);
                    }
                  } catch (e) {
                    print('catch:');
                    print(e);
                  }
                }
                ,
              ),
              AddTaskScreenButton(
                label: 'Register with Google',
                color: Colors.blue,
                onTap: () async {
                  print('Register with Google');
                  try {
                    final googleUser = await _googleSignIn.signIn();
                    print('user selected');
                    print(googleUser);
                    if (googleUser != null) {
                      // Google Sign-In successful, now create user account in Firebase
                      final googleAuth = await googleUser.authentication;
                      final credential = GoogleAuthProvider.credential(
                        accessToken: googleAuth.accessToken,
                        idToken: googleAuth.idToken,
                      );
                      final userCredential =
                      await _auth.signInWithCredential(credential);

                      // Create user account in Firebase if it doesn't already exist
                      if (userCredential.additionalUserInfo!.isNewUser) {
                        final currentUser = _auth.currentUser;
                        if (currentUser != null) {
                          await currentUser.updateProfile(displayName: googleUser.displayName);
                        }
                      }

                      Navigator.pushNamed(context, TasksScreen.id);
                    }
                  } catch (e) {
                    print('catch');
                    print(e);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
