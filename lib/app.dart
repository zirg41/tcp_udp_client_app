import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:tcp_udp_client_app/core/config/injectable.dart";
import "package:tcp_udp_client_app/core/routes/routes.dart";
import "package:tcp_udp_client_app/core/styles/theme.dart";
import "package:tcp_udp_client_app/features/tcp_client/bloc/tcp_cubit.dart";

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: AppTheme.themeData,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => getIt<TcpCubit>(),
            )
          ],
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }
}
