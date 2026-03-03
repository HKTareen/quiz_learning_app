import 'package:flutter/material.dart';

import 'app_color.dart';

class AppTheme {
  static final theme = ThemeData(
    scaffoldBackgroundColor: AppColor.whiteColor,
    useMaterial3: true,
    appBarTheme: AppBarThemeData(
      centerTitle: false,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 20,
        color: AppColor.blackColor,
      ),
      backgroundColor: AppColor.whiteColor,
      surfaceTintColor: AppColor.whiteColor,
    ),
  );
}
