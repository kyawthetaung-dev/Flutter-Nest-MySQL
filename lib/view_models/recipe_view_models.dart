import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_plan/models/models.dart';
import 'package:meal_plan/services/services.dart';

class RecipeViewModelNotifier
    extends StateNotifier<AsyncValue<List<RecipeModel>>> {
  RecipeViewModelNotifier() : super(AsyncData([]));

  final remoteService = RecipeRemoteService();

  Future<void> fetchRecipes() async {
    state = AsyncLoading();
    try {
      final recipes = await remoteService.fetchRecipes();
      state = AsyncData(recipes);
    } on DioException catch (e, stack) {
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.unknown) {
        state = AsyncError("Connection Error", stack);
      } else {
        state = AsyncError(e.response?.statusMessage ?? e, stack);
      }
    }
  }

  Future<void> fetchRecipesByIngredients(
    String ingredients,
  ) async {
    state = AsyncLoading();
    try {
      final recipes =
          await remoteService.fetchRecipesByIngredients(ingredients);
      state = AsyncData(recipes);
    } on DioException catch (e, stack) {
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.unknown) {
        state = AsyncError("Connection Error", stack);
      } else {
        state = AsyncError(e.response?.statusMessage ?? e, stack);
      }
    }
  }
}

final recipeViewModelProvider = StateNotifierProvider<RecipeViewModelNotifier,
    AsyncValue<List<RecipeModel>>>((ref) => RecipeViewModelNotifier());
