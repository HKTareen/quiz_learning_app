import 'package:flutter/material.dart';

extension DoubleExtension on num {
  Widget get height => SizedBox(height: toDouble());

  Widget get width => SizedBox(width: toDouble());

  Widget get box => SizedBox(height: toDouble(), width: toDouble());
}
