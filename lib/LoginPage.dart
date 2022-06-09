import 'package:flutter/material.dart';
 
 FocusNode myFocusNode = new FocusNode();

void main() => runApp(const MyApp());
 
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  
  
  static const String _title = 'The day is the day you change the future';
  
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      
    
      home: Scaffold(
        appBar: AppBar(title: const Text(_title), backgroundColor: Colors.black, centerTitle: true,),
        body: const MyStatefulWidget(),
      ),
    );
  }
}
 
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);
 
  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}
 
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
 
  @override
  Widget build(BuildContext context) {
    return Padding(
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
                    fontSize: 20,),
                )),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: nameController,
                focusNode: myFocusNode,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                   labelText: 'User Name',
                   labelStyle: TextStyle(
                  color: myFocusNode.hasFocus ? Colors.blue : Colors.black),
                 enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 0.5, color: Colors.grey),
                  borderRadius: BorderRadius.circular(15)
                 ),
                 focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 3, color: Colors.black),
                  borderRadius: BorderRadius.circular(15)
                  ),
                 
                
                
                  
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
                  color: myFocusNode.hasFocus ? Colors.blue : Colors.black),
                 enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 0.5, color: Colors.grey,),
                  borderRadius: BorderRadius.circular(15)
                 ),
                 focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 3, color: Colors.black),
                  borderRadius: BorderRadius.circular(15)
                  ),

                ),
              ),
            ),
            TextButton(
              onPressed: () {
                //forgot password screen
              },
              child: const Text('Forgot Password',),
              style: TextButton.styleFrom(primary: Colors.black),


            ),
            
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text('Login'),
                  style: ElevatedButton.styleFrom(primary: Colors.black),
                  
                  onPressed: () {
                    print(nameController.text);
                    print(passwordController.text);
                  },
                )
            ),
            Row(
              children: <Widget>[
                const Text('Does not have account?'),
                TextButton(
                  child: const Text(
                    'Sign in',
                    style: TextStyle(fontSize: 15, color:  Colors.black),
                    
                  ),
                  onPressed: () {
                    //Signup skal komme her
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ],
        ));
  }
}