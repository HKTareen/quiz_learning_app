part of '../modals.dart';

class SnackBarUtils {
  SnackBarUtils._();

  static final _instance = SnackBarUtils._();

  static SnackBarUtils get instance => _instance;

  static final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  static GlobalKey<ScaffoldMessengerState> get scaffoldKey =>
      _scaffoldMessengerKey;

  Future<void> showSnackBar(String title) async {
    _scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(content: Text(title)),
    );
  }
}
