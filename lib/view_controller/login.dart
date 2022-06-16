import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_body_app/view_controller/forgot_password.dart';
import 'package:fitness_body_app/view_controller/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:fitness_body_app/model/app_master.dart';
import 'package:fitness_body_app/widgets/error_box.dart';
import 'package:fitness_body_app/view_controller/home.dart';
import 'package:fitness_body_app/model/local_user.dart';
import 'package:fitness_body_app/main.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  initState() {
    super.initState();
  }

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
                    'Sign in',
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
              TextButton(
                onPressed: () async {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ForgotPassword()),
                  );
                },
                style: TextButton.styleFrom(primary: Colors.black),
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    child: const Text('Login'),
                    style: ElevatedButton.styleFrom(primary: Colors.black),
                    onPressed: () async {
                      if (emailController.text == "") {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return const ErrorBox(
                                  errorName: 'Enter email', errorReason: '');
                            });
                      } else if (passwordController.text == "") {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return const ErrorBox(
                                  errorName: 'Enter password', errorReason: '');
                            });
                      } else {
                        FirebaseAuth auth = FirebaseAuth.instance;
                        try {
                          await auth
                              .signInWithEmailAndPassword(
                                password: passwordController.text,
                                email: emailController.text,
                              )
                              .then((value) => {});
                          if (!mounted) return;
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen(
                                      master: Master(
                                          [],
                                          [],
                                          localUser(
                                              name: auth.currentUser
                                                      ?.displayName ??
                                                  '',
                                              profileImagePath:
                                                  'https://play-lh.googleusercontent.com/8ddL1kuoNUB5vUvgDVjYY3_6HwQcrg1K2fd_R8soD-e2QYj8fT9cfhfh3G0hnSruLKec',
                                              coverImagePath:
                                                  'https://www.developingngo.org/wp-content/uploads/2018/01/2560x1440-gray-solid-color-background.jpg',
                                              email:
                                                  auth.currentUser?.email ?? '',
                                              id: auth.currentUser?.uid ?? '',
                                              amountOfFollowers: 0,
                                              amountOfFollowing: 0,
                                              amountOfPublicWorkouts: 0)),
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
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('Do you not have an account?'),
                  TextButton(
                    child: const Text(
                      'Sign up here',
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const SignUp()),
                      );
                    },
                  )
                ],
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomeScreen(
                                master: Master(
                                    [],
                                    [],
                                    localUser(
                                        name: "tester",
                                        profileImagePath:
                                            "https://play-lh.googleusercontent.com/8ddL1kuoNUB5vUvgDVjYY3_6HwQcrg1K2fd_R8soD-e2QYj8fT9cfhfh3G0hnSruLKec",
                                        coverImagePath:
                                            'https://www.developingngo.org/wp-content/uploads/2018/01/2560x1440-gray-solid-color-background.jpg',
                                        email: "tester@tester.com",
                                        amountOfFollowers: 0,
                                        amountOfFollowing: 0,
                                        amountOfPublicWorkouts: 0,
                                        id: '')),
                              )),
                    );
                  },
                  child: const Text("Temp login"))
            ],
          )),
    );
  }
}
