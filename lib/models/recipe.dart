import 'package:hive_flutter/adapters.dart';

part 'recipe.g.dart';
@HiveType(typeId: 0)
class Recipe extends HiveObject{
  @HiveField(0)
   int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String image;
  @HiveField(3)
  String cuisine;
  @HiveField(4)
  double rating;
  @HiveField(5)
  int servings;
  @HiveField(6)
  int prepTimeMinutes;
  @HiveField(7)
  int cookTimeMinutes;
  @HiveField(8)
  String difficulty;
  @HiveField(9)
  List<String> ingredients;
  @HiveField(10)
  List<String> instructions;
  @HiveField(11)
  int caloriesPerServing;
  @HiveField(12)
  List<String> tags;
  @HiveField(13)
  List<String> mealType;

  Recipe({
    required this.id,
    required this.name,
    required this.image,
    required this.cuisine,
    required this.rating,
    required this.servings,
    required this.prepTimeMinutes,
    required this.cookTimeMinutes,
    required this.difficulty,
    required this.ingredients,
    required this.instructions,
    required this.caloriesPerServing,
    required this.tags,
    required this.mealType,
  });

  factory Recipe.fromJson(Map<String, dynamic> json){
    return Recipe(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Unknown Recipe',
      image: json['image'] ?? '',
      cuisine: json['cuisine'] ?? 'Unknown',
      
      rating: double.tryParse(json['rating'].toString()) ?? 0.0,
      servings: json['servings'] ?? 0,
      prepTimeMinutes: json['prepTimeMinutes'] ?? 0,
      cookTimeMinutes: json['cookTimeMinutes'] ?? 0,
      difficulty: json['difficulty'] ?? 'Medium',
      ingredients: List<String>.from(json['ingredients'] ?? []),
      instructions: List<String>.from(json['instructions'] ?? []),
      caloriesPerServing: json['caloriesPerServing'] ?? 0,
      tags: List<String>.from(json['tags'] ?? []),
      mealType: List<String>.from(json['mealType'] ?? []),
    );

     
  }
  Map<String, dynamic> toJson(){
    return{ 
      'id': id,
      'name': name,
      'image': image,
      'cuisine': cuisine,
      'rating': rating,
      'servings': servings,
      'prepTimeMinutes': prepTimeMinutes,
      'cookTimeMinutes': cookTimeMinutes,
      'difficulty': difficulty,
      'ingredients': ingredients,
      'instructions': instructions,
      'caloriesPerServing': caloriesPerServing,
      'tags': tags,
      'mealType': mealType,

    };
  }
  
  
}