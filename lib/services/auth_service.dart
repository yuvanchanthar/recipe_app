import 'package:dio/dio.dart';

class AuthService {
  final Dio dio;

  AuthService(this.dio);
  Future<Map<String, dynamic>> login(String username, String password)async{
    try{
      final response= await dio.post("/auth/login",
      data: {
        "username":username.trim(),
        "password":password.trim(),
      });
      return{"success":true, "data":response.data};

    }on DioException catch(e){
      if(e.type == DioExceptionType.connectionError){
        return{"success":false,"message":"No internet connection"};
      }
      if(e.response?.statusCode==400){
        return{'success':false, "message":"Invalid credentials"};

      }
      return{
        "success":false,
        "message":"Something went wrong"
      };
    }
  }
}
// import 'package:dio/dio.dart';

// class AuthService {
//   final Dio _dio = Dio(
//     BaseOptions(
//       baseUrl: "https://dummyjson.com",
//       connectTimeout: const Duration(seconds: 10),
//       receiveTimeout: const Duration(seconds: 10),
//       headers: {
//         "Content-Type": "application/json",
//       },
//     ),
//   );

//   Future<Map<String, dynamic>> login(String username, String password) async {
//     try {
//       final response = await _dio.post(
//         "/auth/login",
//         data: {
//           "username": username.trim(),
//           "password": password.trim(),
//         },
//       );

//       return {
//         "success": true,
//         "data": response.data,
//       };

//     } on DioException catch (e) {
//       // Network Issue
//       if (e.type == DioExceptionType.connectionError) {
//         return {"success": false, "message": "No internet connection"};
//       }

//       // Timeout
//       if (e.type == DioExceptionType.connectionTimeout ||
//           e.type == DioExceptionType.receiveTimeout) {
//         return {"success": false, "message": "Connection timeout"};
//       }

//       // Wrong username/password
//       if (e.response?.statusCode == 400) {
//         return {"success": false, "message": "Invalid username or password"};
//       }

//       return {
//         "success": false,
//         "message": e.response?.data?["message"] ?? "Something went wrong",
//       };
//     }
//   }
// }
