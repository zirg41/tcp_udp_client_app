import "dart:async";

import "package:flutter/material.dart";
import "package:tcp_udp_client_app/app.dart";
import "package:tcp_udp_client_app/core/config/environment.dart";
import "package:tcp_udp_client_app/core/config/injectable.dart";
import "package:tcp_udp_client_app/core/utils/logger.dart";

void main() {
  runZonedGuarded(
    () {
      configureDependencies(const DevEnvironment());

      runApp(const App());
    },
    (error, stack) {
      logger.critical("[main zone] $error\n$stack");
    },
  );
}
