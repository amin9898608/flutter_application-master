import 'package:flutter/material.dart';
import 'package:flutter_application/constants.dart';
import 'package:flutter_application/screens/body.dart';
import 'package:flutter_application/screens/searchpage.dart';
//import 'package:flutter_svg/flutter_svg.dart';

import 'productsoverviewscreen.dart';

class Homepage extends StatelessWidget {
  void selectscreen(BuildContext ctx) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return ProductsOverviewScreen();
    }));
  }

  void selectscreen2(BuildContext ctx) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return Searchpage();
    }));
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(
              Icons.menu_book,
              color: kTextcolor,
              size: 40.0,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        title: Text("Ktabna",
            style: TextStyle(
              color: kTextcolor,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            )),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: <Widget>[
          IconButton(
              onPressed: () {
                selectscreen2(context);
              },
              icon: Icon(Icons.search,
              color: Colors.black,),

              /*SvgPicture.asset(
                "asset/icons/search.svg",
                color: kTextcolor,
              ) */


          ),
        ],
      ),
      body: Body(),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: kTextcolor,
              ),

            ),
          ],
        ),
      ),
      //ProductsListItem(),
      floatingActionButton: FloatingActionButton(
        child: Text(
          "+",
          style: TextStyle(fontSize: 30),
        ),
        backgroundColor: kTextcolor,
        onPressed: () => selectscreen(context),
      ),
    );
  }
}
