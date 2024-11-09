import "package:flutter_bloc/flutter_bloc.dart";
import "package:get_it/get_it.dart";
import "package:injectable/injectable.dart" hide Environment;
import "package:talker_bloc_logger/talker_bloc_logger.dart";
import "package:tcp_udp_client_app/core/config/environment.dart";
import "package:tcp_udp_client_app/core/config/injectable.config.dart";
import "package:tcp_udp_client_app/core/utils/logger.dart";

final getIt = GetIt.instance;

@injectableInit
Future<void> configureDependencies(Environment environment) async {
  getIt.init(environment: environment.name);

  Bloc.observer = TalkerBlocObserver(
    settings: talkerBlocSettings,
    talker: logger,
  );
}
