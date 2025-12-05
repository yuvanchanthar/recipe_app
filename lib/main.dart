import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_application/provider/auth_provider.dart';
import 'package:recipe_application/provider/recipe_provider.dart';
import 'package:recipe_application/provider/wishlist_provider.dart';
import 'package:recipe_application/screens/all_recipe.dart';
import 'package:recipe_application/screens/signin_page.dart';

void main() {
  runApp(
    MultiProvider(providers: [ChangeNotifierProvider(create: (_)=> RecipeProvider()),
    ChangeNotifierProvider(create: (_)=> AuthProvider()),
    ChangeNotifierProvider(create: (_)=>WishlistProvider())],
    child: const MainApp())
    );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool? _isLoggedIn = null;
  @override void initState() {
    
    super.initState();
    _checkLogin();
  }
  Future<void> _checkLogin()async{
    final auth= Provider.of<AuthProvider>(context,listen: false);
    bool result= await auth.autoLogin();
    setState(() {
      _isLoggedIn=true;
    });
  }
  @override
  Widget build(BuildContext context) {
    if (_isLoggedIn == null) {
      return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _isLoggedIn! ? const AllRecipePage() : const SigninPage(),
    );
  }
}
//   Widget build(BuildContext context) {
//     if(_isLoggedIn==null){
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         body: Center(
//           child: CircularProgressIndicator(),
//         ),
//       ),
//     );
//   }
//   return MaterialApp(debu)
// }
