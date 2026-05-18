import '../models/recipe.dart';

abstract class RecipeEvent {}

class FetchRecipes extends RecipeEvent{}

class AddRecipe extends RecipeEvent{
  final Recipe recipe;

  AddRecipe(this.recipe);
}

class UpdateRecipe extends RecipeEvent {
  final int index;
  final Recipe recipe;

  UpdateRecipe(this.index, this.recipe);
}

class DeleteRecipe extends RecipeEvent {
  final int id;

  DeleteRecipe(this.id);
}

class PatchRecipe extends RecipeEvent {
  final int id;
  final int index;
  final Map<String, dynamic> data;

  PatchRecipe(this.id, this.index, this.data);
}