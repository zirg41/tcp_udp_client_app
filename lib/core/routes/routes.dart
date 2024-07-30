import "package:go_router/go_router.dart";
import "package:initial_app/core/utils/logger.dart";
import "package:initial_app/features/home/home_page.dart";
import "package:talker_flutter/talker_flutter.dart";

abstract class AppRoutes {
  static const String initial = "/";
}

final appRouter = GoRouter(
  onException: (context, state, router) {
    context.go(AppRoutes.initial);
  },
  observers: [TalkerRouteObserver(logger)],
  initialLocation: AppRoutes.initial,
  routes: [
    GoRoute(
      path: AppRoutes.initial,
      builder: (context, state) => const HomePage(),
    ),
  ],
);
