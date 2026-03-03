import 'package:dio/dio.dart';

class DialogError implements Exception {
  late String title;
  late String description;

  DialogError({required this.description, required this.title});

  DialogError.withDioError(dynamic error) {
    title = 'Error';
    description = '';
    if (error is DioException) {
      if ((error.message?.contains('SocketException') ?? true) ||
          (error.message?.contains('Connecting timed') ?? true)) {
        description = 'Internet Connection Error';
      } else if ((error.message?.contains('type cast') ?? true) ||
          (error.message?.contains('type') ?? true)) {
        description = 'Something Went Wrong';
      } else {
        description = error.message ?? '';
      }
    } else {
      description = error.toString();
    }
  }
}
