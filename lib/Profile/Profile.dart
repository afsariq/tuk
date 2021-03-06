import 'package:AutoSale/Editprofile/Editprofile.dart';
import 'package:AutoSale/Home/Home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class Profilescreen extends StatefulWidget {
  @override
  _ProfilescreenState createState() => _ProfilescreenState();
}

class _ProfilescreenState extends State<Profilescreen> {
  File sampleImage;
  final picker = ImagePicker();
  String id = FirebaseAuth.instance.currentUser.uid;
  String _userName = '';
  String _phone = '';
  String _location = '';
  String _salename = '';
  String _email = '';
  
  void initState() {
    super.initState();
    _getUserName();
   
  }


  // String id = FirebaseAuth.instance.currentUser.uid;
  static final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            Center(
                child: IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Editprofilescreen()));
              },
            ))
          ],
          backgroundColor: Colors.amber,
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
          Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
            
              
             
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  right: 8,
                ),
                child: Row(children: <Widget>[
                  SizedBox(height: 30),
                  Text(_salename,
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
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(left: 30.0, bottom: 10, top: 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Text(
                        "User Name :",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(_userName),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.only(left: 30.0, bottom: 10, top: 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Text(
                        "ContactNo: :",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(_phone),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.only(left: 30.0, bottom: 10, top: 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Text(
                        "Location :",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(_location),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.only(left: 30.0, bottom: 10, top: 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Text(
                        "Email: :",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(_email),
                    ),
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
        .doc((FirebaseAuth.instance.currentUser).uid)
        .get()
        .then((value) {
      setState(() {
        _userName = value.data()['Name'].toString();
        _phone = value.data()['Phone'].toString();
        _location = value.data()['City'].toString();
        _salename = value.data()['ShopName'].toString();
        _email = FirebaseAuth.instance.currentUser.email;
      });
    });
  }

  
}
