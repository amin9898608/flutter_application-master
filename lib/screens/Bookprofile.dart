import 'package:flutter/material.dart';
import 'package:flutter_application/Widgets/custom_tab_indicator.dart';
//import 'package:google_fonts/google_fonts.dart';

import 'searchpage.dart';

class Bookprofile extends StatelessWidget {
  static String id = "bookprofile";

  String title='';
  String author='';
  String ISBN ='';
  String image='';
  String description='';
  String category ='';



  Bookprofile({this.title,this.author,this.description,this.ISBN,this.category,this.image,});




  //this.author,this.ISBN,this.description ,this.image,
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
     /* appBar:

      AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.red,
              size: 40.0,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: Text(title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            )),
        backgroundColor: Colors.white,
        elevation: 0,

      ),   */


      bottomNavigationBar: Container(
        margin: EdgeInsets.only(left: 25, right: 25, bottom: 25),
        height: 49,
        color: Colors.transparent,
        child: FlatButton(
          color: Colors.orange,
          onPressed: () {

          },
          child: Text(
            'Contact the OWNER',
            style: TextStyle (
                fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white ,),
          ),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),



        body: SafeArea(
          child: Container(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  backgroundColor: Colors.orange,
                  expandedHeight: MediaQuery.of(context).size.height * 0.5,
                  flexibleSpace: Container(

                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Stack(
                      children: <Widget>[
                        // Positioned(
                        //   left: 25,
                        //   top: 35,
                        //   // child: GestureDetector(
                        //   //   onTap: () {
                        //   //     Navigator.pop(context);
                        //   //   },
                        //   //   child: Container(
                        //   //     width: 32,
                        //   //     height: 32,
                        //   //     decoration: BoxDecoration(
                        //   //         borderRadius: BorderRadius.circular(5),
                        //   //         color: Colors.white),
                        //   //     // child: const Icon(
                        //   //     //   Icons.arrow_back,
                        //   //     //   color: Colors.black,
                        //   //     //   size: 40.0,
                        //   //     // ),
                        //   //   ),
                        //   // ),
                        // ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            margin: EdgeInsets.only(bottom: 62),
                            width: 172,
                            height: 225,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: AssetImage(image),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SliverList(
                    delegate: SliverChildListDelegate([
                      Padding(
                        padding: EdgeInsets.only(top: 24, left: 25),
                        child: Text(
                          title,
                          style: TextStyle(
                              fontSize: 27,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 7, left: 25),
                        child: Text(
                          author,
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              fontWeight: FontWeight.w400),
                        ),
                      ),


                      // Padding(
                      //     padding: EdgeInsets.only(top: 7, left: 25),
                      //     child: Row(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: <Widget>[
                      //         Text(
                      //           '\$',
                      //           style: GoogleFonts.openSans(
                      //               fontSize: 14,
                      //               color: kMainColor,
                      //               fontWeight: FontWeight.w600),
                      //         ),
                      //         Text(
                      //           popularBookModel.price,
                      //           style: GoogleFonts.openSans(
                      //               fontSize: 32,
                      //               color: kMainColor,
                      //               fontWeight: FontWeight.w600),
                      //         ),
                      //       ],
                      //     )),


                      Container(
                        height: 28,
                        margin: EdgeInsets.only(top: 23, bottom: 36),
                        padding: EdgeInsets.only(left: 25),
                        child: DefaultTabController(
                          length: 1,
                          child: TabBar(
                              labelPadding: EdgeInsets.all(0),
                              indicatorPadding: EdgeInsets.all(0),
                              isScrollable: true,
                              labelColor: Colors.black,
                              unselectedLabelColor: Colors.grey,
                              labelStyle: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w700),
                              unselectedLabelStyle: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                               indicator: RoundedRectangleTabIndicator(
                                  weight: 2, width: 30, color: Colors.black),
                              tabs: [
                                Tab(
                                  child: Container(
                                    margin: EdgeInsets.only(right: 39),
                                    child: Text('Description'),
                                  ),
                                ),
                                // Tab(
                                //   child: Container(
                                //     margin: EdgeInsets.only(right: 39),
                                //     child: Text('Reviews'),
                                //   ),
                                // ),
                                // Tab(
                                //   child: Container(
                                //     margin: EdgeInsets.only(right: 39),
                                //     child: Text('Similar'),
                                //   ),
                                // )
                              ]),
                        ),
                      ),
//                       TabBarView(
//                        // padding: EdgeInsets.only(left: 25, right: 25, bottom: 25),
//                         children:[
//                         Text(
//                           description,
//                           style: TextStyle(
//                             fontSize: 12,
//                             fontWeight: FontWeight.w400,
//                             color: Colors.grey,
//                             letterSpacing: 1.5,
//                             height: 2,
//                           ),
//                         ),
//
//
//
// ],
//                       )
                    ]))
              ],
            ),
          ),
        ),
    );


  }
}

