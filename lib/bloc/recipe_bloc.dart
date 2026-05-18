import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/recipe.dart';
import '../services/api_service.dart';

import 'recipe_event.dart';
import 'recipe_state.dart';

class RecipeBloc
    extends Bloc<RecipeEvent, RecipeState> {

  final ApiService apiService;

  List<Recipe> recipes = [];

  RecipeBloc(this.apiService)
      : super(RecipeLoading()) {

    // FETCH
    on<FetchRecipes>((event, emit) async {

      emit(RecipeLoading());

      try {

        recipes =
        await apiService.fetchRecipes();

        emit(RecipeLoaded(recipes));

      } catch (e) {

        emit(
          RecipeError(
            'Failed to fetch recipes',
          ),
        );
      }
    });

    // ADD
    on<AddRecipe>((event, emit) async {

      try {

        await apiService.addRecipe(
          event.recipe,
        );

        recipes.insert(0, event.recipe);

        emit(RecipeLoaded(recipes));

      } catch (e) {

        emit(
          RecipeError(
            'Failed to add recipe',
          ),
        );
      }
    });

    // UPDATE
    on<UpdateRecipe>((event, emit) async {

      try {

        await apiService.updateRecipe(
          event.recipe.id,
          event.recipe,
        );

        recipes[event.index] =
            event.recipe;

        emit(RecipeLoaded(recipes));

      } catch (e) {

        emit(
          RecipeError(
            'Failed to update recipe',
          ),
        );
      }
    });

    // DELETE
    on<DeleteRecipe>((event, emit) async {

      try {

        await apiService.deleteRecipe(
          event.id,
        );

        recipes.removeWhere(
              (recipe) =>
          recipe.id == event.id,
        );

        emit(RecipeLoaded(recipes));

      } catch (e) {

        emit(
          RecipeError(
            'Failed to delete recipe',
          ),
        );
      }
    });

    on<PatchRecipe>((event, emit) async {

      try {

        await apiService.patchRecipe(
          event.id,
          event.data,
        );

       final oldRecipe = recipes[event.index];

       final updateRecipe = Recipe(
         id: oldRecipe.id,
         
         name: event.data['name'] ?? oldRecipe.name,
         cuisine: event.data['cuisine'] ?? oldRecipe.cuisine,
         image: event.data['imageUrl'] ?? oldRecipe.image,
         difficulty: event.data['difficulty'] ?? oldRecipe.difficulty,
       );

      } catch (e) {

        emit(
          RecipeError(
            'Failed to patch recipe',
          ),
        );
      }
    });
  }
}