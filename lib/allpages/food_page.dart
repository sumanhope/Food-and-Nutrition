import 'package:flutter/material.dart';

class FoodPage extends StatefulWidget {
  const FoodPage({super.key});

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Foods"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: const [
              SizedBox(
                height: 10,
              ),
              FoodDisplay(
                imagelink: "images/Low-Fat.jpg",
                about: 'contains list of low fat foods',
                type: 'Low-Fat',
                whichpatients: 'For Everyone',
              ),
              FoodDisplay(
                imagelink: "images/high-fiber.jpg",
                about: 'contains list of high-fiber foods',
                type: 'High-Fiber',
                whichpatients: 'For Piles',
              ),
              FoodDisplay(
                imagelink: "images/High-Protein.jpg",
                about: 'contains list of high-protein foods',
                type: 'High-Protein',
                whichpatients: 'For test',
              ),
              FoodDisplay(
                imagelink: "images/vegetarian.jpg",
                about: 'contains list of vegetarian foods',
                type: 'Vegetarian',
                whichpatients: 'For Vegans',
              )
            ],
          ),
        ));
  }
}

class FoodDisplay extends StatelessWidget {
  const FoodDisplay({
    Key? key,
    required this.imagelink,
    required this.type,
    required this.about,
    required this.whichpatients,
  }) : super(key: key);
  final String imagelink;
  final String type;
  final String about;
  final String whichpatients;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Ink.image(
              image: AssetImage(imagelink),
              height: 240,
              fit: BoxFit.cover,
              child: InkWell(
                onTap: () {},
              ),
            ),
            Positioned(
              top: 10,
              right: 16,
              left: 16,
              child: Text(
                type,
                style: const TextStyle(
                  letterSpacing: 1.5,
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            Positioned(
              bottom: 30,
              right: 16,
              left: 16,
              child: Text(
                whichpatients,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              right: 16,
              left: 16,
              child: Text(
                about,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
