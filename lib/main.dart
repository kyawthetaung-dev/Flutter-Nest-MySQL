import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:toastification/toastification.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/feat_core.dart';

void main() async {
  await appInit();
  runApp(ProviderScope(child: MyApp()));
}

Future<void> appInit() async {
  WidgetsFlutterBinding.ensureInitialized();
 // await dotenv.load(fileName: ".env");

  sharedPreferences = await SharedPreferences.getInstance();

  // Initialize Hive with the subdirectory
  await Hive.initFlutter();
  await Hive.openBox(AppDb.favorite);
  await Hive.openBox(AppDb.weeklyPlan);
  await AppPathProvider.initPath();
}

class MyApp extends ConsumerWidget {
  MyApp({super.key});
  final _appRouter = AppRouter();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ToastificationWrapper(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: AppStrings.appName,
        themeMode: ref.watch(themeModeProvider),
        darkTheme: AppThemes.dark,
        theme: AppThemes.light,
        routerConfig: _appRouter.config(),
      ),
    );
  }
}
