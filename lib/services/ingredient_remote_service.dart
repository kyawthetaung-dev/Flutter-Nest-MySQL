import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:meal_plan/models/models.dart';

import '../core/feat_core.dart';

abstract class IIngredientRemoteService {
  Future<List<IngredientModel>> fetchIngredients();
}

class IngredientRemoteService implements IIngredientRemoteService {
  @override
  Future<List<IngredientModel>> fetchIngredients() async {
    try {
      Dio dio = dioProvider();
      final response = await dio.get(
          'food/ingredients/search?apiKey=${dotenv.get("apiKEY")}&query=vegetables&offset=0&number=15');
      final data = response.data['results'] as List<dynamic>;
      return data.map((e) => IngredientModel.fromMap(e)).toList();
    } on DioException catch (e) {
      throw DioException(requestOptions: RequestOptions(), error: e.error);
    }
  }
}
