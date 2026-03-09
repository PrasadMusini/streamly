import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamly_cresolinfoserv/features/videos/data/datasource/video_remote_datasource.dart';
import 'package:streamly_cresolinfoserv/features/videos/data/repositories/video_repository_impl.dart';
import 'package:streamly_cresolinfoserv/features/videos/domain/usecases/get_videos.dart';
import 'package:streamly_cresolinfoserv/features/videos/presentation/bloc/video_bloc.dart';
import 'package:streamly_cresolinfoserv/navigation/app_router.dart';
import 'package:streamly_cresolinfoserv/navigation/route_config.dart';
import 'package:streamly_cresolinfoserv/notifications/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  await NotificationService.instance.init();

  final fcmToken = await FirebaseMessaging.instance.getToken();
  print("fcmToken: $fcmToken");

  // Initialize GoRouterConfig once and reuse it
  final goRouterConfig = GoRouterConfig(initialRoute: Routes.screenHome.path);

  /// Dependencies
  final dio = Dio();

  final remoteDataSource = VideoRemoteDataSource(dio);

  final repository = VideoRepositoryImpl(remoteDataSource);

  final getVideos = GetVideos(repository);

  runApp(
    MultiBlocProvider(
      providers: [BlocProvider(create: (_) => VideoBloc(getVideos))],
      child: MyApp(goRouterConfig),
    ),
  );
}

class MyApp extends StatelessWidget {
  final GoRouterConfig goRouterConfig;
  const MyApp(this.goRouterConfig, {super.key});

  @override
  Widget build(BuildContext context) {
    // final themeMode = ref.watch(themeProvider);

    return MaterialApp.router(
      builder: (context, child) {
        final originalTextScaleFactor = MediaQuery.of(
          context,
        ).textScaler.scale(1.0);

        final boldText = MediaQuery.boldTextOf(context);

        final newMediaQueryData = MediaQuery.of(context).copyWith(
          boldText: boldText,
          textScaler: TextScaler.linear(
            originalTextScaleFactor.clamp(0.8, 1.0),
          ),
        );
        return MediaQuery(data: newMediaQueryData, child: child!);
      },
      routerDelegate: goRouterConfig.router.routerDelegate,
      routeInformationParser: goRouterConfig.router.routeInformationParser,
      routeInformationProvider: goRouterConfig.router.routeInformationProvider,
      // theme: lightTheme,
      // darkTheme: darkTheme,
      // themeMode: themeMode,
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
    );
  }
}
