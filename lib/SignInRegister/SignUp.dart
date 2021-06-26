import 'confirm.dart';
import 'package:flutter/material.dart';
import 'components/rounded_button.dart';
import 'constraints.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:toast/toast.dart' show Toast;
import 'package:flutter_application/main.dart';

class SignUp extends StatefulWidget {
  static const String id = 'SignUp';

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
   String email;
  String password;
   String name;
   String username;
   String wilaya;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      //body: ModalProgressHUD(
      //inAsyncCall: false,

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Flexible(
            //   child: Hero(
            //     tag: 'logo',
            //     child: Container(
            //       height: 60.0,
            //       width: 60.0,
            //       child: Image.asset('assets/images/temp.jpg'),
            //     ),
            //   ),

            // ),
            SizedBox(
              height: 48.0,
            ),
            TextField(
              textAlign: TextAlign.left,
              onChanged: (value) {
                name = value;
              },
              decoration: kTextFieldDecoration.copyWith(hintText: 'Full name'),
            ),
            SizedBox(height: 8.0),
            TextField(
              textAlign: TextAlign.left,
              onChanged: (value) {
                username = value;
              },
              decoration: kTextFieldDecoration.copyWith(hintText: 'User name'),
            ),
            SizedBox(height: 8.0),
            TextField(
              textAlign: TextAlign.left,
              onChanged: (value) {
                wilaya = value;
              },
              decoration: kTextFieldDecoration.copyWith(hintText: 'Wilaya'),
            ),
            SizedBox(height: 8.0),
            TextField(
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.left,
              onChanged: (value) {
                email = value;
              },
              decoration:
                  kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              obscureText: true,
              textAlign: TextAlign.left,
              onChanged: (value) {
                password = value;
              },
              decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your password'),
            ),
            TextField(
              obscureText: true,
              textAlign: TextAlign.left,
              onChanged: (value) {
                password = value;
              },
              decoration: kTextFieldDecoration.copyWith(
                  hintText: 'confirm your password'),
            ),
            SizedBox(
              height: 24.0,
            ),
            RoundedButton(
              title: 'Register',
              colour: Colors.green,
              onPressed: () async {
                try {
                  //ignore: unused_local_variable
                  final newUser = await _auth.createUserWithEmailAndPassword(
                      email: email, password: password);

                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => MainPage()));
                } catch (e) {
                  print(e);
                  Toast.show("$e", context,
                      duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
