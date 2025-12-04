class Recipe {
  final int id;
   String name;
  final String image;
  final String cuisine;
  final double rating;
   int servings;
  final int prepTimeMinutes;
  final int cookTimeMinutes;
  final String difficulty;
  final List<String> ingredients;
   List<String> instructions;
  final int caloriesPerServing;
  final List<String> tags;
  final List<String> mealType;

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