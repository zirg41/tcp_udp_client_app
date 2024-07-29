import "package:flutter/material.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:initial_app/core/config/environment.dart";
import "package:initial_app/core/config/injectable.dart";
import "package:initial_app/core/qa/flavor_banner.dart";
import "package:initial_app/core/utils/device_info_service.dart";
import "package:initial_app/core/utils/extensions/build_context_x.dart";

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FlavorBanner(
      child: Scaffold(
        appBar: AppBar(title: Text(context.strings.appName)),
        body: Center(
          child: Column(
            children: [
              Text(
                getIt<Environment>().name,
              ),
              FutureBuilder(
                future: getIt.getAsync<DeviceInfoService>(),
                builder: (context, snapshot) {
                  return Text(
                    "${snapshot.data?.deviceId}",
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
