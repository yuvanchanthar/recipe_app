import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:recipe_application/models/user.dart';


class AuthService {
  final Dio dio= Dio();
  final  _storage=const FlutterSecureStorage();

  Future<User?> login(String username,String password)async{
    try{
      final response= await dio.post("https://dummyjson.com/auth/login",
      data: {"username":username,
      "password":password},options: Options(headers: {"Content-Type":"application/json"}));
      if(response.statusCode==200){
        return User.fromJson(response.data);
       
      }else{
        return null;
      }
    }catch(e){
      return null;
    }

  }
  Future<void> logout(BuildContext context)async{
    await _storage.delete(key: "access_token");
    await _storage.delete(key: "refresh_token");
    Navigator.pushReplacementNamed(context, '/signin');
  }
}