
import 'package:dio/dio.dart';
import 'package:meal_plan/core/feat_core.dart';
import 'package:meal_plan/models/models.dart';

abstract class IRUserRemoteService {
  Future<List<UserModel>> fetchUser();
}

class UserRemoteService implements IRUserRemoteService {
  @override
  Future<List<UserModel>> fetchUser() async {
    try {
      Dio dio = dioProvider();
      final response = await dio.get(
        "http://192.168.0.104:3000/users/raw",
      );
      //log("fetchRecipes $response");
      final data = response.data as List<dynamic>;
      return data.map((e) => UserModel.fromMap(e)).toList();
    } on DioException catch (e) {
      throw DioException(requestOptions: RequestOptions(), error: e.error);
    }
  }
}
