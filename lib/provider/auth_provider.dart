import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:recipe_application/models/user.dart';
import 'package:recipe_application/services/auth_service.dart';

class AuthProvider extends ChangeNotifier{
  final AuthService _service;
  AuthProvider(this._service);
  final storage= const FlutterSecureStorage();

  bool isLoading=false;
  String? errorMessage;
  UserModel? user;

  bool get isLoggedIn => user != null;
  Future<bool> autoLogin()async{
    final token= await storage.read(key: "token");
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// import 'package:recipe_application/services/auth_service.dart';

// class AuthProvider extends ChangeNotifier {
//   final AuthService _authService;
//   AuthProvider(this._authService);
//   final storage = const FlutterSecureStorage();

//   bool isLoading = false;
//   String? errorMessage;
//   Map<String, dynamic>? userData;
//   Future<bool> autoLogin()async{
//     String? token= await storage.read(key: "token");
//     if(token==null)return false;
//     userData={"token":token};
//     notifyListeners();
//     return true;
//   }

//   Future<bool> login(String username, String password) async {
//     isLoading = true;
//     errorMessage = null;
//     notifyListeners();

//     final result = await _authService.login(username, password);

//     isLoading = false;

//     if (result["success"]) {
//       userData = result["data"];
//       await storage.write(key: "token", value: userData!["token"]);
//       notifyListeners();
//       return true;
//     } else {
//       errorMessage = result["message"];
//       notifyListeners();
//       return false;
//     }
//   }
// }
