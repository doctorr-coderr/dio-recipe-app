import 'package:dio/dio.dart';
import '../models/recipe.dart';

class ApiService {

  final Dio dio = Dio();
  final String baseUrl = 'https://dummyjson.com/recipes';

  // GET RECIPES
  Future<List<Recipe>> fetchRecipes() async {
    final response = await dio.get(baseUrl);

    List recipesJson = response.data['recipes'];
    return recipesJson.map((json) => Recipe.fromJson(json)).toList();
  }

  //ADD RECIPE
  Future<void> addRecipe(Recipe recipe) async{
    await dio.post(
      '$baseUrl/add', data: recipe.toJson()
      );
  }

  // UPDATE RECIPE
  Future<void> updateRecipe(
      int id,
      Recipe recipe,
      ) async {

    await dio.put(
      '$baseUrl/$id',
      data: recipe.toJson(),
    );
  }

  Future<void> deleteRecipe (int id) async {

    await dio.delete('$baseUrl/$id');
  }

  Future<void> patchRecipe (int id, Map<String, dynamic> data) async {

    await dio.patch(
      '$baseUrl/$id',
      data: data,
    );
  }

}