import 'package:AutoSale/Home/Home.dart';
import 'package:flutter/material.dart';

class Seachsalescreen extends StatelessWidget {
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
          title: Text(
            "Add a Tuk for sale",
          )),
      body: ListView(children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              height: 60,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: ("Enter Sale ID"),
                    prefixIcon: Icon(Icons.search),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
              ),
            ),
            Container(
              height: 35,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: Colors.blue),
              child: FlatButton(
                  onPressed: () {},
                  child: Text(
                    "Search",
                    style: TextStyle(color: Colors.white, letterSpacing: 1.1),
                  )),
            ),
            SizedBox(height: 30),
            Row(
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: Image.asset(
                      'Assets/Images/auto1.jpg',
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
                          "Bajaj",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
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
                          "2015",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
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
                          "0711234567",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
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
                          "Kandy",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
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
                          "Nogotiable",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
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
      ]),
    );
  }
}
