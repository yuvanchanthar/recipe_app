import 'package:flutter/material.dart';
import 'package:recipe_application/models/recipe.dart';

class WishlistProvider extends ChangeNotifier{
  final List<Recipe> _wishlist=[];
   List<Recipe> get wishlist=>_wishlist;

   bool isAdded(int recipeId){
    return _wishlist.any((r)=> r.id ==recipeId);
   }
   void toggleWishlist(Recipe recipe){
    if(isAdded(recipe.id)){
      _wishlist.removeWhere((r)=> r.id == recipe.id);
    }else{
      _wishlist.add(recipe);
    }
    notifyListeners();
   }
   bool isWishListed(int id){
    return _wishlist.any((item)=> item.id == id);
   }
}