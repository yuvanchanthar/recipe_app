import 'package:recipe_application/models/recipe.dart';
import 'package:recipe_application/repositories/recipe_repository.dart';
import 'package:recipe_application/services/recipe_service.dart';

class RecipeRepositoryImpl implements RecipeRepository{
  final RecipeService service;
  RecipeRepositoryImpl(this.service);

  @override
  Future<List<Recipe>> getRecipe() {
    return service.fetchRecipe();
    
  }
  @override
  Future<Recipe> getRecipeDetails(int id) {
    return service.fetchRecipeDetails(id);
  }
  @override
  Future<Recipe?> updateRecipe(Recipe recipe) {
    return service.updateRecipe(recipe);

  }

}