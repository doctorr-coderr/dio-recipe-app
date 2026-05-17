import '../models/recipe.dart';

abstract class RecipeEvent {}

class FetchRecipe extends RecipeEvent{}

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