# MKomov Studio Flutter example project

Initial Flutter app configured for 3 environments: development, staging, production.

Use this app as initial for new projects.

## Getting Started

### 1. Configure appName

**iOS:** set appName for each environment (Xcode: Runner/Targets/Runner/Build Settings/APP_DISPLAY_NAME)

to open Xcode use:

```sh
open ios/Runner.xcworkspace
```

**Android:** android/app/build.gradle (defaultConfig/applicationId + namespace)

### 2. Configure iOS bundle identifier

Change bundle identifier for each environments

Xcode: Runner-Targets-Runner-Build Settings-Packaging-Product Bundle Identifier

### 3. Configure Android applicationId

Change bundle identifier for each environments

android/app/src/main/kotlin/com/example/new_app/MainActivity.kt

### Configure appIcons

### Configure Android signing config for the release build (android/app/build.gradle)
