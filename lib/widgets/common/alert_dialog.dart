import 'package:flutter/material.dart';

void customAlertBox({
  required BuildContext context,
  required String title,
  required String content,
  required void Function()? onPressedYes,
}) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: onPressedYes,
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('No'),
            ),
          ],
        );
      });
}
