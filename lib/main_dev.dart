import "package:flutter/material.dart";
import "package:initial_app/app.dart";
import "package:initial_app/core/config/environment.dart";
import "package:initial_app/core/config/injectable.dart";

void main() {
  configureDependencies(const DevEnvironment());
  runApp(const App());
}
