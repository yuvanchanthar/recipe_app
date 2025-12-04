import 'package:flutter/material.dart';
import 'package:recipe_application/services/auth_service.dart';

class AuthProvider extends ChangeNotifier{
  final AuthService _auth=AuthService();
  bool isLoading=false;

  Future<bool> login(String user,String password)async{
    isLoading=true;
    notifyListeners();
    try{
      await _auth.login(user, password);
      isLoading=false;
      notifyListeners();
      return true;

    }catch(e){
      isLoading=false;
      notifyListeners();
      return false;
    }
  } 
}