// ignore_for_file: avoid_equals_and_hash_code_on_mutable_classes

import "package:flutter/material.dart";
import "package:initial_app/core/config/env_slug.dart";
import "package:injectable/injectable.dart" hide Environment;
import "package:pub_semver/pub_semver.dart";

sealed class Environment {
  final String name;

  String get androidAppURL;
  String get apiURL;
  String get iOSAppURL;
  Version get supportedApiVersion;
  bool get isProd;

  /// Each environment specifies its own flavor banner color
  Color get bannerColor;

  const Environment({required this.name});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Environment && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}

@Injectable(as: Environment, env: [EnvSlug.dev])
class DevEnvironment extends Environment {
  const DevEnvironment() : super(name: EnvSlug.dev);

  @override
  String get androidAppURL => "";

  @override
  String get apiURL => "";

  @override
  String get iOSAppURL => "";

  @override
  Version get supportedApiVersion => Version.none;

  @override
  bool get isProd => false;

  @override
  Color get bannerColor => Colors.green;
}

@Injectable(as: Environment, env: [EnvSlug.stage])
class StageEnvironment extends Environment {
  const StageEnvironment() : super(name: EnvSlug.stage);

  @override
  String get androidAppURL => "";

  @override
  String get apiURL => "";

  @override
  String get iOSAppURL => "";

  @override
  Version get supportedApiVersion => Version.none;

  @override
  bool get isProd => false;

  @override
  Color get bannerColor => Colors.amber;
}

@Injectable(as: Environment, env: [EnvSlug.prod])
class ProdEnvironment extends Environment {
  const ProdEnvironment() : super(name: EnvSlug.prod);

  @override
  String get androidAppURL => "";

  @override
  String get apiURL => "";

  @override
  String get iOSAppURL => "";

  @override
  Version get supportedApiVersion => Version.none;

  @override
  bool get isProd => true;

  @override
  Color get bannerColor => Colors.transparent;
}
