import 'package:flutter/material.dart';

enum DeviceType { mobile, tablet, desktop }

extension BuildContextExtension on BuildContext {
  DeviceType get deviceType {
    final width = MediaQuery.of(this).size.width;
    if (width < 600) return DeviceType.mobile;
    if (width < 1200) return DeviceType.tablet;
    return DeviceType.desktop;
  }
}
