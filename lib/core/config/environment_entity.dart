// ignore_for_file: avoid_equals_and_hash_code_on_mutable_classes

import "package:flutter/material.dart";
import "package:initial_app/core/config/env_slug.dart";
import "package:injectable/injectable.dart" hide Environment;
import "package:pub_semver/pub_semver.dart";

part "environments.dart";

sealed class Environment {
  final String name;

  String get androidAppURL;
  String get apiURL;
  String get iOSAppURL;
  Version get supportedApiVersion;
  bool get isProd => name == EnvSlug.prod;
  bool get isStage => name == EnvSlug.stage;
  bool get isDev => name == EnvSlug.dev;

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
