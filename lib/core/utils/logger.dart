import "package:flutter/material.dart";
import "package:initial_app/core/config/environment.dart";
import "package:initial_app/core/config/injectable.dart";
import "package:talker_bloc_logger/talker_bloc_logger_settings.dart";
import "package:talker_dio_logger/talker_dio_logger.dart";
import "package:talker_flutter/talker_flutter.dart";

final logger = TalkerFlutter.init(
  observer: getIt<Environment>().isProd ? SentryTalkerObserver() : null,
  settings: TalkerSettings(
    colors: {
      TalkerLogType.info: AnsiPen()..cyan(),
      TalkerLogType.verbose: AnsiPen()..gray(level: 0.4),
      TalkerLogType.critical: AnsiPen()..rgb(r: 1, g: 0.0, b: 0.4),
    },
  ),
);

final talkerDioLogger = TalkerDioLogger(
  talker: logger,
  settings: const TalkerDioLoggerSettings(
    printRequestData: false,
    printResponseData: false,
    printResponseMessage: false,
  ),
);

const talkerBlocSettings = TalkerBlocLoggerSettings(
  printStateFullData: false,
);

Widget talkerScreen(BuildContext context) => Theme(
      data: Theme.of(context).copyWith(
        cardColor: const Color(0xFF212121),
      ),
      child: TalkerScreen(
        appBarTitle: "Logger",
        talker: logger,
      ),
    );

class SentryTalkerObserver extends TalkerObserver {
  SentryTalkerObserver();

  @override
  void onError(err) {
    // TODO(faiz): implement sentry error recording
  }

  @override
  void onLog(log) {
    // TODO(faiz): implement sentry log recording (not required)
  }

  @override
  void onException(err) {
    // TODO(faiz): implement sentry exception recording
  }
}
