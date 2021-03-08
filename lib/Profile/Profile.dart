import 'package:AutoSale/Home/Home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Profilescreen extends StatefulWidget {
  @override
  _ProfilescreenState createState() => _ProfilescreenState();
}

class _ProfilescreenState extends State<Profilescreen> {
  String id = FirebaseAuth.instance.currentUser.uid;
  String _userName;
  void initState() {
    super.initState();
    _getUserName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Homescreen()));
            },
          ),
          title: Text("Profile", style: TextStyle(letterSpacing: 1.1)),
          //centerTitle: true,
        ),
        body: ListView(children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  // Text("Shop Name", style: TextStyle(fontSize: 30)),
                  Icon(Icons.settings),
                ]),
          ),
          Column(
            children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.amber,
                      radius: 50,
                    )
                  ]),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  right: 8,
                ),
                child: Row(children: <Widget>[
                  Text("Shop Name",
                      style: TextStyle(fontSize: 30, color: Colors.black)),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Divider(
                  //thickness: 1,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 18),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Text("Name :"),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text("Kasun"),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Text("ContactNo: :"),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text("0771234567"),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Text("Location :"),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text("Mawanella"),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Text("Email: :"),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text("abcd@gmail.com"),
                    ),
                    RaisedButton(onPressed: () {
                      print(_userName);
                    })
                  ],
                ),
              ),
            ],
          )
        ]));
  }

  Future<void> _getUserName() async {
    FirebaseFirestore.instance
        .collection('Users')
        .doc((await FirebaseAuth.instance.currentUser).uid)
        .get()
        .then((value) {
      setState(() {
        _userName = value.data()['Name'].toString();
      });
    });
  }
}
