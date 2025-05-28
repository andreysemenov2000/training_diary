import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:training_diary/features/statistics/statistics_page.dart';
import 'package:training_diary/features/train/calendar_page/presentation/pages/calendar_page.dart';
import 'package:training_diary/features/train/calendar_page/presentation/pages/details_page.dart';
import 'package:training_diary/utils/themes/theme_config.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final ThemeConfig _themeConfig;
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _themeConfig = ThemeConfig();
    _themeConfig.addListener(
      () {
        setState(() {});
      },
    );

    _router = GoRouter(
      initialLocation: '/calendar',
      routes: [
        StatefulShellRoute.indexedStack(
          builder: (context, routerState, navigationShell) => BaseScreen(
            navigationShell,
            _themeConfig,
          ),
          branches: [
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/calendar',
                  builder: (context, routerState) => const CalendarPage(),
                  routes: [
                    GoRoute(
                      path: '/details',
                      builder: (context, routerState) => const DetailsPage(),
                    ),
                  ],
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/statistics',
                  builder: (context, routerState) => const StatisticsPage(),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: createLightTheme(),
      darkTheme: createDarkTheme(),
      themeMode: _themeConfig.getThemeMode(),
      routerConfig: _router,
    );
  }
}

class BaseScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  final ThemeConfig _themeConfig;

  const BaseScreen(this.navigationShell, this._themeConfig, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.wine_bar),
            label: 'Тренировка',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label: 'Статистика',
          ),
        ],
        currentIndex: navigationShell.currentIndex,
        onTap: (i) => navigationShell.goBranch(i),
      ),
    );
  }
}
