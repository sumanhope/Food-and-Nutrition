import 'package:flutter/material.dart';
import 'package:foodandnutrition/allpages/details.dart';
import 'package:foodandnutrition/allpages/nutritional.dart';
import 'package:foodandnutrition/services/foodlist.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final searchcontroller = TextEditingController();
  Widget buildUser() {
    return TextField(
      controller: searchcontroller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).cardColor,
        //floatingLabelStyle: TextStyle(color: Colors.white),

        //fillColor: const Color.fromARGB(117, 100, 255, 219),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide:
              BorderSide(color: Color.fromRGBO(77, 182, 172, 1), width: 3),
        ),
        labelText: 'Search',
        labelStyle: const TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.bold,
          fontFamily: 'Poppins',
        ),
        prefixIcon: const Icon(
          Icons.search,
          color: Colors.white,
          size: 30,
        ),
        suffixIcon: searchcontroller.text.isEmpty
            ? Container(width: 0)
            : IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => searchcontroller.clear(),
                color: Colors.white,
              ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: Colors.teal, width: 3),
        ),
      ),
      onChanged: (value) => _runFilter(value),
      style: TextStyle(
        color: Theme.of(context).unselectedWidgetColor,
        fontSize: 15,
        fontFamily: 'Poppins',
      ),
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
    );
  }

  var foodList = FoodList(name: '', foodCategory: '', id: 0);

  // This list holds the data for the list view
  List<FoodList> _foodList = [];
  @override
  void initState() {
    _foodList = foodList.foodList();
    super.initState();
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<FoodList> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = foodList.foodList();
    } else {
      results = foodList
          .foodList()
          .where((food) =>
              food.name.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }
    setState(() {
      _foodList = results;
    });
  }

  @override
  Widget build(BuildContext context) => KeyboardDismisser(
        gestures: const [
          GestureType.onTap,
          GestureType.onPanUpdateDownDirection,
        ],
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text(
              "Search",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            centerTitle: true,
          ),
          body: SafeArea(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: buildUser(),
                ),
                Expanded(
                  child: _foodList.isNotEmpty
                      ? ListView.builder(
                          itemCount: _foodList.length,
                          itemBuilder: (context, index) => Card(
                            key: ValueKey(_foodList[index].id),
                            //color: const Color.fromARGB(153, 0, 150, 135),
                            elevation: 9,
                            shadowColor: Colors.teal[800],
                            child: ListTile(
                              // leading: Text(
                              //   _foodList[index].id.toString(),
                              //   style: const TextStyle(
                              //       fontSize: 24, color: Colors.white),
                              // ),
                              title: Text(_foodList[index].name,
                                  style: const TextStyle(color: Colors.white)),
                              subtitle: Text(_foodList[index].foodCategory,
                                  style: const TextStyle(color: Colors.white)),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DetailScreen(_foodList[index].id)),
                                );
                              },
                            ),
                          ),
                        )
                      : const Text(
                          'No results found',
                          style: TextStyle(fontSize: 24),
                        ),
                ),
              ],
            ),
          ),
        ),
      );
}
