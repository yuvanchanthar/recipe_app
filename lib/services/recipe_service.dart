import 'package:dio/dio.dart';
import 'package:recipe_application/models/recipe.dart';

class RecipeService {
  final Dio dio;

  RecipeService(this.dio);
  Future<List<Recipe>> fetchRecipe()async{
    final response= await dio.get("/recipes");
    final List data=response.data['recipes'];
    return data.map((e)=> Recipe.fromJson(e)).toList();

  }
  Future<Recipe> fetchRecipeDetails(int id)async{
    final response= await dio.get("/recipes/$id");
    return Recipe.fromJson(response.data);

  }
  Future<Recipe?> updateRecipe(Recipe recipe)async{
    final response=await dio.put("/recipes/${recipe.id}",
    data: {
      "name":recipe.name,
      "servings":recipe.servings,
      "instructions":recipe.instructions,
    });
    return Recipe.fromJson(response.data);
    

  }
}