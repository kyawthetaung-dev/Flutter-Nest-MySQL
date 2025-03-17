import 'package:flutter/foundation.dart';

import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:path_provider/path_provider.dart' as pp;

Dio dioProvider() {
  Dio dio = Dio(
    BaseOptions(
      baseUrl: '',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ),
  );
  if (kDebugMode) {
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    );
  }

  dio.interceptors.add(
    DioCacheInterceptor(
      options: CacheOptions(
        store: HiveCacheStore(AppPathProvider.path),
        policy: CachePolicy.forceCache,
        hitCacheOnErrorExcept: [401, 403],
        maxStale: const Duration(minutes: 30),
        priority: CachePriority.normal,
      ),
    ),
  );

  return dio;
}

class AppPathProvider {
  AppPathProvider._();

  static String? _path;

  static String get path {
    if (_path != null) {
      return _path!;
    } else {
      throw Exception('path not initialized');
    }
  }

  static Future<void> initPath() async {
    if (kIsWeb) {
      _path = '/';
    } else {
      final dir = await pp.getApplicationDocumentsDirectory();
      _path = dir.path;
    }
  }
}
