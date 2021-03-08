import 'package:AutoSale/Home/Home.dart';
import 'package:flutter/material.dart';

class Otpscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        Column(
          children: [
            SizedBox(height: 60),
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
                hintText: "Enter the OTP password that we sent you",
              )),
            ),
            SizedBox(height: 30),
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.green),
                child: FlatButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Homescreen()));
                  },
                  child: Text("Continue",
                      style:
                          TextStyle(color: Colors.white, letterSpacing: 1.5)),
                ))
          ],
        )
      ]),
    );
  }
}
