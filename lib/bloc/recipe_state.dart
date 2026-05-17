import '../models/recipe.dart';

abstract class RecipeState {}

class RecipeLoading extends RecipeState {}

class RecipeLoaded extends RecipeState {
  final List<Recipe> recipes;

  RecipeLoaded(this.recipes);
}

class RecipeError extends RecipeState {
  final String message;

  RecipeError(this.message);
}