import "dart:io";

import "package:flutter/material.dart";
import "package:initial_app/core/config/environment_entity.dart";
import "package:initial_app/core/config/injectable.dart";
import "package:initial_app/core/utils/device_info_service.dart";

class FlavorBanner extends StatelessWidget {
  final Widget child;

  const FlavorBanner({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (getIt<Environment>().isProd) {
      return child;
    }
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Stack(
        children: <Widget>[
          child,
          const Align(
            alignment: Alignment.bottomLeft,
            child: _BannerWidget(),
          ),
        ],
      ),
    );
  }
}

class _BannerWidget extends StatelessWidget {
  const _BannerWidget();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onLongPress: () {
        showDialog(
          context: context,
          builder: (context) => const _DeviceInfoDialog(),
        );
      },
      child: SizedBox(
        width: 80,
        height: 80,
        child: CustomPaint(
          painter: BannerPainter(
            message: getIt<Environment>().name,
            textDirection: Directionality.of(context),
            layoutDirection: Directionality.of(context),
            location: BannerLocation.bottomStart,
            color: getIt<Environment>().bannerColor,
          ),
        ),
      ),
    );
  }
}

class _DeviceInfoDialog extends StatelessWidget {
  const _DeviceInfoDialog();

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      clipBehavior: Clip.hardEdge,
      content: _getContent(context),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            // TODO(faiz): go to dev page
            // Navigator.of(context).push(
            //   MaterialPageRoute<dynamic>(
            //     builder: (BuildContext context) => const DeveloperPage(),
            //   ),
            // );
          },
          child: const Text(
            "Developer page",
            style: TextStyle(color: Colors.black87),
          ),
        ),
        TextButton(
          onPressed: () {
            // TODO(faiz): go to dev page
            // Navigator.of(context).push(
            //   MaterialPageRoute<dynamic>(
            //     builder: (BuildContext context) => const LogScreen(),
            //   ),
            // );
          },
          child: const Text(
            "Log page",
            style: TextStyle(color: Colors.black87),
          ),
        ),
        TextButton(
          onPressed: () {
            // TODO(faiz): go to chucker
            // Navigator.of(context).push(
            //   MaterialPageRoute<dynamic>(
            //     builder: (BuildContext context) => const ErrorLogScreen(),
            //   ),
            // );
          },
          child: const Text(
            "HTTP requests/responses",
            style: TextStyle(color: Colors.black87),
          ),
        ),
      ],
    );
  }

  Widget _getContent(BuildContext context) {
    final DeviceInfoService deviceInfo = getIt<DeviceInfoService>();
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _TileWidget(
            name: "App version:",
            value: deviceInfo.version,
          ),
          _TileWidget(
            name: "Environment:",
            value: getIt<Environment>().name,
          ),
          _TileWidget(
            name: "Supported API version:",
            value: getIt<Environment>().supportedApiVersion.toString(),
          ),
          // TODO(faiz): add actual api version checker
          _TileWidget(
            name: "Actual API version:",
            value: "",
          ),
          _TileWidget(
            name: "Physical device:",
            value: "${deviceInfo.isPhysicalDevice}",
          ),
          _TileWidget(
            name: "Manufacturer:",
            value: deviceInfo.manufacturer,
          ),
          _TileWidget(
            name: "Model:",
            value: deviceInfo.model,
          ),
          if (Platform.isIOS)
            _TileWidget(
              name: "Device name:",
              value: "${deviceInfo.iosDeviceName}",
            ),

          _TileWidget(
            name: "OS version:",
            value: deviceInfo.osVersion,
          ),
          if (Platform.isAndroid)
            _TileWidget(
              name: "Android SDK:",
              value: "${deviceInfo.androidSdk}",
            ),
          _TileWidget(
            name: "Device ID:",
            value: deviceInfo.deviceId,
          ),
        ],
      ),
    );
  }
}

class _TileWidget extends StatelessWidget {
  const _TileWidget({
    required this.name,
    required this.value,
  });
  final String name;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Row(
        children: <Widget>[
          Text(name),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              value,
            ),
          ),
        ],
      ),
    );
  }
}
