class AppRouter {
  final String path;
  final String name;
  const AppRouter({required this.path, required this.name});
}

class Routes {
  static const AppRouter screenHome = AppRouter(
    path: '/screenHome',
    name: 'screenHome',
  );
  static const AppRouter screenProfile = AppRouter(
    path: '/screenProfile',
    name: 'screenProfile',
  );
  static const AppRouter screenLogin = AppRouter(
    path: '/screenLogin',
    name: 'screenLogin',
  );
}
