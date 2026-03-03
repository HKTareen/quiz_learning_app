import 'package:flutter/material.dart';

extension WidgetExtension on Widget {
  Widget get wrapSliver => SliverToBoxAdapter(child: this);
}
