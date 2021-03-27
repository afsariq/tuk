import 'package:AutoSale/Home/Home.dart';
import 'package:AutoSale/Yoursale/Yoursale.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

class Addtuk extends StatefulWidget {
  @override
  _AddtukState createState() => _AddtukState();
}

class _AddtukState extends State<Addtuk> {
  File sampleImage;
  DateTime dateToday =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  final picker = ImagePicker();
  final TextEditingController year = TextEditingController(),
      model = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController price = TextEditingController();

  Future getImage() async {
    // ignore: deprecated_member_use
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      sampleImage = tempImage;
    });
  }

  Future getCamImage() async {
    // ignore: deprecated_member_use
    var tempImage = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      sampleImage = tempImage;
    });
  }

  final _key = GlobalKey<FormState>();
  String id = FirebaseAuth.instance.currentUser.uid;
  static final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.amber,
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
      body: Form(
        key: _key,
        child: ListView(
          children: [
            SizedBox(
              height: 18,
            ),
            Column(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please enter your vehicle model";
                        } else {
                          return null;
                        }
                      },
                      controller: model,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: 'Model'),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Location cannot be empty";
                        } else {
                          return null;
                        }
                      },
                      controller: location,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: 'Location'),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: TextFormField(
                      validator: (value) {
                        if (value.length < 10) {
                          return "please enter a correct phone number";
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.number,
                      controller: phone,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: 'Contact No'),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return "please provide details";
                        } else {
                          return null;
                        }
                      },
                      controller: price,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: 'Price'),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Enter details";
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
                      maxLength: 5,
                      maxLengthEnforced: false,
                      controller: year,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: 'Details'),
                    ),
                  ),
                ),
              ),
              Row(children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: FlatButton(
                        onPressed: getCamImage,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.camera_alt),
                            Text("Take Image"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: FlatButton(
                        onPressed: getImage,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.photo,
                            ),
                            Text("Select Image"),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ]),
              sampleImage == null
                  ? Text(
                      "Please select an Document to Upload",
                      style: TextStyle(color: Colors.red),
                    )
                  : enableUpload(),
            ])
          ],
        ),
      ),
    );
  }

  Widget enableUpload() {
    return Container(
        child: Column(
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Image.file(
          sampleImage,
          width: 150,
          height: 150,
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: 200,
          decoration: BoxDecoration(
            color: Colors.green[900],
            borderRadius: BorderRadius.circular(10),
          ),
          child: FlatButton(
            onPressed: () {
              if (_key.currentState.validate()) {
                ///////////////////
                final String fileName =
                    new Random().nextInt(10000).toString() + '.$id';
                final Reference firebaseStorageRef =
                    FirebaseStorage.instance.ref().child("Sale/$id/$fileName");
                final UploadTask task = firebaseStorageRef.putFile(sampleImage);

                task.whenComplete(() async {
                  // ignore: non_constant_identifier_names
                  SnackBar(
                    content: Text("Added"),
                  );
                  String Url = await firebaseStorageRef.getDownloadURL();
                  print(Url);

                  const KEY_MODEL = "Model";
                  const KEY_LOCATION = "Location";
                  const KEY_PHONE = "Phone";
                  const KEY_PRICE = "Price";
                  const KEY_YEAR = "Year";
                  const KEY_IMAGE = "Image";
                  const KEY_DATE = "date";
                  await _fireStore
                      .collection('Users')
                      .doc(id)
                      .collection("Sale")
                      .doc()
                      .set({
                    KEY_MODEL: model.text,
                    KEY_LOCATION: location.text,
                    KEY_PHONE: phone.text,
                    KEY_PRICE: price.text,
                    KEY_YEAR: year.text,
                    KEY_IMAGE: Url,
                    KEY_DATE: Timestamp.now(),
                  });
                });
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Yoursalescreen()));
              } else {
                print("error");
              }
            },
            child: Row(
              children: [
                Icon(Icons.upload_rounded),
                SizedBox(
                  width: 10,
                ),
                Text("Add Tuk for Sale"),
              ],
            ),
          ),
        )
      ],
    ));
  }
}
