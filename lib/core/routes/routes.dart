import "package:flutter_bloc/flutter_bloc.dart";
import "package:go_router/go_router.dart";
import "package:talker_flutter/talker_flutter.dart";
import "package:tcp_udp_client_app/core/utils/logger.dart";
import "package:tcp_udp_client_app/features/home/home_page.dart";
import "package:tcp_udp_client_app/features/tcp_client/bloc/tcp_cubit.dart";
import "package:tcp_udp_client_app/features/tcp_client/presentation/tcp_page.dart";
import "package:tcp_udp_client_app/features/udp_client/presentation/udp_page.dart";
import "package:tcp_udp_client_app/features/udp_client/bloc/udp_cubit.dart";

abstract class AppRoutes {
  static const String initial = "/";
  static const String tcp = "/tcp";
  static const String udp = "/udp";
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
        routes: [
          GoRoute(
            path: AppRoutes.tcp,
            builder: (context, state) => BlocProvider(
              create: (context) => TcpCubit(),
              child: const TcpPage(),
            ),
          ),
          GoRoute(
            path: AppRoutes.udp,
            builder: (context, state) => BlocProvider(
              create: (context) => UdpCubit()..initializeDeviceIPs(),
              child: const UdpPage(),
            ),
          ),
        ]),
  ],
);
