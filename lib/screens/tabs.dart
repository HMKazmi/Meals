import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/main_drawer.dart';

Map <Filter, bool> kInitialFilters=
{Filter.glutenFree:false,
  Filter.lactoseFree:false,
  Filter.vegetarian:false,
  Filter.vegan:false,
};



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
  Map<Filter,bool> _selectedFilters=kInitialFilters;

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

  void _setActiveScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == "filters") {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: ((context) => FiltersScreen(appliedFilters: _selectedFilters,)),
        ),
      );
    setState(() {
      _selectedFilters = result ?? kInitialFilters;
    });
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
    final availableMeals=dummyMeals.where((meal){
      if ( _selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (_selectedFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();
    Widget activePage = CategoriesScreen(
      onToggleFav: _toggleFav,
      availableMeals: availableMeals,
    );
    if (_currentIndex == 1) {
      activePage = MealsScreen(
        onToggleFav: _toggleFav,
        meals: favMeals,
      );
    } else {
      activePage = CategoriesScreen(
        onToggleFav: _toggleFav,
        availableMeals: availableMeals,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(_currentPageTitle),
      ),
      drawer: MainDrawer(
        onSetScreen: _setActiveScreen,
      ),
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
