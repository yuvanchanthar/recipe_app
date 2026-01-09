import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:recipe_application/core/dio_client.dart';
import 'package:recipe_application/repositories/recipe_repository.dart';
import 'package:recipe_application/repositories/recipe_repository_impl.dart';
import 'package:recipe_application/services/recipe_service.dart';

final getIt=GetIt.instance;
void setupDependencies(){
  getIt.registerLazySingleton<Dio>(
    ()=>DioClient.createDio());
  getIt.registerLazySingleton<RecipeService>(
    ()=> RecipeService(getIt<Dio>()));
  getIt.registerLazySingleton<RecipeRepository>(
    ()=> RecipeRepositoryImpl(getIt<RecipeService>()));
}