import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';

class FavoriteProviderNotifier extends StateNotifier<List<Meal>>{
  FavoriteProviderNotifier() : super([]);

  bool toggleFav(Meal meal){
  final mealIsFavorite = state.contains(meal);
    if (mealIsFavorite) {
      state = state.where((mealArg) => mealArg != meal).toList();
      return false;
    }
    else{
      state=[...state, meal];
      return true;
    }
  }


}


final favoriteProvider = StateNotifierProvider<FavoriteProviderNotifier, List<Meal>>((ref) => FavoriteProviderNotifier()
);

