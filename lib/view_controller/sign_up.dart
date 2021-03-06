import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_body_app/model/app_master.dart';
import 'package:fitness_body_app/model/local_user.dart';
import 'package:fitness_body_app/view_controller/home.dart';
import 'package:fitness_body_app/view_controller/login.dart';
import 'package:fitness_body_app/main.dart';
import 'package:fitness_body_app/services/firestore_upload.dart';
import 'package:flutter/material.dart';
import 'package:fitness_body_app/widgets/error_box.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'FitnessBuddy',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 30),
                  )),
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Create Account',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  )),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: emailController,
                  focusNode: myFocusNode,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(
                        color:
                            myFocusNode.hasFocus ? Colors.blue : Colors.black),
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
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: usernameController,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    labelStyle: TextStyle(
                        color:
                            myFocusNode.hasFocus ? Colors.blue : Colors.black),
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
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                  obscureText: true,
                  controller: passwordController,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(
                        color:
                            myFocusNode.hasFocus ? Colors.blue : Colors.black),
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 0.5,
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(15)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 3, color: Colors.black),
                        borderRadius: BorderRadius.circular(15)),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                  obscureText: true,
                  controller: confirmPasswordController,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    labelStyle: TextStyle(
                        color:
                            myFocusNode.hasFocus ? Colors.blue : Colors.black),
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 0.5,
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(15)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 3, color: Colors.black),
                        borderRadius: BorderRadius.circular(15)),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.black),
                    onPressed: () async {
                      if (passwordController.text !=
                          confirmPasswordController.text) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return const ErrorBox(
                                  errorName: 'Password must match',
                                  errorReason: '');
                            });
                      } else if (usernameController.text == "") {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return const ErrorBox(
                                  errorName: 'Enter username', errorReason: '');
                            });
                      } else {
                        FirebaseAuth auth = FirebaseAuth.instance;
                        try {
                          await auth
                              .createUserWithEmailAndPassword(
                                password: passwordController.text,
                                email: emailController.text,
                              )
                              .then((userCredential) async => {
                                    await userCredential.user
                                        ?.updateDisplayName(
                                            usernameController.text)
                                  });

                          if (!mounted) return;
                          LocalUser user = LocalUser(
                              name: auth.currentUser?.displayName ?? '',
                              profileImagePath:
                                  'https://www.inside.dtu.dk/gimage.ashx?i=VHJ1ZV9ffHxfX2h0dHBzOi8vd3d3LmR0dWJhc2VuLmR0dS5kay9zaG93aW1hZ2UuYXNweD9pZD0xNjk3MjlfX3x8X18xMDNfX3x8X18xNDBfX3x8X19UcnVlX198fF9fRmFsc2VfX3x8X19GYWxzZV9ffHxfXzBfX3x8X19fX3x8X18w',
                              coverImagePath:
                                  'https://www.developingngo.org/wp-content/uploads/2018/01/2560x1440-gray-solid-color-background.jpg',
                              email: auth.currentUser?.email ?? '',
                              id: auth.currentUser?.uid ?? '',
                              amountOfFollowers: 0,
                              amountOfFollowing: 0,
                              amountOfPublicWorkouts: 0);
                          FirestoreUpload.uploadUser(user);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen(
                                      master: Master(workouts: [], currentUser: user),
                                    )),
                          );
                        } on FirebaseAuthException catch (e) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return ErrorBox(
                                    errorReason: e.message ?? '',
                                    errorName: 'User creation error');
                              });
                        } catch (e) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return ErrorBox(
                                    errorReason: e.toString(),
                                    errorName: 'Unexpected Error');
                              });
                        }
                      }
                    },
                    child: const Text('Register'),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('Already have an account?'),
                  TextButton(
                    child: const Text(
                      'Sign in here',
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const Login()),
                      );
                    },
                  )
                ],
              ),
            ],
          )),
    );
  }
}
