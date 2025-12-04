

import 'package:dio/dio.dart';
import 'package:recipe_application/models/recipe.dart';
class RecipeService {

  final Dio _dio=Dio();
    final String baseurl="https://dummyjson.com/recipes";

    Future<List<Recipe>> fetchRecipe()async{
     try{
      final response=await _dio.get(baseurl);
      
        List data= response.data["recipes"];
        
        return data.map((item)=>Recipe.fromJson(item)).toList();
   
      
     }catch(e){
      throw Exception("error:$e");
     }
    }
    Future<Recipe> fetchRecipeDetail(int id)async{
      try{
        final response= await _dio.get("$baseurl/$id");
        return Recipe.fromJson(response.data);
      }catch(e){
        throw Exception("Failed to load recipe:$e");
      }
    }
   Future<Recipe?> updateRecipe(Recipe recipe) async {
    try {
      final response = await _dio.put(
        "$baseurl/${recipe.id}",
        data: {
          "name": recipe.name,
          "servings": recipe.servings,
          "instructions": recipe.instructions,
        },
      );

      return Recipe.fromJson(response.data);
    } catch (e) {
      print("Update error: $e");
      return null;
    }
  }
  //    Future<Recipe> updateRecipe(Recipe recipe) async {
  //   final response = await dio.put(
  //     "/recipes/${recipe.id}",
  //     data: recipe.toJson(),
  //   );

  //   return Recipe.fromJson(response.data);
  // }
   
  
  
}