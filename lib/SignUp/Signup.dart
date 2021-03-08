import 'package:flutter/material.dart';
import 'package:AutoSale/SignIn/Signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: must_be_immutable
class Singupscreen extends StatelessWidget {
  static final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  final TextEditingController email = TextEditingController(),
      password = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController shopname = TextEditingController();
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
                controller: shopname,
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
                  ),
                ),
                controller: name,
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
                  ),
                  controller: phone),
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
                ),
                controller: city,
              ),
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
                  hintText: "Email",
                  prefixIcon: Icon(Icons.email),
                ),
                controller: email,
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
                    hintText: "Password",
                    prefixIcon: Icon(
                      Icons.fingerprint,
                    )),
                controller: password,
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
                hintText: "Confirm Password",
                prefixIcon: Icon(Icons.fingerprint),
              )),
            ),
            SizedBox(height: 30),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.green),
              child: FlatButton(
                  onPressed: () {
                    // Navigator.pushReplacement(context,
                    //   MaterialPageRoute(builder: (context) => Otpscreen()));
                    createuser(context);
                  },
                  child: Text("Create Your Sale",
                      style: TextStyle(color: Colors.white, fontSize: 17))),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Already have an account?  "),
                GestureDetector(
                    child: Text(
                      "Signin",
                      style: TextStyle(color: Colors.blue),
                    ),
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Signinscreen()));
                    }),
                SizedBox(height: 20),
              ],
            ),
          ],
        )
      ]),
    );
  }

  Future<void> createuser(BuildContext context) async {
    try {
      const KEY_SHOPNAME = "ShopName";
      const KEY_NAME = "Name";
      const KEY_PHONE = "Phone";
      const KEY_CITY = "City";
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.text, password: password.text);
      await _fireStore.collection('Users').doc(userCredential.user.uid).set({
        KEY_SHOPNAME: shopname.text,
        KEY_NAME: name.text,
        KEY_PHONE: phone.text,
        KEY_CITY: city.text,
      });

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Signinscreen()));
      // print("user created");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}
