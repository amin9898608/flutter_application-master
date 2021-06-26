import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/constants.dart';
import 'package:flutter_application/databaseservices.dart';

import 'categories.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List userProfilesList = [];

  String userID = "";

  @override
  void initState() {
   super.initState();
    //fetchUserInfo();
    fetchDatabaseList();
  }

  fetchDatabaseList() async {
    dynamic resultant = await DatabaseServices().Getinfo();
    if (resultant == null) {
      print('Unable to retrieve');
    } else {
      setState(() {
        userProfilesList = resultant;
      });
    }
  }
  Future<List<Map<String, dynamic>>> _loadImage() async {
    List<Map<String, dynamic>> images = [];

    final ListResult result = await FirebaseStorage.instance.ref().list();
    final List<Reference> allFiles = result.items;

    await Future.forEach<Reference>(allFiles, (file) async {
      final String fileurl = await file.getDownloadURL();
      images.add({
        "url": fileurl,
      });
    });
  }
  final FirebaseFirestore fb = FirebaseFirestore.instance;
/*  Future<QuerySnapshot<Map<String, dynamic>>> getImages() {
    return fb.collection("images").get();
  }*/

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Categories(),
        Expanded(
          child:FutureBuilder(
              future: _loadImage(),
              builder: (context, index) {
                return Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: kDefaultpaddin),
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: kDefaultpaddin / 2,
                        crossAxisSpacing: kDefaultpaddin,
                        childAspectRatio: 0.75,
                      ),
                      itemCount: userProfilesList.length,
                      itemBuilder: (context, int index) {
                        //   final image = snapshot.data[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: kDefaultpaddin / 2),
                          child: Container(
                            height: 180,
                            width: 180,
                            decoration: BoxDecoration(
                                color: kTextlightcolor,
                                borderRadius: BorderRadius.circular(8.0)

                            ),
                            child: ListTile(
                          //    leading: Image.network(),
                              title: Text(userProfilesList[index]['title']),
                              subtitle: Text(userProfilesList[index]['author']),
                              //Image.network(userProfilesList[index]['imageurl']),
                              trailing:
                              Text(userProfilesList[index]['category']),
                            ),

                          ),
                        );
                      }),
                );
              }),
          /*FutureBuilder(
            future: getImages(),
            builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        contentPadding: EdgeInsets.all(8.0),
                        title: Text(snapshot.data.docs[index].data()["name"]),
                        leading: Image.network(
                            snapshot.data.docs[index].data()["url"],
                            fit: BoxFit.fill),
                      );
                    });
              } else if (snapshot.connectionState == ConnectionState.none) {
                return Text("No data");
              }
              return CircularProgressIndicator();
            },
          ),*/



        ),
      ],
    );

  }
}
