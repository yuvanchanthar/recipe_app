import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_application/provider/auth_provider.dart';
import 'package:recipe_application/provider/recipe_provider.dart';
import 'package:recipe_application/provider/wishlist_provider.dart';
import 'package:recipe_application/screens/signin_page.dart';

void main() {
  runApp(
    MultiProvider(providers: [ChangeNotifierProvider(create: (_)=> RecipeProvider()),
    ChangeNotifierProvider(create: (_)=> AuthProvider()),
    ChangeNotifierProvider(create: (_)=>WishlistProvider())],
    child: const MainApp())
    );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: SigninPage(),
        ),
      ),
    );
  }
}
