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
  
}