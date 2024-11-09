import "package:go_router/go_router.dart";
import "package:talker_flutter/talker_flutter.dart";
import "package:tcp_udp_client_app/core/utils/logger.dart";
import "package:tcp_udp_client_app/features/home/home_page.dart";
import "package:tcp_udp_client_app/features/tcp_client/presentation/tcp_page.dart";

abstract class AppRoutes {
  static const String initial = "/";
  static const String tcp = "/tcp";
}

final appRouter = GoRouter(
  onException: (context, state, router) {
    context.go(AppRoutes.initial);
  },
  observers: [TalkerRouteObserver(logger)],
  initialLocation: AppRoutes.tcp,
  routes: [
    GoRoute(
      path: AppRoutes.initial,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: AppRoutes.tcp,
      builder: (context, state) => const TcpPage(),
    ),
  ],
);
