import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class AuthScreen extends StatelessWidget {
  final _auth = FirebaseAuth.instance;

  late String email;
  late String password;

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
              Text('Login', style: kLoginHeaderTextStyle,),
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
              SizedBox(height: 10.0,),
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

              SizedBox(height: 100,),

              Text('Register', style: kLoginHeaderTextStyle,),
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
              SizedBox(height: 10.0,),
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
            ],
          ),
        ),
      ),
    );
  }
}
