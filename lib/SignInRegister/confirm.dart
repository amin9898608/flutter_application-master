import 'bdd/bdd.dart';
import 'package:flutter/material.dart';

class Accueil extends StatefulWidget {
  static const String id = 'Accueil';

  @override
  AccueilState createState() => AccueilState();
}

class AccueilState extends State<Accueil> {
  var userData = Utilisateur(
    id: '',
    name: '',
    userFullName: '',
    email: 'adel1@gmail.com',
    imageURL: '',
    password: '12345678',
  );

  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Container(
                child: Column(children: <Widget>[
              Material(
                borderRadius: BorderRadius.all(Radius.circular(50.0)),
              )
            ])),
          ),
          Champ(Icons.person, 'Profile', () {
            //Navigator.push(
              //  context,
                //MaterialPageRoute(
                  //  builder: (context) => EditprofilePatient(userData)));
          }
              //() => {},
              ),
          Champ(Icons.book, ' add book', () {
            ;
          }),
          /*Champ(
              Icons., 'Categories', ()=>{},

            ),*/
          Champ(
            Icons.message,
            'Messages',
            () => {},
          ),
          /*Champ(
              Icons.pencil, 'Publish', ()=>{},

            ),*/
          Champ(
            Icons.settings,
            ' settings',
            () => {},
          ),
        ],
      ),
    ));
  }
}

// ignore: must_be_immutable
class Champ extends StatefulWidget {
  IconData icon;
  String text;
  var on_Pressed;

  Champ(this.icon, this.text, this.on_Pressed);

  @override
  _ChampState createState() =>
      _ChampState(this.icon, this.text, this.on_Pressed);
}

class _ChampState extends State<Champ> {
  IconData icon;
  String text;
  var on_Pressed;
  _ChampState(this.icon, this.text, this.on_Pressed);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: InkWell(
        onTap: on_Pressed,
        child: Container(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(widget.icon),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.text,
                      style: TextStyle(fontSize: 16.0),
                    ),
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
