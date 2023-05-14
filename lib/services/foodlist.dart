class FoodList {
  final int id;
  final String name;
  final String foodCategory;

  FoodList({
    required this.id,
    required this.name,
    required this.foodCategory,
  });

  List<FoodList> foodList() {
    return [
      FoodList(
        id: 1,
        name: 'Rice',
        foodCategory: 'Grains',
      ),
      FoodList(
        id: 2,
        name: 'Noodles',
        foodCategory: 'Pasta & Grains',
      ),
      FoodList(
        id: 3,
        name: 'Potato',
        foodCategory: 'Vegetables',
      ),
      FoodList(
        id: 4,
        name: 'Banana',
        foodCategory: 'Fruit',
      ),
      FoodList(
        id: 5,
        name: 'Lentils, Cooked',
        foodCategory: 'Grains',
      ),
      FoodList(
        id: 6,
        name: 'Apples',
        foodCategory: 'Fruit',
      ),
      FoodList(
        id: 7,
        name: 'Carrot',
        foodCategory: 'Vegetables',
      ),
      FoodList(
        id: 7,
        name: 'Cucumber',
        foodCategory: 'Vegetables',
      ),
      FoodList(
        id: 9,
        name: 'Cooked Soybeans',
        foodCategory: 'Seeds',
      ),
      FoodList(
        id: 10,
        name: 'Bread',
        foodCategory: 'Baked',
      ),
      FoodList(
        id: 11,
        name: 'Chicken Burger',
        foodCategory: 'Fast Food',
      ),
      FoodList(
        id: 12,
        name: 'Spaghetti',
        foodCategory: 'Pasta',
      ),
      FoodList(
        id: 13,
        name: 'Milk Tea',
        foodCategory: 'Drinks',
      ),
      FoodList(
        id: 14,
        name: 'Fried Rice',
        foodCategory: 'Fried',
      ),
      FoodList(
        id: 15,
        name: 'Steamed Dumpling',
        foodCategory: 'Steamed',
      ),
      FoodList(
        id: 16,
        name: 'Coffee',
        foodCategory: 'Drinks',
      ),
      FoodList(
        id: 17,
        name: 'Water',
        foodCategory: 'Drinks',
      ),
      FoodList(
        id: 18,
        name: 'Milk',
        foodCategory: 'Drinks',
      ),
    ];
  }
}
