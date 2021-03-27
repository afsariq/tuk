import 'package:AutoSale/Home/Home.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Seachsalescreen extends StatefulWidget {
  @override
  _SeachsalescreenState createState() => _SeachsalescreenState();
}

class _SeachsalescreenState extends State<Seachsalescreen> {
  final TextEditingController searchCont = TextEditingController();
  String loc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Homescreen()));
            }),
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
                      .where('Location', isEqualTo: 'kandy')
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
}

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
