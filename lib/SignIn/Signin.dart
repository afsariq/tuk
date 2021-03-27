import 'package:AutoSale/Home/Home.dart';
import 'package:flutter/material.dart';
import 'package:AutoSale/SignUp/Signup.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ignore: must_be_immutable
class Signinscreen extends StatelessWidget {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  static final FirebaseAuth _auth = FirebaseAuth.instance;

  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.amber,
        body: Form(
            child: ListView(children: <Widget>[
          SizedBox(height: 15),
          Column(
            children: <Widget>[
              Image.asset(
                "Assets/Images/logo.png",
                width: 120,
                height: 120,
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8),
                  child: TextField(
                      controller: _email,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blueAccent,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        hintText: "Phone/Email",
                        prefixIcon: Icon(Icons.email),
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8),
                  child: TextField(
                    controller: _password,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blueAccent,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintText: "Password",
                      prefixIcon: Icon(Icons.fingerprint),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Text(error),
              SizedBox(height: 30),
              Container(
                height: 40,
                width: 170,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.green[900]),
                child: FlatButton(
                    onPressed: () {
                      _signin(context);
                    },
                    child: Text(
                      "Signin to your shop",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    )),
              ),
              SizedBox(height: 15),
              Container(
                height: 40,
                width: 170,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[700]),
                child: FlatButton(
                    onPressed: () {
                      //Navigator.pushReplacement(
                      //  context,
                      //MaterialPageRoute(
                      //  builder: (context) => Guesthomescreen()));
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Homescreen()));
                    },
                    child: Text(
                      "Enter as a Guest",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    )),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Don't have an account?  "),
                  GestureDetector(
                      child: Text(
                        "SignUp",
                        style: TextStyle(color: Colors.blue[600]),
                      ),
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Singupscreen()));
                      }),
                ],
              ),
            ],
          )
        ])));
  }

  void _signin(BuildContext context) async {
    try {
      // ignore: unused_local_variable
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _email.text,
        password: _password.text,
      );

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Homescreen()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        error = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        error = 'Wrong password provided for that user.';
      }
    }
  }
}
