import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:meal_plan/models/models.dart';

import '../core/feat_core.dart';

abstract class IRecipeRemoteService {
  Future<List<RecipeModel>> fetchRecipes();
  Future<List<RecipeModel>> fetchRecipesByIngredients(String ingredients);
  Future<RecipeModel> fetchRecipeDetail(String reciptId);
}

class RecipeRemoteService implements IRecipeRemoteService {
  @override
  Future<List<RecipeModel>> fetchRecipes() async {
    try {
      Dio dio = dioProvider();
      final response = await dio.get(
        'recipes/complexSearch?apiKey=${dotenv.get("apiKEY")}&offset=0&number=15',
      );
      plog("fetchRecipes", response);
      final data = response.data['results'] as List<dynamic>;
      return data.map((e) => RecipeModel.fromMap(e)).toList();
    } on DioException catch (e) {
      throw DioException(requestOptions: RequestOptions(), error: e.error);
    }
  }

  @override
  Future<List<RecipeModel>> fetchRecipesByIngredients(
    String ingredients,
  ) async {
    try {
      Dio dio = dioProvider();
      final response = await dio.get(
          'recipes/findByIngredients?apiKey=${dotenv.get("apiKEY")}&ingredients=$ingredients,tomatoes&number=10');
      final data = response.data as List<dynamic>;
      return data.map((e) => RecipeModel.fromMap(e)).toList();
    } on DioException catch (e) {
      throw DioException(requestOptions: RequestOptions(), error: e.error);
    }
  }

  @override
  Future<RecipeModel> fetchRecipeDetail(String reciptId) async {
    try {
      Dio dio = dioProvider();
      final response = await dio
          .get('recipes/$reciptId/information?apiKey=${dotenv.get("apiKEY")}');
      final data = response.data as Map<String, dynamic>;
      return RecipeModel.fromMap(data);
    } on DioException catch (e) {
      throw DioException(requestOptions: RequestOptions(), error: e.error);
    }
  }
}
