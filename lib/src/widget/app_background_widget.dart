import 'package:flutter/material.dart';

class AppBackgroundWidget extends StatefulWidget {
  const AppBackgroundWidget({super.key, required this.body});

  final Widget body;

  @override
  State<AppBackgroundWidget> createState() => _AppBackgroundWidgetState();
}

class _AppBackgroundWidgetState extends State<AppBackgroundWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue, Colors.blue.withValues(alpha: .5)],
        ),
      ),
      width: size.width,
      height: size.height,
      child: widget.body,
    );
  }
}
