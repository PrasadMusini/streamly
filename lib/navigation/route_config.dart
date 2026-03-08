import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:streamly_cresolinfoserv/features/profile/presentation/pages/profile_page.dart';
import 'package:streamly_cresolinfoserv/features/videos/presentation/pages/home_page.dart';
import 'package:streamly_cresolinfoserv/navigation/app_router.dart';
import 'package:streamly_cresolinfoserv/navigation/main_screen.dart';
import 'package:streamly_cresolinfoserv/navigation/page_notfound.dart';

class GoRouterConfig {
  final String? initialRoute;

  final _rootNavigatorKey = GlobalKey<NavigatorState>();

  final _homeBranchNavigatorKey = GlobalKey<NavigatorState>();
  final _profileBranchNavigatorKey = GlobalKey<NavigatorState>();

  late final GoRouter router;

  GoRouterConfig({this.initialRoute}) {
    router = GoRouter(
      initialLocation: initialRoute,
      navigatorKey: _rootNavigatorKey,
      debugLogDiagnostics: true,
      errorPageBuilder: (context, state) {
        return CupertinoPage(key: state.pageKey, child: const PageNotFound());
      },
      routes: [
        StatefulShellRoute.indexedStack(
          builder: (context, state, child) =>
              MainScreen(navigationShell: child),
          branches: <StatefulShellBranch>[
            //MARK: 1: Home
            StatefulShellBranch(
              navigatorKey: _homeBranchNavigatorKey,
              routes: <RouteBase>[
                GoRoute(
                  path: Routes.screenHome.path,
                  name: Routes.screenHome.name,
                  pageBuilder: (context, state) =>
                      CupertinoPage(key: state.pageKey, child: HomeScreen()),
                ),
              ],
            ),
            //MARK: 2: Profile
            StatefulShellBranch(
              navigatorKey: _profileBranchNavigatorKey,
              routes: <RouteBase>[
                GoRoute(
                  path: Routes.screenProfile.path,
                  name: Routes.screenProfile.name,
                  pageBuilder: (context, state) =>
                      CupertinoPage(key: state.pageKey, child: ProfileScreen()),
                ),
              ],
            ),
          ],
        ),
        /* GoRoute(
          path: Routes.screenOnboarding.path,
          name: Routes.screenOnboarding.name,
          pageBuilder: (context, state) =>
              CupertinoPage(key: state.pageKey, child: OnboardingScreen()),
        ), */
      ],
    );
  }
}
