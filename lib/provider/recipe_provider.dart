import 'package:flutter/material.dart';
import 'package:recipe_application/models/recipe.dart';
import 'package:recipe_application/repositories/recipe_repository.dart';

class RecipeProvider extends ChangeNotifier{
  final RecipeRepository repository;

  RecipeProvider(this.repository);
  List<Recipe> _allRecipes=[];
  List<Recipe> _filteredRecipes=[];
  List<Recipe> get recipes=> _filteredRecipes;
  String selectedCategory="Breakfast";
  String searchQuery="";
  bool isLoading=false;

  Future<void> loadRecipes()async{
    isLoading=true;
    //notifyListeners();

    _allRecipes=await repository.getRecipe();
    isLoading=false;
    notifyListeners();
    
  }
  void filterByCategory(String category){
    selectedCategory = category;
    applyFilters();
  }
  void search(String value){
    searchQuery = value.toLowerCase();
    applyFilters();
  }
  void applyFilters(){
    _filteredRecipes= _allRecipes.where((recipe){
      final matchCategory= recipe.mealType
      .map((e)=> e.toLowerCase())
      .contains(selectedCategory.toLowerCase());
      final matchSearch= recipe.name.toLowerCase().contains(searchQuery);
      return matchCategory && matchSearch;
    
    }).toList();
    notifyListeners();
  }
  Future<Recipe> getRecipeDetail(int id)async{
    return repository.getRecipeDetails(id);
  }
  Future<bool> updatedRecipe(Recipe recipe)async{
    final updated= await repository.updateRecipe(recipe);
    if(updated != null){
      int index= _allRecipes.indexWhere((r)=> r.id == recipe.id);
      if(index != -1){
        _allRecipes[index] = updated;
        applyFilters();
      }
      return true;
    }
    return false;
  }
}