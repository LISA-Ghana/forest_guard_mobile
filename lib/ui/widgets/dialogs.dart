import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppDialogs {
  static void showDialog(
    BuildContext context, {
    String message,
    String title = 'Info',
    TextStyle titleStyle,
    TextStyle messageStyle,
    bool isLoading = true,
  }) {
    showCupertinoDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        final children = <Widget>[];

        if (isLoading) {
          children.add(CupertinoActivityIndicator());
        }

        if (isLoading && message != null) {
          children.add(SizedBox(width: 20));
        }

        if (message != null) {
          children.add(
            Expanded(
              child: Text(
                message,
                style: messageStyle ?? TextStyle(fontSize: 16),
              ),
            ),
          );
        }

        return CupertinoAlertDialog(
          title: Text(title, style: titleStyle),
          content: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            ),
          ),
          actions: [
            CupertinoDialogAction(
              child: Text('Close'),
              isDestructiveAction: true,
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }
}
