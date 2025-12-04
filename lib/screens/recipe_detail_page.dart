import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_application/models/recipe.dart';
import 'package:recipe_application/provider/wishlist_provider.dart';
import 'package:recipe_application/screens/update_recipe.dart';
import 'package:recipe_application/services/recipe_service.dart';

class RecipeDetailPage extends StatefulWidget {
  final int recipeId;
 
  const RecipeDetailPage({super.key, required this.recipeId});

  @override
  State<RecipeDetailPage> createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  final RecipeService _recipeService=RecipeService();
  late Future<Recipe> recipeFuture;

  @override
   void initState() {
  
    super.initState();
    recipeFuture=_recipeService.fetchRecipeDetail(widget.recipeId);
  }
  @override
  Widget build(BuildContext context) {
    final wishlistProvider=Provider.of<WishlistProvider>(context);
    return  Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: FutureBuilder<Recipe>(
        future: recipeFuture,
         builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator(),);
        }
        if(!snapshot.hasData){
          return const Center(child: Text("No recipe found"),);
        }
        final recipe=snapshot.data!;
        bool isWishListed= wishlistProvider.isAdded(recipe.id);
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(35),
                      bottomRight: Radius.circular(35)),
                      child: Image.network(recipe.image,
                      height: 350,
                      width: double.infinity,
                      fit: BoxFit.cover,),
                    ),
                    Positioned(
                      top: 80,
                      left: 20,
                      child:_circleButton(
                        
                        Icons.arrow_back_ios, (){
                      Navigator.pop(context);
                    }) ),
                    Positioned(
                      top: 80,
                      right: 20,
                      child: GestureDetector(onTap: (){
                        wishlistProvider.toggleWishlist(recipe);

                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(

                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isWishListed ? Icons.favorite
                       : Icons.favorite_border,
                      color: Colors.red,
                      size: 26,),
                    ),))
                   
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(100)),
                      child: IconButton(onPressed: ()async{
                        Navigator.push(context,
                         MaterialPageRoute(builder: (_)=>UpdateRecipeScreen(
                          name: recipe.name,
                           servings: recipe.servings,
                            instructions: recipe.instructions)));
                      }, icon: Icon(Icons.edit)),
                    ),
                    const SizedBox(height: 20,),
                    
                    
                    
                    Text(recipe.name,
                     style: const TextStyle(
                      fontSize: 24,
                    fontWeight: FontWeight.bold),
                    //IconButton(onPressed: ()async{
                    //    Navigator.push(context, MaterialPageRoute(builder: (_)=> UpdateRecipeScreen(
                    //   name: recipe.name,
                    //   instructions: recipe.instructions,
                    //   servings: recipe.servings)));
                    //   }, icon: Icon(Icons.edit),),
                    ),
                    
                    const SizedBox(height: 12,),
                    Text("Instructions:",style: TextStyle(fontSize: 18,
                    fontWeight: FontWeight.bold),),
                    const SizedBox(height: 10,),
                    ...recipe.instructions.map((step)=> Padding(padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(".",style: TextStyle(fontSize: 16,
                        fontWeight: FontWeight.bold),),
                        Expanded(child: Text(step,style: TextStyle(fontSize: 16,
                        height: 1.4),))
                      ],
                    ),
                    )),
                   
                    const SizedBox(height: 25,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _infoBox(Icons.access_time, "Cooking time", "${recipe.cookTimeMinutes} mins",
                        ),
                        _infoBox(Icons.flag, "Difficulty", recipe.difficulty),
                        _infoBox(Icons.people, "Servings", "${recipe.servings} people"),
                        
                      ],
                    ),
                    const SizedBox(height: 25,),
                    Text("Ingredients(${recipe.ingredients.length})",style: const TextStyle(fontSize: 20,
                    fontWeight: FontWeight.bold),),
                    const SizedBox(height: 15,),
                    ...recipe.ingredients.map((item)=> _ingredientCard(item)),
                    const SizedBox(height: 20,),
                    Center(child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 14,
                      horizontal: 40),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Text("⭐ Rate Recipe",
                      style: TextStyle(color: Colors.white),),
                    ),),
                    const SizedBox(height: 30,),

                  ],
                ),
                ),
              ],
            ),
          );
        
      },
      ),
    );
  }
  Widget _circleButton(IconData icon, VoidCallback onTap){
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(color: Colors.white,
        shape: BoxShape.circle,),
        child: Icon(icon,size: 20,),
      ),
    );
  }
  Widget _infoBox(IconData icon,String title, String value){
    return Container(
      width: 110,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
       child: Column(
        children: [
          Icon(icon, size: 22),
          const SizedBox(height: 5),
          Text(title, style: const TextStyle(fontSize: 12)),
          const SizedBox(height: 3),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
   Widget _ingredientCard(String name) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Image.network(
            "https://img.icons8.com/color/96/meal.png",
            width: 45,
            height: 45,
          ),
          const SizedBox(width: 12),
          Text(
            name,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}