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
    return Scaffold(
      body: Container(
        color: kDarkGreyColor,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: kSemiLightGreyColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      TextField(
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
                              color: kLightGreyColor,
                              fontWeight: FontWeight.w100),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextField(
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
                              color: kLightGreyColor,
                              fontWeight: FontWeight.w100),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          AddTaskScreenButton(
                            label: 'Login',
                            color: Colors.green,
                            onTap: () async {
                              try {
                                final user =
                                    await _auth.signInWithEmailAndPassword(
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
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Or',
                    style: kLoginHeaderTextStyle.copyWith(fontSize: 30),
                  ),
                ),
                AddTaskScreenButton(
                  label: 'Sign-in with Google',
                  color: Colors.blue,
                  onTap: () async {
                    await onGoogleSignIn(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onGoogleSignIn(BuildContext context) async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        // Google Sign-In successful, now create user account in Firebase
        final googleAuth = await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final userCredential = await _auth.signInWithCredential(credential);

        // Create user account in Firebase if it doesn't already exist
        if (userCredential.additionalUserInfo!.isNewUser) {
          final currentUser = _auth.currentUser;
          if (currentUser != null) {
            await currentUser.updateDisplayName(googleUser.displayName);
          }
        }

        Navigator.pushNamed(context, TasksScreen.id);
      }
    } catch (e) {
      print('catch');
      print(e);
    }
  }
}
