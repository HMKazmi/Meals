import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/favorites_provider.dart';
import 'package:meals/providers/filters_provider.dart';
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



class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreen();
  }
}

class _TabsScreen extends ConsumerState<TabsScreen> {
  int _currentIndex = 0;
  String _currentPageTitle = "Categories";





  void _setActiveScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == "filters") {
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: ((context) => const FiltersScreen()),
        ),
      );
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
    final availableMeals=ref.watch(filteredMealsProvider);

    Widget activePage = CategoriesScreen(
      availableMeals: availableMeals,
    );
    if (_currentIndex == 1) {
      final favMeals = ref.watch(favoriteProvider);
      activePage = MealsScreen(
        meals: favMeals,
      );
    } else {
      activePage = CategoriesScreen(
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
