import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreen();
  }
}

class _TabsScreen extends State<TabsScreen> {
  int _currentIndex = 0;
  String _currentPageTitle = "Categories";
  List<Meal> favMeals = [];

  showInfo(message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  bool _toggleFav(Meal meal) {
    if (favMeals.contains(meal)) {
      setState(() {
        favMeals.remove(meal);
        showInfo("Removed from Favorites.");
      });
      return false;
    } else {
      setState(() {
        favMeals.add(meal);
        showInfo("Added to Favorites.");
      });
      return true;
    }
  }

  void _setActiveScreen(String identifier) {
    if (identifier == "filters") {

    } else {
      print("object");
      Navigator.of(context).pop();
    }
  }
  
  void _setActivePage(int index) {
    if (_currentIndex == 1) {
      setState(() {
        _currentIndex = index;
        _currentPageTitle = "Categories";
      });
    } else {
      setState(() {
        _currentIndex = index;
        _currentPageTitle = "Favorites";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = CategoriesScreen(
      onToggleFav: _toggleFav,
    );
    if (_currentIndex == 1) {
      activePage = MealsScreen(
        onToggleFav: _toggleFav,
        meals: favMeals,
      );
    } else {
      activePage = CategoriesScreen(
        onToggleFav: _toggleFav,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(_currentPageTitle),
      ),
      drawer: MainDrawer(onSetScreen: _setActiveScreen,),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: "Categories"),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favorites"),
        ],
        onTap: _setActivePage,
      ),
    );
  }
}
