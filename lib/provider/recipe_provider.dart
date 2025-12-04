import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:recipe_application/models/recipe.dart';
import 'package:recipe_application/services/recipe_service.dart';

class RecipeProvider extends ChangeNotifier{
  final RecipeService _service=RecipeService();
  final Dio dio=Dio();
  List<Recipe> _allRecipe=[];
  List<Recipe> _filteredRecipes=[];

  List<Recipe> get recipes=> _filteredRecipes;
  String selectedCategory ="Breakfast";
  String searchQuery="";
  bool isLoading=false;
  Future<void> loadRecipes()async{
    _allRecipe=await _service.fetchRecipe();
    applyFilters();
    
  }
  void filterByCategory(String category){
    selectedCategory=category;
    applyFilters();
    
  }
  void search(String text){
    searchQuery=text.toLowerCase();
    applyFilters();

  }
  void applyFilters(){
    _filteredRecipes=_allRecipe.where((recipe){
      bool matchCategory=  recipe.mealType
      .map((e)=> e.toLowerCase())
      .contains(selectedCategory.toLowerCase());
      bool matchSearch=  recipe.name.toLowerCase()
      .contains(searchQuery);
      return matchCategory && matchSearch;

    }).toList();
    notifyListeners();

  }
  Future<bool> updateRecipe(Recipe recipe) async {
  isLoading = true;
  notifyListeners();

  try {
    final response = await dio.put(
      "https://dummyjson.com/recipes/${recipe.id}",
      data: {
        "name": recipe.name,
        "servings": recipe.servings,
        "instructions": recipe.instructions,
        "rating": recipe.rating,
      },
    );

    if (response.statusCode == 200) {
      int index = recipes.indexWhere((r) => r.id == recipe.id);
      if (index != -1) {
        recipes[index] = recipe;
      }

      isLoading = false;
      notifyListeners();
      return true;
    }

    isLoading = false;
    notifyListeners();
    return false;
  } catch (e) {
    isLoading = false;
    notifyListeners();
    return false;
  }
}

  // Future<void> updateRecipe(Recipe recipe)async{
  //   final success= await _service.updateRecipe(recipe);
  //   if(success != null){
  //     final index= _allRecipe.indexWhere((r)=> r.id==success.id);
  //     if(index != -1){
  //       _allRecipe[index]=success;
  //       notifyListeners();
  //     }
  //     applyFilters();
      
  //   }else {
  //     throw Exception("failed to load");
  //     }
      
    
  // }
// }
//   Future<void> updateRecipe(Recipe recipe) async {
//     final result = await _service.updateRecipe(recipe);

//     final index = _allRecipe.indexWhere((r) => r.id == recipe.id);

//     if (index != -1) {
//       _allRecipe[index] = result;
//       notifyListeners();
//     }
//   }
//   Future<void> updateRecipe (Recipe recipe)async{
//     Recipe newRecipe=await _service.updateRecipe(recipe.id, recipe);
//   }
//   // Future<bool> updateRecipe(
//     int id,String name, int servings,List<String> instructions)async{
//     final data={
//       "name":name,
//       "servings":servings,
//       "instructions":instructions,
//     };
//     bool success= await _service.updateRecipe(id, data);
//     if(success){
//       int index= _allRecipe.indexWhere((test)=> test.id==id);

//       if(index != -1){
//         _allRecipe[index].name=name;
//         _allRecipe[index].servings=servings;
//         _allRecipe[index].instructions=instructions;
//         notifyListeners();

//       }
//     }
//     return success;
  }
 
