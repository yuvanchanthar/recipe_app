import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:recipe_application/provider/recipe_provider.dart';
import 'package:recipe_application/screens/signin_page.dart';
import 'package:recipe_application/services/auth_service.dart';
import '../models/recipe.dart';
import 'recipe_detail_page.dart';

class AllRecipePage extends StatefulWidget {
  const AllRecipePage({super.key});

  @override
  State<AllRecipePage> createState() => _AllRecipePageState();
}

class _AllRecipePageState extends State<AllRecipePage> {
  final storage = const FlutterSecureStorage();
  
  @override
  void initState() {
    super.initState();
    Provider.of<RecipeProvider>(context, listen: false).loadRecipes();
  }

  /// ------------------------- LOGOUT FUNCTION -------------------------
  Future<void> logout() async {
    await storage.deleteAll(); // Clear all tokens / data

    if (!mounted) return;

    // Red error snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Logged out successfully",
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      ),
    );

    // Redirect to Login Page and remove all previous pages
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const SigninPage()),
      (route) => false,
    );
  }

  /// ------------------------- CONFIRM LOGOUT DIALOG -------------------------
  void confirmLogout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey.shade100,
        title: const Text("Logout"),
        content: const Text("Are you sure you want to logout?"),
        actions: [
          TextButton(
            style: TextButton.styleFrom(backgroundColor: Colors.white),
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel",style: TextStyle(color: Colors.blueGrey),),
          ),
          TextButton(
            style: TextButton.styleFrom(backgroundColor: Colors.amber.shade400),
            onPressed: () {
              Navigator.pop(context);
              logout(); // call logout
            },
            child: const Text("Logout", style: TextStyle(color: Colors.black54)),
          ),
        ],
      ),
    );
  }

  /// ------------------------- UI -------------------------
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RecipeProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// HEADER WITH LOGOUT
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.logout, color: Colors.black),
                    onPressed: confirmLogout, // <--- ADDED
                    tooltip: 'logout',
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "All Recipes",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            /// SEARCH BAR
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: TextField(
                  onChanged: (value) => provider.search(value),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search here",
                    icon: Icon(Icons.search),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),

            /// CATEGORY FILTER
            SizedBox(
              height: 45,
              child: ListView(
                padding: const EdgeInsets.only(left: 20),
                scrollDirection: Axis.horizontal,
                children: [
                  _categoryChip(provider, "Breakfast"),
                  _categoryChip(provider, "Lunch"),
                  _categoryChip(provider, "Dinner"),
                  _categoryChip(provider, "Snack"),
                ],
              ),
            ),

            const SizedBox(height: 15),

            /// RECIPE LIST
            Expanded(
              child: provider.recipes.isEmpty
                  ? const Center(
                      child: Text(
                        'No results found',
                        style: TextStyle(fontSize: 18, color: Colors.redAccent),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: provider.recipes.length,
                      itemBuilder: (context, index) {
                        final recipe = provider.recipes[index];
                        return _recipeCard(context, recipe);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  /// CATEGORY CHIP UI
  Widget _categoryChip(RecipeProvider provider, String title) {
    bool selected = provider.selectedCategory == title;

    return GestureDetector(
      onTap: () => provider.filterByCategory(title),
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: selected ? Colors.white : Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  /// RECIPE CARD UI
  Widget _recipeCard(BuildContext context, Recipe recipe) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => RecipeDetailPage(recipeId: recipe.id),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [

            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                recipe.image,
                width: 70,
                height: 70,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(width: 15),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe.name,
                    style: const TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 17,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.access_time, size: 16),
                      const SizedBox(width: 6),
                      Text("${recipe.cookTimeMinutes} mins"),
                      const SizedBox(width: 12),
                      const Icon(Icons.star,
                          size: 16, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text("${recipe.rating}"),
                    ],
                  )
                ],
              ),
            ),

            const Icon(Icons.arrow_forward_ios, size: 18),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:provider/provider.dart';
// import 'package:recipe_application/provider/recipe_provider.dart';
// import 'package:recipe_application/screens/signin_page.dart';
// import 'package:recipe_application/services/auth_service.dart';
// //import 'package:recipe_application/screens/signin_page.dart';
// //import '../providers/recipe_provider.dart';
// import '../models/recipe.dart';
// import 'recipe_detail_page.dart';

// class AllRecipePage extends StatefulWidget {
//   const AllRecipePage({super.key});

//   @override
//   State<AllRecipePage> createState() => _AllRecipePageState();
// }

// class _AllRecipePageState extends State<AllRecipePage> {
//   final storage= const FlutterSecureStorage();
  
//   @override
//   void initState() {
//     super.initState();
//     Provider.of<RecipeProvider>(context, listen: false).loadRecipes();
//   }
  

//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<RecipeProvider>(context);

//     return Scaffold(
      
//       backgroundColor: Colors.grey.shade100,
//       body: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//   child: Row(
//     children: [
//       IconButton(
//         icon: const Icon(Icons.logout, color: Colors.black),
//        onPressed: (){},
//         tooltip: 'logout',
          
          
         
          
        
//       ),
//       const SizedBox(width: 10),
//       const Text(
//         "All Recipes",
//         style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//       ),
//     ],
//   ),
// ),


//             /// HEADER
//             // Padding(
//             //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//             //   child: Row(
//             //     children: const [
//             //       Icon(Icons.arrow_back_ios),
//             //       SizedBox(width: 15),
//             //       Text(
//             //         "All Recipes",
//             //         style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             //       ),
                  
                  
//             //     ],
//             //   ),
//             // ),

//             const SizedBox(height: 10),

//             /// SEARCH BAR
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 15),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(25),
//                 ),
//                 child: TextField(
//                   onChanged: (value) => provider.search(value),
//                   decoration: const InputDecoration(
//                     border: InputBorder.none,
//                     hintText: "Search here",
//                     icon: Icon(Icons.search),
//                   ),
//                 ),
//               ),
//             ),

//             const SizedBox(height: 15),

//             /// CATEGORY FILTER
//             SizedBox(
//               height: 45,
//               child: ListView(
//                 padding: const EdgeInsets.only(left: 20),
//                 scrollDirection: Axis.horizontal,
//                 children: [
//                   _categoryChip(provider, "Breakfast"),
//                   _categoryChip(provider, "Lunch"),
//                   _categoryChip(provider, "Dinner"),
//                   _categoryChip(provider, "Snack"),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 15),

//             /// RECIPE LIST
//             Expanded(
//               child: provider.recipes.isEmpty
//                   ? const Center(child: Text('No results found',style: TextStyle(fontSize: 18,color: Colors.redAccent),))
//                   : ListView.builder(
//                       padding: const EdgeInsets.symmetric(horizontal: 20),
//                       itemCount: provider.recipes.length,
//                       itemBuilder: (context, index) {
//                         final recipe = provider.recipes[index];
//                         return _recipeCard(context, recipe);
//                       },
//                     ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   /// CATEGORY CHIP UI
//   Widget _categoryChip(RecipeProvider provider, String title) {
//     bool selected = provider.selectedCategory == title;

//     return GestureDetector(
//       onTap: () => provider.filterByCategory(title),
//       child: Container(
//         margin: const EdgeInsets.only(right: 12),
//         padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
//         decoration: BoxDecoration(
//           color: selected ? Colors.black : Colors.white,
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: Text(
//           title,
//           style: TextStyle(
//             color: selected ? Colors.white : Colors.black,
//             fontSize: 15,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
//     );
//   }

//   /// RECIPE CARD UI
//   Widget _recipeCard(BuildContext context, Recipe recipe) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (_) => RecipeDetailPage(recipeId: recipe.id),
//           ),
//         );
//       },
//       child: Container(
//         margin: const EdgeInsets.only(bottom: 15),
//         padding: const EdgeInsets.all(15),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: Row(
//           children: [
//             /// IMAGE
//             ClipRRect(
//               borderRadius: BorderRadius.circular(15),
//               child: Image.network(
//                 recipe.image,
//                 width: 70,
//                 height: 70,
//                 fit: BoxFit.cover,
//               ),
//             ),

//             const SizedBox(width: 15),

//             /// TEXT
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     recipe.name,
//                     style: const TextStyle(fontStyle: FontStyle.italic,
//                         fontSize: 17, fontWeight: FontWeight.w600),
//                   ),
//                   const SizedBox(height: 6),
//                   Row(
//                     children: [
//                       const Icon(Icons.access_time, size: 16),
//                       const SizedBox(width: 6),
//                       Text("${recipe.cookTimeMinutes} mins"),
//                       const SizedBox(width: 12),
//                       const Icon(Icons.star,
//                           size: 16, color: Colors.amber),
//                       const SizedBox(width: 4),
//                       Text("${recipe.rating}"),
//                     ],
//                   )
//                 ],
//               ),
//             ),

//             const Icon(Icons.arrow_forward_ios, size: 18),
//           ],
//         ),
//       ),
//     );
//   }
// }

