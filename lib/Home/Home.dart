import 'package:AutoSale/Addtuk/Addtuk.dart';
import 'package:AutoSale/Editprofile/Editprofile.dart';
import 'package:AutoSale/Profile/Profile.dart';
import 'package:AutoSale/Searchsale/Searchsale.dart';
import 'package:AutoSale/SignIn/Signin.dart';
import 'package:AutoSale/SignUp/Signup.dart';
import 'package:AutoSale/Yoursale/Yoursale.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: must_be_immutable
class Homescreen extends StatelessWidget {
  // String id = FirebaseAuth.instance.currentUser.uid;

  void _validation(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
              backgroundColor: Colors.white,
              content: Text("Are you sure you want to logout"),
              actions: <Widget>[
                OutlineButton(
                    onPressed: () {
                      _signOut();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Signinscreen()));
                    },
                    child: Text(
                      "Yes",
                      style: TextStyle(color: Colors.black),
                    )),
                OutlineButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Homescreen()));
                    },
                    child: Text(
                      "No",
                      style: TextStyle(color: Colors.black),
                    ))
              ]);
        });
  }

  var userlist = FirebaseFirestore.instance
      .collection('Users')
      .get()
      .then((value) => value.docs);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset("Assets/Images/logo.png", width: 80, height: 70),
        // centerTitle: true,
        actions: <Widget>[
          Center(
              child: IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              // do something
              // User firebaseUser = FirebaseAuth.instance.currentUser;

              if (FirebaseAuth.instance.currentUser != null) {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Addtuk()));
                //print('abcd');
              } else {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Singupscreen()));
              }
            },
          ))
        ],
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: ListView(
                children: [
                  Center(
                      child: Text(
                    'Shop Name',
                    style: TextStyle(fontSize: 25),
                  )),
                  CircleAvatar(
                    backgroundImage: AssetImage("Assets/Images/search.png"),
                    radius: 50,
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            //SizedBox(height: 50),
            ListTile(
              title: Text(
                'Profile',
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Profilescreen()));
                print(userlist);
              },
            ),
            ListTile(
              title: Text(
                'Edit Profile',
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Editprofilescreen()));
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Text(
                'Add a tuk for sale',
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Addtuk()));
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Text(
                'Search a Sale',
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Seachsalescreen()));
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Text(
                'Your Sale',
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {
                if (FirebaseAuth.instance.currentUser != null) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Yoursalescreen()));
                  //print('abcd');
                } else {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Singupscreen()));
                }
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Text(
                'Create your virtual sale',
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {
                if (FirebaseAuth.instance.currentUser != null) {
                  AlertDialog alert = AlertDialog(
                    title: Text("You've already created your sale"),
                    actions: [
                      FlatButton(
                        child: Row(
                          children: [
                            Text("Go to home"),
                          ],
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Homescreen()));
                        },
                      ),
                      FlatButton(
                        child: Row(
                          children: [
                            Text("See your sale"),
                          ],
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Yoursalescreen()));
                        },
                      )
                    ],
                  );
                  showDialog(
                      context: context,
                      builder: (BuildContext) {
                        return alert;
                      },
                      barrierDismissible: true);

                  //print('abcd');
                } else {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Singupscreen()));
                }
                // Navigator.pushReplacement(context,
                //   MaterialPageRoute(builder: (context) => Singupscreen()));
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Text(
                'Logout',
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {
                _validation(context);
              },
            ),
          ],
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .doc(FirebaseAuth.instance.currentUser.uid)
            .collection('Sale')
            .orderBy("date", descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return LoadingFlipping.circle();
          }
          return ListView(
              children: snapshot.data.docs.map((document) {
            return Column(
              children: <Widget>[
                Row(mainAxisAlignment: MainAxisAlignment.center, children: []),
                Column(
                  children: [
                    SizedBox(height: 10),
                    SizedBox(height: 30),
                    Row(
                      children: <Widget>[
                        Expanded(
                            flex: 1,
                            child: Image.network(
                              document["Image"],
                              width: 100,
                              height: 100,
                            )),
                        Expanded(
                          flex: 1,
                          child: Column(children: [
                            Row(
                              children: [
                                Text(
                                  "Model :",
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  document["Model"],
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Text(
                                  "Year :",
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  document["Year"],
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Text(
                                  "Contact No :",
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  document["Phone"],
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Text(
                                  "Location :",
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  document["Location"],
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Text(
                                  "Price :",
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  document["Price"],
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ]),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                )
              ],
            );
          }).toList());
        },
      ),
    );
  }

  _signOut() async {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    await _firebaseAuth.signOut();
  }
}
