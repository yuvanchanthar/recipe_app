import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:recipe_application/models/recipe.dart';
import 'package:recipe_application/models/wishlist_item.dart';

class WishlistProvider extends ChangeNotifier {
  static const String boxName = 'wishlistBox';

  late Box<WishlistItem> wishlistBox = Hive.box<WishlistItem>(boxName);

  /// MUST call this from main BEFORE using WishlistProvider
  Future<void> init() async {
    wishlistBox = await Hive.openBox<WishlistItem>(boxName);
    notifyListeners();
  }

  // ---------- GET WISHLIST ITEMS ----------
  List<WishlistItem> get wishlistItems {
    return wishlistBox.values.toList();
  }

  // ---------- CHECK ----------
  bool isFavourite(int recipeId) {
    return wishlistBox.values.any((item) => item.id == recipeId);
  }

  // ---------- ADD ----------
  void addToWishlist(Recipe recipe) {
    if (!isFavourite(recipe.id)) {
      final item = WishlistItem(
        id: recipe.id,
        name: recipe.name,
        image: recipe.image,
        cookTimeMinutes: recipe.cookTimeMinutes,
       
      );
      wishlistBox.put(recipe.id, item);
      notifyListeners();
    }
  }

  // ---------- REMOVE ----------
  void removeFromWishlist(int recipeId) {
    if (wishlistBox.containsKey(recipeId)) {
      wishlistBox.delete(recipeId);
      notifyListeners();
    }
  }

  // ---------- TOGGLE ----------
  void toggleWishlist(Recipe recipe) {
    if (isFavourite(recipe.id)) {
      removeFromWishlist(recipe.id);
    } else {
      addToWishlist(recipe);
    }
  }
}

// import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:recipe_application/models/recipe.dart';
// import 'package:recipe_application/models/wishlist_item.dart';

// class WishlistProvider extends ChangeNotifier{
//   static const String boxName='wishlistBox';
//   late Box<WishlistItem> wishlistBox;
//   late Box _box;
//   WishlistProvider(){
//     _box=Hive.box(boxName);
//   }
//   bool isItemInWishlist(int id){
//     return _box.containsKey(id);
//   }
//   List<Recipe> get wishlistItems{
//     return _box.values.map((item)=> item as Recipe).toList();

//   }
//   void toggleWishlist(Recipe recipe){
//     if(_box.containsKey(recipe.id)){
//       _box.delete(recipe.id);
//     }else{
//       _box.put(recipe.id, recipe);
//     }
//     notifyListeners();
//   }

//   Future<void> init()async{
//     wishlistBox=await Hive.openBox<WishlistItem>(boxName);
//     notifyListeners();
//   }
//   bool isFavourite(int id) {
//     return wishlistBox.values.any((item)=> item.id == id);
//   }

//   void addToWishlist(WishlistItem item){
//     if(!isFavourite(item.id)){
//       wishlistBox.add(item);
//       notifyListeners();
//     }
//   }
//   void removeFromWishlist(int id){
//     final key= wishlistBox.keys.firstWhere((key)=> wishlistBox.get(key)!.id == id,
//     orElse: ()=> null);
//     if(key != null){
//       wishlistBox.delete(key);
//       notifyListeners();
//     }
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:recipe_application/models/recipe.dart';

// class WishlistProvider extends ChangeNotifier{
//   final List<Recipe> _wishlist=[];
//    List<Recipe> get wishlist=>_wishlist;

//    bool isAdded(int recipeId){
//     return _wishlist.any((r)=> r.id ==recipeId);
//    }
//    void toggleWishlist(Recipe recipe){
//     if(isAdded(recipe.id)){
//       _wishlist.removeWhere((r)=> r.id == recipe.id);
//     }else{
//       _wishlist.add(recipe);
//     }
//     notifyListeners();
//    }
//    bool isWishListed(int id){
//     return _wishlist.any((item)=> item.id == id);
//    }
// }