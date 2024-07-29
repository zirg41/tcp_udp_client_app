import "package:flutter/material.dart";

import "package:initial_app/core/config/environment.dart";
import "package:initial_app/core/config/injectable.dart";
import "package:initial_app/core/qa/flavor_banner.dart";
import "package:initial_app/core/utils/device_info_service.dart";

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Initial Project",
      home: FlavorBanner(
        child: Scaffold(
          appBar: AppBar(title: const Text("Flutter Initial Project")),
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
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
