import 'package:flutter/material.dart';
import 'Login.dart';
import 'SignUp.dart';

import 'components/rounded_button.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("asset/icons/books.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: ButtonTheme(
            minWidth: 180.0,
            height: 70.0,
            child: Row(
              children: [
                RoundedButton(
                  title: 'Log In',
                  colour: Colors.green.shade900,
                  onPressed: () {

                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (context) => LoginScreen()));

                  },
                ),
                RoundedButton(
                  title: 'Register',
                  colour: Colors.orange.shade900,
                  onPressed: () {
                    //Navigator.pushNamed(context, SignUp.id);
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (context) => SignUp()));

                  },
                )
              ],
            )));
  }
}
