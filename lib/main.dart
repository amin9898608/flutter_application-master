import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application/AddArticle/add_post.dart';
import 'package:flutter_application/AddArticle/home.dart';
import 'package:flutter_application/SignInRegister/welcome_screen.dart';
import 'package:flutter_application/constants.dart';
import 'screens/homepage.dart';
import 'screens/searchpage.dart';
import 'screens/productsoverviewscreen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: WelcomeScreen(),
      theme: ThemeData(
    primaryColor: Colors.white,
    primaryColorDark: Color.fromRGBO(7, 16, 19, 265))
    );


  }
}
class MainPage extends StatefulWidget {
  static const String id = 'MainPage';
  MainPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  int selectedIndex = 0;
  List<Widget> listWidgets = [Homepage(),HomePage(),ProductsOverviewScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listWidgets[selectedIndex],
      bottomNavigationBar: ConvexAppBar.badge({3: '9+'},
        items: [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.edit, title: 'Publish'),
          TabItem(icon: Icons.add, title: 'Add'),
          TabItem(icon: Icons.message, title: 'Message'),
          TabItem(icon: Icons.menu, title: 'Menu'),

        ],
        onTap: onItemTapped,
        backgroundColor: kTextcolor,
      ),
    );
  }

  void onItemTapped(int index){
    setState(() {
      selectedIndex = index;
    });
  }

}
