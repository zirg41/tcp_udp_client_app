import "package:flutter/material.dart";
import "package:initial_app/core/config/environment.dart";
import "package:initial_app/core/config/injectable.dart";
import "package:initial_app/core/utils/device_info_service.dart";
import "package:initial_app/core/utils/extensions/build_context_x.dart";

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
