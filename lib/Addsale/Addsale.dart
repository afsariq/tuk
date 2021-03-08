import 'package:flutter/material.dart';

class Addsale extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: <Widget>[
        Column(
          children: <Widget>[
            Image.asset(
              "Assets/Images/logo.png",
              width: 120,
              height: 120,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: TextField(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blueAccent,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: "Shop Name",
                  prefixIcon: Icon(Icons.home),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blueAccent,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: "User name",
                    prefixIcon: Icon(
                      Icons.person,
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                  decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blueAccent,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintText: "Phone Number",
                prefixIcon: Icon(Icons.phone),
              )),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                  decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blueAccent,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintText: "City",
                prefixIcon: Icon(Icons.location_city),
              )),
            ),
            SizedBox(height: 30),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.green),
              child: FlatButton(
                  onPressed: () {},
                  child: Text("Create Your Shop",
                      style: TextStyle(color: Colors.white, fontSize: 17))),
            ),
            SizedBox(height: 20),
          ],
        )
      ]),
    );
  }
}
