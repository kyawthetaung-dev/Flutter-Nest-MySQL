import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_plan/models/models.dart';
import 'package:meal_plan/services/services.dart';

class RecipeDetailViewModelNotifier
    extends StateNotifier<AsyncValue<RecipeModel?>> {
  RecipeDetailViewModelNotifier() : super(AsyncData(null));

  final remoteService = RecipeRemoteService();

  Future<void> fetchRecipeDetail(String reciptId) async {
    state = AsyncLoading();
    try {
      final recipe = await remoteService.fetchRecipeDetail(reciptId);
      state = AsyncData(recipe);
    } on DioException catch (e, stack) {
      // plog('fetchRecipes viewmodel', e);
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

final recipeDetailViewModelProvider = StateNotifierProvider<
    RecipeDetailViewModelNotifier,
    AsyncValue<RecipeModel?>>((ref) => RecipeDetailViewModelNotifier());
