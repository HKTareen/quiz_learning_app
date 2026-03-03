part of '../modals.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({super.key, required this.error, this.showHeading = true});

  final dynamic error;
  final bool showHeading;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showHeading)
            Text(
              (error is DialogError) ? error.title : 'Error',
              style: const TextStyle(
                fontFamily: 'quicksand',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              (error is DialogError) ? error.description : error.toString(),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: Navigator.of(context).pop,
              child: const Text(
                'Ok',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void show(BuildContext context) {
    showCupertinoDialog(context: context, builder: (_) => this);
  }
}
