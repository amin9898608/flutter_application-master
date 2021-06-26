import 'package:firebase_database/firebase_database.dart';
import 'PostService.dart';
import 'post.dart';
import 'edit_post.dart';
import 'package:flutter/material.dart';
import 'home.dart';

class PostView extends StatefulWidget {
  final Post post;

  PostView(this.post);

  @override
  _PostViewState createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  String nodeName = "posts";
  DatabaseReference reference =
      FirebaseDatabase.instance.reference().child("posts");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit your post",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    widget.post.title,
                    style: TextStyle(
                      fontSize: 20.0,
                      height: 1.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content:
                              Text("Are you sure that you want to delete this?",
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 20,
                                  )),
                          actions: [
                            // ignore: deprecated_member_use
                            FlatButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Cancel',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20))),
                            // ignore: deprecated_member_use
                            FlatButton(
                                onPressed: () {
                                  PostService postService =
                                      PostService(widget.post.toMap());
                                  postService.deletePost();
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomePage()),
                                    (Route<dynamic> route) => false,
                                  );
                                },
                                child: Text(
                                  'Delete',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.red),
                                ))
                          ],
                        );
                      });
                },
              ),
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditPost(widget.post)));
                },
              ),
            ],
          ),
          const Divider(
            height: 10,
            thickness: 2,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(widget.post.body,
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
