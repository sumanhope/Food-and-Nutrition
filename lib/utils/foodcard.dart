import "package:flutter/material.dart";

class FoodCard extends StatelessWidget {
  const FoodCard({
    Key? key,
    required this.imagelink,
    required this.type,
    required this.about,
    required this.whichpatients,
    required this.press,
  }) : super(key: key);
  final String imagelink;
  final String type;
  final String about;
  final String whichpatients;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: InkWell(
          onTap: press,
          child: Container(
            width: 300,
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imagelink),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: -9,
                  //right: 16,
                  left: 1,
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
                  bottom: 15,
                  left: 1,
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
                  bottom: -3,
                  left: 1,
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
        ));
  }
}
