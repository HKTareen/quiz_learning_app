part of '../modals.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key, required this.arguments});

  final String arguments;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      content: Row(children: [
        Transform.scale(scale: 0.65, child: const LoadingWidget()),
        Text(
          arguments,
          style: const TextStyle(
            color: Color(0xFF152B47),
            fontSize: 16,
          ),
        ),
      ]),
    );
  }

  void show(BuildContext context) {
    showCupertinoDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => this,
    );
  }
}
