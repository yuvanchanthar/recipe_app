import 'package:recipe_application/models/recipe.dart';

abstract class RecipeRepository {
  Future<List<Recipe>> getRecipe();
  Future<Recipe> getRecipeDetails(int id);
  Future<Recipe?> updateRecipe(Recipe recipe);
}