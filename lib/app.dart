import "package:flutter/material.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:tcp_udp_client_app/core/qa/flavor_banner.dart";
import "package:tcp_udp_client_app/core/routes/routes.dart";

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      builder: (context, child) {
        return FlavorBanner(
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }
}
