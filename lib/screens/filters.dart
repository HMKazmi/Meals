import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/filters_provider.dart';



class FiltersScreen extends ConsumerStatefulWidget {
  const FiltersScreen({super.key});

  @override
  ConsumerState<FiltersScreen> createState() {
    return _FiltersScreenState();
  }
}

class _FiltersScreenState extends ConsumerState<FiltersScreen> {
  var _glutenFreeFilterSet = false;
  var _lactoseFreeFilterSet = false;
  var _vegetarianFilterSet = false;
  var _veganFilterSet = false;

  @override 
  void initState(){
    super.initState();
    setState(() {
      final appliedFilters=ref.read(filterProvider);
      _glutenFreeFilterSet=appliedFilters[Filter.glutenFree]!;
      _lactoseFreeFilterSet=appliedFilters[Filter.lactoseFree]!;
      _vegetarianFilterSet=appliedFilters[Filter.vegetarian]!;
      _veganFilterSet=appliedFilters[Filter.vegan]!;
    });
  }


  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      // drawer: MainDrawer(onSetScreen: (identifier) {
      //   Navigator.of(context).pop();
      //   if (identifier == "meals") {
      //     Navigator.of(context).push(
      //       MaterialPageRoute(
      //         builder: ((context) => const TabsScreen()),
      //       ),
      //     );
      //   }
      // }),
      body: PopScope(
        canPop: true,
        onPopInvoked: (bool didPop) {
          ref.read(filterProvider.notifier).setFilters(
            {Filter.glutenFree: _glutenFreeFilterSet,
            Filter.lactoseFree: _lactoseFreeFilterSet,
            Filter.vegetarian: _vegetarianFilterSet,
            Filter.vegan: _veganFilterSet}
            
          );

        },
        child: Column(
          children: [
            SwitchListTile(
              value: _glutenFreeFilterSet,
              onChanged: (isApplied) {
                setState(() {
                  _glutenFreeFilterSet = isApplied;
                });
              },
              title: Text(
                "Gluten-Free",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                "Include Only Gluten Free Meals",
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 21),
            ),
            SwitchListTile(
              value: _lactoseFreeFilterSet,
              onChanged: (isApplied) {
                setState(() {
                  _lactoseFreeFilterSet = isApplied;
                });
              },
              title: Text(
                "Lactose-Free",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                "Include Only Lactose Free Meals",
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 21),
            ),
            SwitchListTile(
              value: _vegetarianFilterSet,
              onChanged: (isApplied) {
                setState(() {
                  _vegetarianFilterSet = isApplied;
                });
              },
              title: Text(
                "Vegetarian",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                "Include Only Vegetarian Meals",
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 21),
            ),
            SwitchListTile(
              value: _veganFilterSet,
              onChanged: (isApplied) {
                setState(() {
                  _veganFilterSet = isApplied;
                });
              },
              title: Text(
                "Vegan",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                "Include Only Vegan Meals",
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 21),
            ),
          ],
        ),
      ),
    );
  }
}
