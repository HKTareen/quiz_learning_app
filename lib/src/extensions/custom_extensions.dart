import 'package:flutter/material.dart';

///made me padding extension
extension PaddingExtension on Widget {
  /// Adds padding to the widget.
  Widget withPadding(EdgeInsetsGeometry padding) {
    return Padding(padding: padding, child: this);
  }

  Widget get pad16Horizontal {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: this,
    );
  }

  Widget padHorizontal([double value = 16]) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: value),
      child: this,
    );
  }
}

enum DeviceType { mobile, tab, web }

extension ContextExtension on BuildContext {
  DeviceType get deviceType {
    var width = MediaQuery.of(this).size.width;
    if (width <= 500) {
      return DeviceType.mobile;
    } else if (width > 500 && width <= 1270) {
      return DeviceType.tab;
    } else {
      return DeviceType.web;
    }
  }

  bool get isMobile => deviceType == DeviceType.mobile;

  bool get isTab => deviceType == DeviceType.tab;

  bool get isWeb => deviceType == DeviceType.web;
}
