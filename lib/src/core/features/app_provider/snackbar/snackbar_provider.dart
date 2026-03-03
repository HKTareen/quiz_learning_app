import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'snackbar_provider.g.dart';

class SnackBarUtils {
  final scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  void showSnackbar(
    String content, [
    final duration = const Duration(seconds: 4),
  ]) {
    scaffoldKey.currentState?.clearSnackBars();
    scaffoldKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(content),
        duration: duration,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 0.0,
      ),
    );
  }
}

@Riverpod(keepAlive: true)
SnackBarUtils snackBar(Ref _) => SnackBarUtils();
