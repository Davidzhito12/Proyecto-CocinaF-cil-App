import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../data/recipes_data.dart';

class FavoritesService extends ChangeNotifier {
  static final FavoritesService _instance = FavoritesService._internal();

  factory FavoritesService() {
    return _instance;
  }

  FavoritesService._internal();

  final Set<String> _favoriteIds = {};

  Set<String> get favoriteIds => _favoriteIds;

  bool isFavorite(String recipeId) {
    return _favoriteIds.contains(recipeId);
  }

  void toggleFavorite(String recipeId) {
    final recipe = allRecipes.firstWhere((r) => r.id == recipeId);
    
    if (_favoriteIds.contains(recipeId)) {
      _favoriteIds.remove(recipeId);
      recipe.isFavorite = false;
    } else {
      _favoriteIds.add(recipeId);
      recipe.isFavorite = true;
    }
    notifyListeners();
  }

  List<Recipe> getFavoriteRecipes() {
    return allRecipes.where((recipe) => _favoriteIds.contains(recipe.id)).toList();
  }

  void addFavorite(String recipeId) {
    if (!_favoriteIds.contains(recipeId)) {
      _favoriteIds.add(recipeId);
      final recipe = allRecipes.firstWhere((r) => r.id == recipeId);
      recipe.isFavorite = true;
      notifyListeners();
    }
  }

  void removeFavorite(String recipeId) {
    if (_favoriteIds.contains(recipeId)) {
      _favoriteIds.remove(recipeId);
      final recipe = allRecipes.firstWhere((r) => r.id == recipeId);
      recipe.isFavorite = false;
      notifyListeners();
    }
  }
}
