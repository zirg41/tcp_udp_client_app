import "dart:io";

import "package:android_id/android_id.dart";
import "package:device_info_plus/device_info_plus.dart";
import "package:injectable/injectable.dart";
import "package:package_info_plus/package_info_plus.dart";

@singleton
class DeviceInfoService {
  String get deviceId => _deviceId;
  String get manufacturer => _manufacturer;
  String get model => _model;
  String get os => _os;
  String get osVersion => _osVersion;
  String? get iosDeviceName => _iosDeviceName;
  String get version => _version;
  int? get androidSdk => _androidSdk ?? 0;
  bool get isPhysicalDevice => _isPhysicalDevice;

  late String _deviceId;
  late String _manufacturer;
  late String _model;
  late String _os;
  late String _osVersion;
  late String _version;
  late String? _iosDeviceName;
  late int? _androidSdk;
  late bool _isPhysicalDevice;

  DeviceInfoService();

  @PostConstruct()
  Future<void> initialize() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();

    if (Platform.isAndroid) {
      final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      _deviceId = await const AndroidId().getId() ?? "Unknown id";
      _manufacturer = androidInfo.manufacturer;
      _model = androidInfo.model;
      _os = androidInfo.version.baseOS ?? "OS not defined";
      _osVersion = androidInfo.version.release;
      _androidSdk = androidInfo.version.sdkInt;
      _isPhysicalDevice = androidInfo.isPhysicalDevice;
    }

    if (Platform.isIOS) {
      final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      _deviceId = iosInfo.identifierForVendor ?? "iOS ID not defined";
      _iosDeviceName = iosInfo.name;
      _manufacturer = "Apple";
      _model = iosInfo.model;
      _os = iosInfo.systemName + iosInfo.systemVersion;
      _osVersion = iosInfo.systemVersion;
      _isPhysicalDevice = iosInfo.isPhysicalDevice;
    }

    _version = "${packageInfo.version} (${packageInfo.buildNumber})";
  }
}
