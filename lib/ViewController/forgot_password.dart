import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_body_app/Model/Master.dart';
import 'package:fitness_body_app/Model/localUser.dart';
import 'package:fitness_body_app/ViewController/home.dart';
import 'package:fitness_body_app/ViewController/login.dart';
import 'package:fitness_body_app/ViewController/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../services/authentication.dart';
import 'errorBox.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black,
          title: const Text(
            'Reset Password',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 30),
          ),
          // ignore: prefer_const_constructors
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Login()),
              );
            },
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: textController,
                    focusNode: myFocusNode,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      labelText: 'Enter Your Email Here',
                      labelStyle: TextStyle(
                          color: myFocusNode.hasFocus
                              ? Colors.blue
                              : Colors.black),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 0.5, color: Colors.grey),
                          borderRadius: BorderRadius.circular(15)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 3, color: Colors.black),
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  ),
                ),
                Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.fromLTRB(15, 0, 10, 10),
                    child: const Text(
                      'A link will be sent to this email-adress to reset your password',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    )),
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.black),
                      onPressed: () async {
                        if (textController.text == "") {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return const ErrorBox(
                                    errorName: 'Enter email', errorReason: '');
                              });
                        } else {
                          FirebaseAuth.instance.sendPasswordResetEmail(
                              email: textController.text);
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Reset Password'),
                    )),
              ],
            )));
  }
}
