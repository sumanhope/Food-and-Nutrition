// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:foodandnutrition/ProfileOptions/editdetails.dart';
import 'package:image_picker/image_picker.dart';

class ViewDetails extends StatefulWidget {
  const ViewDetails({
    super.key,
    required this.userid,
    required this.username,
    required this.fullname,
    required this.age,
    required this.height,
    required this.weight,
    required this.email,
    required this.gender,
    required this.dob,
    required this.register,
  });
  final String userid;
  final String username;
  final String fullname;
  final int age;
  final int height;
  final int weight;
  final String email;
  final String gender;
  final String dob;
  final String register;

  @override
  State<ViewDetails> createState() => _ViewDetailsState();
}

class _ViewDetailsState extends State<ViewDetails> {
  String profileurl = '';
  String name = '';
  String imageUrl = '';

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    final DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userid)
        .get();
    setState(() {
      profileurl = userDoc.get('profile');
      name = userDoc.get('username');
    });
  }

  void chooseProfile() async {
    // choosing image
    ImagePicker imagepicker = ImagePicker();
    XFile? file = await imagepicker.pickImage(source: ImageSource.gallery);
    debugPrint(file?.path);
    if (file == null) return;
    String uniqueFilename = "${name}_Profile";
    // uploading image to Storage
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirIamges = referenceRoot.child('Profiles');
    Reference referenceImagetoUpload = referenceDirIamges.child(uniqueFilename);
    try {
      await referenceImagetoUpload.putFile(File(file.path));

      imageUrl = await referenceImagetoUpload.getDownloadURL();
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
    addProfile(imageUrl);
    setState(() {});
  }

  Future addProfile(String link) async {
    final usercollection = FirebaseFirestore.instance.collection('users');
    final docRef = usercollection.doc(widget.userid);

    try {
      docRef.update({"profile": link});
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: const Text(
            "User Details",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
          ),
          leading: GestureDetector(
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 20,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            InkWell(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditDetails(
                      userid: widget.userid,
                      fullname: widget.fullname,
                      username: widget.username,
                      email: widget.email,
                      dob: widget.dob,
                      age: widget.age,
                      gender: widget.gender,
                      height: widget.height,
                      weight: widget.weight,
                    ),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.only(right: 10),
                child: Row(children: const [
                  Icon(
                    Icons.edit,
                    size: 20,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Edit",
                    style: TextStyle(
                      letterSpacing: 1.5,
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ]),
              ),
            )
          ],
        ),
        body: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 150,
                  decoration: const BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(40),
                      bottomLeft: Radius.circular(40),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: chooseProfile,
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            image: profileurl != ""
                                ? DecorationImage(
                                    image: NetworkImage(profileurl),
                                    fit: BoxFit.fill,
                                    scale: 2,
                                  )
                                : const DecorationImage(
                                    image: AssetImage("images/box.png"),
                                    fit: BoxFit.cover,
                                  ),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      // CircleAvatar(
                      //   maxRadius: 50,
                      //   minRadius: 50,
                      //   backgroundColor: Colors.grey,
                      //   backgroundImage: AssetImage('images/kayo.jpg'),
                      // ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.fullname,
                            style: TextStyle(
                              letterSpacing: 1.5,
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          Text(
                            "${widget.gender}, ${widget.age}",
                            style: TextStyle(
                              letterSpacing: 1.5,
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ProfileDetailColumn(
                  title: "Username",
                  value: widget.username,
                ),
                ProfileDetailColumn(
                  title: "Email",
                  value: widget.email,
                ),
                ProfileDetailColumn(
                  title: "Date of Birth",
                  value: widget.dob,
                ),
                ProfileDetailColumn(
                  title: "Height",
                  value: "${widget.height} cm",
                ),
                ProfileDetailColumn(
                  title: "Weight",
                  value: "${widget.weight} kg",
                ),
                ProfileDetailColumn(
                  title: "Register Date",
                  value: widget.register,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileDetailColumn extends StatelessWidget {
  const ProfileDetailColumn(
      {Key? key, required this.title, required this.value})
      : super(key: key);
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  letterSpacing: 1.5,
                  fontSize: 16,
                  color: Colors.teal,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
              SizedBox(
                height: 2,
              ),
              Text(
                value,
                style: TextStyle(
                  letterSpacing: 1.5,
                  fontSize: 16,
                  color: Colors.teal[300],
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
              SizedBox(
                width: 370,
                child: Divider(
                  thickness: 2,
                  color: Colors.teal[100],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
