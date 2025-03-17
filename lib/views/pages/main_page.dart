import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_plan/core/feat_core.dart';

@RoutePage()
class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      backgroundColor: context.color.primary,
      animationDuration: const Duration(milliseconds: 0),
      animationCurve: Curves.linear,
      routes: const [UserRoute(), FavoriteRoute(), WeeklyPlanRoute()],
      bottomNavigationBuilder: (_, tabsRouter) {
        return BottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          backgroundColor: context.color.primary,
          fixedColor: context.color.primary,
          useLegacyColorScheme: false,
          showUnselectedLabels: true,
          selectedIconTheme: IconThemeData(color: context.color.onPrimary),
          selectedLabelStyle: TextStyle(
            color: context.color.onPrimary,
            fontWeight: FontWeight.bold,
          ),
          unselectedIconTheme:
              IconThemeData(color: context.color.onPrimaryFixed),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.favorite),
              label: 'Favorite',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.calendar_month_outlined),
              label: 'Plan',
            ),
          ],
        );
      },
    );
  }
}
