import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'model/product.dart';

class DatabaseServices {
  CollectionReference booksCollecction =
      FirebaseFirestore.instance.collection("Books");


  CreateNewProduct(



       String title, String author, String isbn, String description , String imageurl , String category) async {

    List<String> indexList = [];
    String temp="";    // add the title index
    for(int i =0;i<title.length;i++) {

        temp=temp+title[i];

        indexList.add(temp);

    }


    String temp2="";  // add the author index

    for(int i =0;i<author.length;i++) {

      temp2=temp2+author[i];

      indexList.add(temp2);

    }




    return await booksCollecction.add({
      'title': title,
      'author': author,
      'isbn': isbn,
      'description': description,
      'iscomplet': false,
      'imageurl': imageurl ,
      'category': category,
      'searchindex':indexList,




    });
  }




  Future CompletTask(pid) async {
    return await booksCollecction.doc(pid).update({'iscomplet': true});
  }

  List<Product> ProductsFromFirestore(QuerySnapshot snapshot) {
    if (snapshot != null) {
      return snapshot.docs.map((e) {
        return Product(
          imageurl: e.data()["imageurl"],
          category: e.data()["category"],
          iscomplet: e.data()["iscomplet"],
          title: e.data()["title"],
          pid: e.id,
          author: e.data()['author'],
          isbn: e.data()['isbn'],
          description: e.data()['description'],
        );
      }).toList();
    } else {
      return null;
    }
  }
  Future Getinfo() async {
    List itemsList = [];

    try {
      await booksCollecction.get().then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          itemsList.add(element.data);
        });
      });
      return itemsList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

