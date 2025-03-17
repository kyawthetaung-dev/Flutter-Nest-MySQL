import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_plan/models/models.dart';
import 'package:meal_plan/services/services.dart';

class UserViewModelNotifier extends StateNotifier<AsyncValue<List<UserModel>>> {
  UserViewModelNotifier() : super(AsyncData([]));

  final remoteService = UserRemoteService();

  Future<void> fetchUsers() async {
    state = AsyncLoading();
    try {
      final user = await remoteService.fetchUser();
      state = AsyncData(user);
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

final userViewModelProvider =
    StateNotifierProvider<UserViewModelNotifier, AsyncValue<List<UserModel>>>(
        (ref) => UserViewModelNotifier());
