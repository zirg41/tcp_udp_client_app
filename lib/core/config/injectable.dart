import "package:get_it/get_it.dart";
import "package:initial_app/core/config/environment.dart";
import "package:initial_app/core/config/injectable.config.dart";
import "package:injectable/injectable.dart" hide Environment;

final getIt = GetIt.instance;

@injectableInit
Future<void> configureDependencies(Environment environment) async {
  getIt.init(environment: environment.name);
}
