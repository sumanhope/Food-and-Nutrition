import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import "package:flutter/material.dart";
import 'package:foodandnutrition/ProfileOptions/before_after.dart';
import 'package:foodandnutrition/ProfileOptions/alldetails.dart';
//import 'package:foodandnutrition/Signup/addfood.dart';
import 'package:foodandnutrition/UserandSettings/accandpass.dart';
import 'package:foodandnutrition/UserandSettings/appsetting.dart';
import 'package:foodandnutrition/Welcome/welcome_page.dart';
import 'package:foodandnutrition/UserandSettings/favourite_page.dart';
import 'package:foodandnutrition/services/darkthemeperf.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final User user = FirebaseAuth.instance.currentUser!;
  String _uid = " ";
  String name = "Loading";
  int age = 0;
  String username = "Loading";
  int height = 0;
  int weight = 0;
  String email = "Loading";
  String gender = "Loading";
  double calories = 0;
  String register = "";
  String profileurl = '';
  String imageUrl = '';
  File? _image;
  UsernamePerfs testuser = UsernamePerfs();
  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    _uid = user.uid;

    final DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(_uid).get();
    setState(() {
      name = userDoc.get('fullname');
      age = userDoc.get('age');
      username = userDoc.get('username');
      height = userDoc.get('height');
      weight = userDoc.get('weight');
      email = userDoc.get('email');
      gender = userDoc.get('gender');
      calories = double.parse(userDoc.get('basecalories').toString());
      register = userDoc.get('register');
      profileurl = userDoc.get('profile');
    });
  }

  void chooseProfile() async {
    // choosing image

    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    debugPrint(image?.path);
    if (image == null) return;
    File? img = File(image.path);
    img = await cropimage(img);
    setState(() {
      _image = img;
    });
    String uniqueFilename = "${name}_Profile";
    // uploading image to Storage
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirIamges = referenceRoot.child('Profiles');
    Reference referenceImagetoUpload = referenceDirIamges.child(uniqueFilename);
    try {
      await referenceImagetoUpload.putFile(_image!);

      imageUrl = await referenceImagetoUpload.getDownloadURL();
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
    addProfile(imageUrl);
    setState(() {});
  }

  Future<File?> cropimage(File imagefile) async {
    CroppedFile? croppedImage = await ImageCropper()
        .cropImage(sourcePath: imagefile.path, cropStyle: CropStyle.circle);
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }

  Future addProfile(String link) async {
    final usercollection = FirebaseFirestore.instance.collection('users');
    final docRef = usercollection.doc(_uid);

    try {
      docRef.update({"profile": link});
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            "Profile",
            style: TextStyle(
              letterSpacing: 1.5,
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: chooseProfile,
                    child: SizedBox(
                      height: 115,
                      width: 150,
                      child: Container(
                        width: 150,
                        height: 100,
                        decoration: BoxDecoration(
                          image: profileurl != ""
                              ? DecorationImage(
                                  image: NetworkImage(profileurl),
                                  fit: BoxFit.scaleDown,
                                  scale: 2.5,
                                )
                              : const DecorationImage(
                                  image: AssetImage("images/box.png"),
                                  fit: BoxFit.cover,
                                ),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                  Stack(
                    children: [
                      Text(
                        // user.email.toString(),
                        username,
                        style: const TextStyle(
                          fontSize: 18,
                          //color: Colors.teal,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 30.0, right: 10.0),
                        child: Text(
                          '$age',
                          style: const TextStyle(
                            fontSize: 15,
                            //color: Colors.teal,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    margin: const EdgeInsets.only(bottom: 20.0, right: 12.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                      ),
                      onPressed: () {
                        testuser.setUsername("Loading");
                        FirebaseAuth.instance.signOut().then((value) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const WelcomeScreen(),
                            ),
                          );
                        });
                      },
                      child: const Text(
                        "Logout",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              const Divider(
                height: 5,
                thickness: 2,
                color: Colors.teal,
              ),
              ProfileMenu(
                firsticon: Icons.person,
                text: name,
                secondicon: Icons.chevron_right_sharp,
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewDetails(
                        userid: _uid,
                        username: username,
                        fullname: name,
                        age: age,
                        height: height,
                        weight: weight,
                        email: email,
                        gender: gender,
                        register: register,
                        calories: calories,
                        profileurl: profileurl,
                      ),
                    ),
                  );
                },
              ),
              ProfileMenu(
                firsticon: Icons.favorite,
                text: "Favorites",
                secondicon: Icons.chevron_right_sharp,
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FavouritePage(),
                    ),
                  );
                },
              ),
              ProfileMenu(
                firsticon: Icons.camera_alt,
                text: "Before and After",
                secondicon: Icons.chevron_right_sharp,
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BeforeandAfterScreen(userid: _uid),
                    ),
                  );
                },
              ),
              ProfileMenu(
                firsticon: Icons.settings,
                text: "App settings",
                secondicon: Icons.chevron_right_sharp,
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Appsetting(),
                    ),
                  );
                },
              ),
              ProfileMenu(
                firsticon: Icons.security,
                text: "Accounts and Password",
                secondicon: Icons.chevron_right_sharp,
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AccountandPassword()),
                  );
                },
              ),
              // ProfileMenu(
              //   firsticon: Icons.fastfood,
              //   text: "Add food",
              //   secondicon: Icons.chevron_right_sharp,
              //   press: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => const Addfood()),
              //     );
              //   },
              // ),
              ProfileMenu(
                firsticon: Icons.share,
                text: "Share with your friends",
                secondicon: Icons.chevron_right_sharp,
                press: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileMenu extends StatelessWidget {
  final String text;
  final IconData firsticon, secondicon;
  final VoidCallback press;
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.firsticon,
    required this.secondicon,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          backgroundColor: Theme.of(context).cardColor,
        ),
        onPressed: press,
        child: Row(
          children: [
            Icon(
              firsticon,
              size: 25,
              color: Theme.of(context).indicatorColor,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              text,
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).indicatorColor,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            const Spacer(),
            Icon(
              secondicon,
              size: 30,
              color: Theme.of(context).indicatorColor,
            ),
          ],
        ),
      ),
    );
  }
}
