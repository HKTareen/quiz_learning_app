import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../base/modals/modals.dart';
import 'awaiter.dart';

class DefaultAwaiterBehaviour extends AwaiterBehaviour<String> {
  const DefaultAwaiterBehaviour();

  @override
  void after(BuildContext context) => Navigator.of(context).pop();

  @override
  Future<FutureOr<void>> before(BuildContext context, String arguments) async {
    LoadingDialog(arguments: arguments).show(context);
  }
}
