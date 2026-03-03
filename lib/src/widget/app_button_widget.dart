import 'package:flutter/material.dart';

class AppButtonWidget extends StatefulWidget {
  const AppButtonWidget({
    super.key,
    required this.title,
    required this.onPressed,
    this.isLoading = false,
  });

  final String title;
  final VoidCallback onPressed;
  final bool isLoading;

  @override
  State<AppButtonWidget> createState() => _AppButtonWidgetState();
}

class _AppButtonWidgetState extends State<AppButtonWidget> {
  late bool isLoading;
  void _init([bool rebuild = false]) {
    isLoading = widget.isLoading;
    if (rebuild) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void didUpdateWidget(covariant AppButtonWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _init(true);
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const .fromHeight(56),
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: .circular(120)),
      ),
      onPressed: widget.onPressed,
      child: isLoading
          ? Transform.scale(
              scale: 0.75,
              child: const CircularProgressIndicator(color: Colors.white),
            )
          : Text(widget.title, style: .new(color: Colors.white)),
    );
  }
}
