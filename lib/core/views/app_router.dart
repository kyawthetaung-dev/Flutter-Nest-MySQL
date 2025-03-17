import "package:auto_route/auto_route.dart";
import "package:meal_plan/core/views/app_router.gr.dart";

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: MainRoute.page,
          path: '/',
          children: [
            AutoRoute(
              page: UserRoute.page,
              path: 'user',
            ),
            AutoRoute(
              page: FavoriteRoute.page,
              path: 'favorite',
            ),
            AutoRoute(
              page: WeeklyPlanRoute.page,
              path: 'weekly-plan',
            ),
          ],
        ),
        AutoRoute(page: RecipeDetialRoute.page, path: '/detail'),
      ];
}
