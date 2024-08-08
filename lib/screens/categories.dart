import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/category.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key,required this.availableMeals, required this.onToggleFav});
  final bool Function(Meal meal) onToggleFav;
  final List<Meal> availableMeals;


  void _selectCategory(BuildContext context, Category category) {
    final mealList = availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    print(mealList);
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => MealsScreen(
              meals: mealList,
              onToggleFav: onToggleFav,
              title: category.title,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(15),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: [
        for (final category in availableCategories)
          CategoryGridItem(
              onSelectCategory: () {
                _selectCategory(context, category);
              },
              category: category),
      ],
    );
  }
}
