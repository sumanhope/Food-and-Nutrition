import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class BeforeandAfterScreen extends StatefulWidget {
  const BeforeandAfterScreen({super.key, required this.userid});
  final String userid;

  @override
  State<BeforeandAfterScreen> createState() => _BeforeandAfterScreenState();
}

class _BeforeandAfterScreenState extends State<BeforeandAfterScreen> {
  String imageUrl = '';
  String beforeurl = '';
  String afterurl = '';
  String username = '';
  File? beforeimage;
  File? afterimage;
  @override
  void initState() {
    super.initState();
    debugPrint(widget.userid);
    getData();
  }

  void getData() async {
    final DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userid)
        .get();
    setState(() {
      username = userDoc.get('username');
      beforeurl = userDoc.get('before');
      afterurl = userDoc.get('after');
    });
  }

  void chooseBefore() async {
    // choosing image
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    debugPrint(image?.path);
    if (image == null) return;
    File? img = File(image.path);
    img = await cropimage(img);
    setState(() {
      beforeimage = img;
    });
    String uniqueFilename = "${username}_Before";
    // uploading image to Storage
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirIamges = referenceRoot.child('Before');
    Reference referenceImagetoUpload = referenceDirIamges.child(uniqueFilename);
    try {
      await referenceImagetoUpload.putFile(beforeimage!);

      imageUrl = await referenceImagetoUpload.getDownloadURL();
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
    addBefore(imageUrl);
    setState(() {});
  }

  Future addBefore(String link) async {
    final usercollection = FirebaseFirestore.instance.collection('users');
    final docRef = usercollection.doc(widget.userid);

    try {
      docRef.update({"before": link});
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
    getData();
  }

  void chooseAfter() async {
    // choosing image
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    debugPrint(image?.path);
    if (image == null) return;
    File? img = File(image.path);
    img = await cropimage(img);
    setState(() {
      afterimage = img;
    });
    String uniqueFilename = "${username}_After";
    // uploading image to Storage
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirIamges = referenceRoot.child('After');
    Reference referenceImagetoUpload = referenceDirIamges.child(uniqueFilename);
    try {
      await referenceImagetoUpload.putFile(afterimage!);

      imageUrl = await referenceImagetoUpload.getDownloadURL();
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
    addAfter(imageUrl);
    setState(() {});
  }

  Future<File?> cropimage(File imagefile) async {
    CroppedFile? croppedImage =
        await ImageCropper().cropImage(sourcePath: imagefile.path);
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }

  Future addAfter(String link) async {
    final usercollection = FirebaseFirestore.instance.collection('users');
    final docRef = usercollection.doc(widget.userid);

    try {
      docRef.update({"after": link});
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[200],
      appBar: AppBar(
        title: const Text(
          "Before and After",
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Text(
              "Capture your Progress",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Text(
                "Before",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
              SizedBox(
                width: 18,
              ),
              Text(
                "After",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: chooseBefore,
                  child: Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      image: beforeurl != ""
                          ? DecorationImage(
                              image: NetworkImage(beforeurl),
                              fit: BoxFit.cover,
                            )
                          : const DecorationImage(
                              image: AssetImage("images/box.png"),
                              fit: BoxFit.cover,
                            ),
                      //color: const Color.fromARGB(94, 68, 137, 255),
                      border: Border.all(
                        width: 4,
                        color: Colors.teal,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: chooseAfter,
                  child: Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      image: afterurl != ""
                          ? DecorationImage(
                              image: NetworkImage(afterurl),
                              fit: BoxFit.cover,
                            )
                          : const DecorationImage(
                              image: AssetImage("images/box.png"),
                              fit: BoxFit.cover,
                            ),
                      color: const Color.fromARGB(94, 68, 137, 255),
                      border: Border.all(
                        width: 4,
                        color: Colors.teal,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
