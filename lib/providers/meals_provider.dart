import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/data/dummy_data.dart';

Provider meals = Provider((ref) => dummyMeals);
