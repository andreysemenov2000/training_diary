import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:training_diary/features/statistics/statistics_page.dart';
import 'package:training_diary/features/train/presentation/pages/create_train_page.dart';
import 'package:training_diary/features/train/presentation/pages/details_page.dart';
import 'package:training_diary/utils/themes/theme_config.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final GoRouter _router;
  late final ThemeConfig _themeConfig;

  @override
  void initState() {
    super.initState();
    _router = GoRouter(
      initialLocation: '/train',
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
                  path: '/train',
                  builder: (context, routerState) => const CreateTrainPage(),
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
    _themeConfig = ThemeConfig();
    _themeConfig.addListener(
      () {
        setState(() {});
      },
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: createLightTheme(),
      darkTheme: createDarkTheme(),
      themeMode: ThemeConfig().getThemeMode(),
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
      floatingActionButton: ElevatedButton(
        onPressed: () {
          _themeConfig.toggleTheme();
        },
        child: const Icon(Icons.brightness_4),
      ),
    );
  }
}
