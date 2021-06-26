import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/constants.dart';
import 'package:flutter_application/screens/Bookprofile.dart';
import 'package:flutter_application/screens/homepage.dart';

//import 'package:flutter_svg/flutter_svg.dart';

class Searchpage extends StatefulWidget {
  static String id = 'search_screen';

  _Searchpage createState() => _Searchpage();
}

class _Searchpage extends State<Searchpage> {

  final TextEditingController _searchBook = new TextEditingController();

  String _searchText = "";
  bool isSearching = false;

  // void _filterBooks(value) {
  //   print(value);
  // }
  void selectscreen3(BuildContext ctx) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return Homepage();
    }));
  }

  _Searchpage() {
    _searchBook.addListener(() {
      if (_searchBook.text.isEmpty) {
        setState(() {
          isSearching = false;
          _searchText = "";
        });
      } else {
        setState(() {
          isSearching = true;
          _searchText = _searchBook.text.toString();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:  IconButton(

            onPressed: (){

              Navigator.pop(context);
             // selectscreen3(context);
            },
            icon: Icon(Icons.arrow_back,
              color: Colors.white,),

          /*  SvgPicture.asset("asset/icons/back.svg",
            color:Colors.white,
            //kTextcolor,
            ) */
        ),
        backgroundColor: kTextcolor,
        automaticallyImplyLeading: false
        ,
        title:

             TextField(
                controller: _searchBook,
                onChanged: (value) {
                  setState(() {
                    // _filterBooks(value);
                  });
                },
                keyboardType: TextInputType.text,
                style: TextStyle(color: Colors.white, fontSize: 16),
                maxLines: 1,
                decoration: new InputDecoration(
                  hintText: " Book title or author name",
                  hintStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey, width: 1.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey, width: 1.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 12),
                  //Change this value to custom as you like
                  isDense: true,
                  border: InputBorder.none,
                ),
              ),
        // actions: <Widget>[
        //   !isSearching
        //       ? IconButton(
        //           icon: const Icon(Icons.cancel),
        //           onPressed: () {
        //             setState(() {
        //               _searchBook.clear();
        //               this.isSearching = false;
        //             });
        //           },
        //         )
        //       : IconButton(
        //           icon: const Icon(Icons.search),
        //           onPressed: () {
        //             setState(() {
        //               this.isSearching = true;
        //             });
        //           },
        //         ),
        //
        // ],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: (_searchText == null || _searchText == "")
              ? FirebaseFirestore.instance.collection('Books').snapshots()
              : FirebaseFirestore.instance.collection('Books')
                  .where('searchindex', arrayContains: _searchText.toLowerCase()).snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) return new Text('Loading...');

            return new ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot data = snapshot.data.docs[index];
                  //children: snapshot.data.docs.map((document) {
                  return ListTile(
                    leading: const Icon(Icons.flight_land),
                    title: new Text(
                      data['title'],
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                    ),
                    subtitle: new Text(
                      data['author'],
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                    ),
                    trailing: Icon(Icons.keyboard_arrow_right_sharp),
                    enabled: true,
                    dense: true,
                    selected: false,
                    onTap: () {
                      return
                        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                          return Bookprofile(title:data['title'] ,author:data['author'] ,description:data['description'] ,ISBN: data['isbn'],category: data['category'],image:data['imageurl']);
                        }
                        ));
                     // print('thebookpageof '+  data['title'].toString(),);
                    },
                  );

                  /*  ListTile(
          leading: const Icon(Icons.flight_land ),
          title:new  Text(data['name'], style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),
          subtitle: new Text(data['author'], style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300),),
          trailing: Icon(Icons.keyboard_arrow_right_sharp),
          enabled: true,
          dense: true,
          selected: false,

          onTap: (){
            print('thebookpage');
          },

        ); */
                });
          }),
    );
  }
}
/*Widget buildBook(Book book) => ListTile(
  leading: Image.network(
    book.urlImage,
    fit: BoxFit.cover,
    width: 50,
    height: 50,
  ),
  title: Text(book.title),
  subtitle: Text(book.author),
); */
/* class BooksList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Books').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

        if (
        !snapshot.hasData

        )
          return new Text('Loading...');

        return new ListView(
          children: snapshot.data.docs.map((document) {





            return
              new ListTile(
              leading: const Icon(Icons.flight_land,

              ),
              title: new Text(document.data()['name']?? 'default'.contains(_searchText), style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),
              subtitle: new Text(document.data()['author']?? 'default', style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300),),
              trailing: Icon(Icons.keyboard_arrow_right_sharp),
              dense: true,
              selected: false,

              onTap: (){
                print('thebookpage');
              },

            );
          }).toList(),
        );
      },
    );
  }
}  */
