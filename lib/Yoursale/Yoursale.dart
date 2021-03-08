import 'package:AutoSale/Addtuk/Addtuk.dart';
import 'package:AutoSale/Home/Home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loading_animations/loading_animations.dart';

class Yoursalescreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Tooltip(
        message: "Add a took for your sale",
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Addtuk()));
            //print('abcd');
          },
          child: Icon(Icons.add),
        ),
      ),
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Homescreen()));
            },
          ),
          title: Text(
            "Your Sale",
          )),
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
                    // SizedBox(height: 10),
                    SizedBox(height: 20),
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
                            Row(
                              children: [
                                Text(
                                  "Date posted :",
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  document["date"].toString(),
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
}
