import 'post.dart';
import 'package:flutter/material.dart';
import 'add_post.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_database/firebase_database.dart';
import 'viewPost.dart';
import 'package:timeago/timeago.dart' as timeago;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseDatabase _database = FirebaseDatabase.instance;
  String nodeName = "posts";
  List<Post> postsList = <Post>[];

  @override
  // ignore: must_call_super
  void initState() {
    _database.reference().child(nodeName).onChildAdded.listen(_childAdded);
    _database.reference().child(nodeName).onChildRemoved.listen(_childRemoves);
    _database.reference().child(nodeName).onChildChanged.listen(_childChanged);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "",
          style: TextStyle(
              color: Theme.of(context).primaryColorDark,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AddPost()));
            },
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            //backgroundColor: Colors.grey.shade50,
            backgroundColor: Color.fromRGBO(231, 111, 81, 1),
            label: Center(
              child: Text(
                "Publish",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        color: Theme.of(context).primaryColor,
        child: Column(
          children: <Widget>[
            Flexible(
                child: FirebaseAnimatedList(
                    query: _database.reference().child('posts'),
                    itemBuilder: (_, DataSnapshot snap,
                        Animation<double> animation, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Card(
                          margin: EdgeInsets.all(1),
                          elevation: 1,
                          shadowColor: Colors.grey,
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PostView(postsList[index])));
                            },
                            title: Text(
                              postsList[index].title,
                              style: TextStyle(
                                height: 1.5,
                                fontSize: 19.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing: Text(
                              timeago.format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      postsList[index].date)),
                              style: TextStyle(
                                  height: 1.5,
                                  fontSize: 10.0,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.normal),
                              maxLines: 2,
                              textAlign: TextAlign.justify,
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(bottom: 14.0),
                              child: Text(
                                postsList[index].body,
                                style: TextStyle(
                                    height: 1.2,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ),
                        ),
                      );
                    })),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {
      //     Navigator.push(
      //         context, MaterialPageRoute(builder: (context) => AddPost()));
      //   },
      //   backgroundColor: Color.fromRGBO(231, 111, 81, 265),
      //   label: Center(
      //     child: Text(
      //       "Publish",
      //       style: TextStyle(
      //         fontWeight: FontWeight.bold,
      //         fontSize: 20,
      //       ),
      //     ),
      //   ),
      //   hoverColor: Colors.black,
      //   tooltip: "Click here if you want to unleash your creativity",
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }

  _childAdded(Event event) {
    setState(() {
      postsList.add(Post.fromSnapshot(event.snapshot));
    });
  }

  void _childRemoves(Event event) {
    var deletedPost = postsList.singleWhere((post) {
      return post.key == event.snapshot.key;
    });

    setState(() {
      postsList.removeAt(postsList.indexOf(deletedPost));
    });
  }

  void _childChanged(Event event) {
    var changedPost = postsList.singleWhere((post) {
      return post.key == event.snapshot.key;
    });

    setState(() {
      postsList[postsList.indexOf(changedPost)] =
          Post.fromSnapshot(event.snapshot);
    });
  }
}
