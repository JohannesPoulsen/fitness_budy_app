import 'package:flutter/material.dart';

class ErrorBox extends StatelessWidget {
  const ErrorBox({Key? key, required this.errorName, required this.errorReason}) : super(key: key);

  final String errorName;
  final String errorReason;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Error'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(errorName),
            Text(errorReason),
          ],
        ),
      ),
    );
  }
}

