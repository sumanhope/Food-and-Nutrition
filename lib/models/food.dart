class Food {
  final int foodID;
  final String foodCategory;
  final String foodname;
  final String measure;
  final double servingSize;
  final double calories;
  final double fats;
  final double carbs;
  final double fiber;
  final double protein;
  final double sugar;
  final double iron;
  final double calcium;
  final double potassium;
  final double vitaminA;
  final double vitaminC;
  final double vitaminD;
  final String diet;

  Food({
    required this.foodID,
    required this.foodname,
    required this.foodCategory,
    required this.servingSize,
    required this.measure,
    required this.calories,
    required this.fats,
    required this.carbs,
    required this.fiber,
    required this.protein,
    required this.sugar,
    required this.iron,
    required this.calcium,
    required this.potassium,
    required this.vitaminA,
    required this.vitaminC,
    required this.vitaminD,
    required this.diet,
  });

  factory Food.fromMap(Map<String, dynamic> map) {
    return Food(
      foodID: int.parse(map['foodId'].toString()),
      foodname: map['foodName'],
      foodCategory: map['foodCategory'],
      measure: map['measure'],
      servingSize: double.parse(map['servingSize'].toString()),
      calories: double.parse(map['calories'].toString()),
      fats: double.parse(map['fat'].toString()),
      carbs: double.parse(map['carb'].toString()),
      fiber: double.parse(map['fiber'].toString()),
      protein: double.parse(map['protein'].toString()),
      sugar: double.parse(map['sugar'].toString()),
      iron: double.parse(map['iron'].toString()),
      calcium: double.parse(map['calcium'].toString()),
      potassium: double.parse(map['potassium'].toString()),
      vitaminA: double.parse(map['vitaminA'].toString()),
      vitaminC: double.parse(map['vitaminC'].toString()),
      vitaminD: double.parse(map['vitaminD'].toString()),
      diet: map['diet'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'foodId': foodID,
      'foodname': foodname,
      'foodCategory': foodCategory,
      'servingSize': servingSize,
      'measure': measure,
      'calories': calories,
      'fat': fats,
      'carb': carbs,
      'fiber': fiber,
      'protein': protein,
      'sugar': sugar,
      'iron': iron,
      'calcium': calcium,
      'potassium': potassium,
      'vitaminA': vitaminA,
      'vitaminC': vitaminC,
      'vitaminD': vitaminD,
      'diet': diet,
    };
  }
}
