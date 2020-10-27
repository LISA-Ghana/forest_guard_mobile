import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forest_guard/services/location_service.dart';

class AppDialogs {
  static void showDialog(
    BuildContext context, {
    String message,
    PolylineProvider provider,
    String title = 'Info',
    TextStyle titleStyle,
    TextStyle messageStyle,
    bool isLoading = true,
    bool isActivity = false,
  }) {
    showCupertinoDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => _AppDialog(
        message: message,
        title: title,
        titleStyle: titleStyle,
        messageStyle: messageStyle,
        isLoading: isLoading,
        isActivity: isActivity,
        provider: provider,
      ),
    );
  }
}

class _AppDialog extends StatelessWidget {
  final String message;
  final String title;
  final TextStyle titleStyle;
  final TextStyle messageStyle;
  final bool isLoading;
  final bool isActivity;
  final PolylineProvider provider;

  _AppDialog({
    this.message,
    this.titleStyle,
    this.title = 'Info',
    this.messageStyle,
    this.isLoading = true,
    this.isActivity = false,
    this.provider,
  });

  @override
  Widget build(BuildContext context) {
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
        if (isActivity)
          CupertinoDialogAction(
            child: Text('Respond'),
            isDestructiveAction: !isActivity,
            onPressed: () {
              if (isActivity) {
                provider.drawPolylines();
              }

              Navigator.pop(context);
            },
          ),
      ],
    );
  }
}
