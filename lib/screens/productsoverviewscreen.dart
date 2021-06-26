import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart' as path;
import 'package:flutter_application/databaseservices.dart';
import 'dart:io';
import 'package:flutter_application/constants.dart';
import 'package:image_picker/image_picker.dart';

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String choosevalue = "Novel";

  List<String> listitem = [
    "Novel",
    "Historic",
    "Biography",
    "Science",
    "Comics",
    "Education",
    "Cooking",
    "Philosophy",
    "Psycology",
    "Religion",
  ];

  //image picker function ...
  File _image;

  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }
  int i = 0 ;
  Future<void> _upload(String inputSource, String name) async {
    final picker = ImagePicker();
    PickedFile pickedImage;
    try{
      pickedImage = await picker.getImage(
          source: inputSource == 'camera'
              ? ImageSource.camera
              : ImageSource.gallery,
          maxWidth: 1920);
      final String fileName = path.basename(pickedImage.path);
      File imageFile = File(pickedImage.path);
      try{
        await FirebaseStorage.instance.ref('images').child(name).putFile(
           _image = imageFile,
            );
        setState(() {});
      }on FirebaseException catch (error) {
        print(error);
      }
    }catch (err) {
      print(err);
    }
  } //producttitlecontroller.text.trim();//product infos variables

    //Create an option chooser for selecting camera / gallery
  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _upload('gallery',  producttitlecontroller.text.trim());
                       Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _upload('camera',  producttitlecontroller.text.trim());
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }



  TextEditingController producttitlecontroller = TextEditingController();
  TextEditingController productauthorname = TextEditingController();
  TextEditingController productisbn = TextEditingController();
  TextEditingController productdescription = TextEditingController();

  // home page design and ... :



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: kTextcolor,
          title: Text("Add A Book")),
      body: Center(
        child: ListView(
          children: [
            SizedBox(
              height: 32,
            ),
            Container(
              child: GestureDetector(
                onTap: () {
                  _showPicker(context);
                },
                child: CircleAvatar(
                  radius: 55,
                  backgroundColor: kTextcolor,
                  child: _image != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.file(
                            _image,
                            width: 100,
                            height: 100,
                            fit: BoxFit.fitHeight,
                          ),
                        )
                      : Container(
                         decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(50)),
                          width: 100,
                          height: 100,
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.grey[800],
                          ),
                        ),
                ),
              ),
            ),
            //),
            //    childre: Column(
            //   children: [
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: kDefaultpaddin, vertical: kDefaultpaddin),
               child: Container(
                  child: TextFormField(
                    controller: producttitlecontroller,
                    decoration: InputDecoration(
                      labelText: "Title",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
             ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultpaddin, vertical: kDefaultpaddin),
              child: Container(
                child: TextFormField(
                  controller: productauthorname,
                  decoration: InputDecoration(
                    labelText: "Author Name",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultpaddin, vertical: kDefaultpaddin),
              child: Container(
                child: TextFormField(
                  controller: productisbn,
                  decoration: InputDecoration(
                    labelText: "Book ISBN",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultpaddin , vertical: kDefaultpaddin),
              child: Container(
                child: TextFormField(
                  controller: productdescription,
                  decoration: InputDecoration(
                    labelText: "Description",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultpaddin , vertical: kDefaultpaddin),
              child: Container(
                child: DropdownButtonFormField(
                    value: choosevalue,
                    icon: Icon(Icons.arrow_downward),
                    decoration: InputDecoration(
                    labelText: "Select Category",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                    items: listitem.map((String value){
                      return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                      );
                    }).toList(),
                  onChanged: (String newvalue){
                      setState(() {
                        choosevalue =newvalue ;
                      });
                  },
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text('Add'),
                  color: kTextcolor,
                  onPressed: () async {
                     Navigator.pop(context);
                    if (producttitlecontroller.text.isNotEmpty) {



                      await DatabaseServices().CreateNewProduct(
                        producttitlecontroller.text.trim(),
                        productauthorname.text.trim(),
                        productisbn.text.trim(),
                        productdescription.text.trim(),
                        _image.toString(),
                       choosevalue
                      );


                    }


                  }),
            ),
          ], // children
        ),
      ),
    );
  }
}
