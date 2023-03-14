import 'package:flutter/material.dart';
import 'package:foodandnutrition/ProfileOptions/editdetails.dart';

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
    required this.profileurl,
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
  final String profileurl;

  @override
  State<ViewDetails> createState() => _ViewDetailsState();
}

class _ViewDetailsState extends State<ViewDetails> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //backgroundColor: Colors.white,
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
          //color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(40),
                      bottomLeft: Radius.circular(40),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              image: widget.profileurl != ""
                                  ? DecorationImage(
                                      image: NetworkImage(widget.profileurl),
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
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.fullname,
                            style: const TextStyle(
                              letterSpacing: 1.5,
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          Text(
                            "${widget.gender}, ${widget.age}",
                            style: const TextStyle(
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
                const SizedBox(
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
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  letterSpacing: 1.5,
                  fontSize: 16,
                  //color: Colors.teal,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                value,
                style: const TextStyle(
                  letterSpacing: 1.5,
                  fontSize: 16,
                  //color: Colors.teal[300],
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
