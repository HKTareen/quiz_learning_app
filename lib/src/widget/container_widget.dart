import 'dart:math';

import 'package:flutter/material.dart';

class ContainerWidget extends StatefulWidget {
  const ContainerWidget({
    super.key,
    required this.child,
    this.ratio = 2.5,
    this.padding = const EdgeInsets.all(20),
  });

  final Widget child;
  final double ratio;
  final EdgeInsets padding;

  @override
  State<ContainerWidget> createState() => _ContainerWidgetState();
}

class _ContainerWidgetState extends State<ContainerWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: min(680, .infinity),
        decoration: BoxDecoration(
          borderRadius: .circular(16),
          border: .all(color: Colors.black, width: 2),
        ),
        padding: widget.padding,
        child: widget.child,
      ),
    );
  }
}
