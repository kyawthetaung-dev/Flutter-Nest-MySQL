import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_plan/models/models.dart';
import 'package:meal_plan/services/services.dart';

class IngredientViewModelNotifier
    extends StateNotifier<AsyncValue<List<IngredientModel>>> {
  IngredientViewModelNotifier() : super(AsyncData([]));

  final remoteService = IngredientRemoteService();

  Future<void> fetchIngredients() async {
    state = AsyncLoading();
    try {
      final ingredients = await remoteService.fetchIngredients();
      state = AsyncData(ingredients);
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

final ingredientViewModelProvider = StateNotifierProvider<
    IngredientViewModelNotifier,
    AsyncValue<List<IngredientModel>>>((ref) => IngredientViewModelNotifier());
