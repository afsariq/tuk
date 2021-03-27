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
import 'package:intl/intl.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// ignore: must_be_immutable
class Homescreen extends StatefulWidget {
  // String id = FirebaseAuth.instance.currentUser.uid;

  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
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
                      Navigator.pop(context);
                    },
                    child: Text(
                      "No",
                      style: TextStyle(color: Colors.black),
                    ))
              ]);
        });
  }

  ///var userlist = FirebaseFirestore.instance
  ///.collection('Users')
  //.get()
  //.then((value) => value.docs);
  String value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        //title: Image.asset("Assets/Images/logo.png", width: 80, height: 70),
        // centerTitle: true,

        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Seachsalescreen()));
              }),
          Center(
              child: IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              if (FirebaseAuth.instance.currentUser == null) {
                AlertDialog alert = AlertDialog(
                  title:
                      Text("You have to create an account to add your vehicle"),
                  actions: [
                    FlatButton(
                      child: Row(
                        children: [
                          Text("Back"),
                        ],
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    FlatButton(
                      child: Row(
                        children: [
                          Text("Setup your profile"),
                        ],
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Singupscreen()));
                      },
                    ),
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
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Addtuk()));
              }

              // do something
              // User firebaseUser = FirebaseAuth.instance.currentUser;
            },
          )),
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
                  Image.asset(
                    "Assets/Images/logo.png",
                    width: 100,
                    height: 100,
                  ),
                  SpinKitPulse(
                    color: Colors.green,
                    size: 30.0,
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.amber,
              ),
            ),
            //SizedBox(height: 50),
            ListTile(
              title: Text(
                'Profile',
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {
                if (FirebaseAuth.instance.currentUser == null) {
                  AlertDialog alert = AlertDialog(
                    title: Text("You don't have an account yet"),
                    actions: [
                      FlatButton(
                        child: Row(
                          children: [
                            Text("Back"),
                          ],
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      FlatButton(
                        child: Row(
                          children: [
                            Text("Setup your profile"),
                          ],
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Singupscreen()));
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
                      MaterialPageRoute(builder: (context) => Profilescreen()));
                }

                // print(userlist);
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
                //Navigator.pushReplacement(
                //  context, MaterialPageRoute(builder: (context) => Addtuk()));
                // Update the state of the app.
                // ...
                if (FirebaseAuth.instance.currentUser == null) {
                  AlertDialog alert = AlertDialog(
                    title: Text(
                        "You have to create an account to add your vehicle"),
                    actions: [
                      FlatButton(
                        child: Row(
                          children: [
                            Text("Back"),
                          ],
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      FlatButton(
                        child: Row(
                          children: [
                            Text("Setup your profile"),
                          ],
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Singupscreen()));
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
                      MaterialPageRoute(builder: (context) => Addtuk()));
                }
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
                if (FirebaseAuth.instance.currentUser == null) {
                  AlertDialog alert = AlertDialog(
                    title: Text("You don't have an Sale yet"),
                    actions: [
                      FlatButton(
                        child: Row(
                          children: [
                            Text("Back"),
                          ],
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      FlatButton(
                        child: Row(
                          children: [
                            Text("Setup your Sale"),
                          ],
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Singupscreen()));
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
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Yoursalescreen()));
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
                          Navigator.pop(context);
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
        // get snapshots of users collections
        stream: FirebaseFirestore.instance.collection("Users").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
            // Center(child: LoadingFilling.square());
          }

          return SingleChildScrollView(
            child: Column(
              // Go through each user document
              children: snapshot.data.docs.map((docReference) {
                return StreamBuilder(
                  // get snapshots of sales collection of each user
                  stream: docReference.reference
                      .collection('Sale')
                      .orderBy("date", descending: true)
                      .snapshots(),
                  builder: (_, AsyncSnapshot<QuerySnapshot> collectionSnap) {
                    // display each sales data
                    return collectionSnap.hasData
                        ? Column(
                            children: collectionSnap.data.docs
                                .map((documentSnap) =>
                                    _TukDataWidget(document: documentSnap))
                                .toList(),
                          )
                        : CircularProgressIndicator();
                    //Center(child: LoadingFilling.square());
                    // CircularProgressIndicator();
                  },
                );
              }).toList(),
            ),
          );
          // .collection('Sale')
          // .orderBy("date", descending: true)
          // .snapshots();

          // return ListView(
          //   children: snapshot.data.docs.map((document) {
          //     return _TukDataWidget(document: document);
          //   }).toList(),
          // );
        },
      ),
    );
  }

  _signOut() async {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    await _firebaseAuth.signOut();
  }
}

/// Display Tuk data
class _TukDataWidget extends StatelessWidget {
  const _TukDataWidget({
    Key key,
    @required this.document,
  }) : super(key: key);

  final QueryDocumentSnapshot document;

  @override
  Widget build(BuildContext context) {
    Timestamp t = document["date"];
    DateTime d = t.toDate();

    DateFormat.yMd().format(d);
    return Column(
      children: <Widget>[
        Column(
          children: [
            SizedBox(height: 10),

            SizedBox(height: 30),
            Row(
              children: <Widget>[
                //* image
                Expanded(
                  flex: 2,
                  child: Image.network(
                    document["Image"],
                    width: 100,
                    height: 100,
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  flex: 4,
                  child: Column(children: [
                    //* model
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Model :",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            document["Model"],
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),

                    //* year
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Location :",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            document["Location"],
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),

                    //* contact number
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Contact No :",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            document["Phone"],
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),

                    //* location
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Price :",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            document["Price"],
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),

                    //* price
                    Divider(),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Details :",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            document["Year"],
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Date :",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            DateFormat('yyyy/MM/dd').format(d),
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                        //Text(document['year'])
                      ],
                    ),
                  ]),
                ),
                //Flexible(child: Text(document['year'])),
              ],
            ),
            //
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
  }
}
