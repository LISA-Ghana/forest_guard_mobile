import 'package:flutter/material.dart';

class ResponseButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      label: Text('No New Alert', style: TextStyle(fontSize: 18)),
      onPressed: () {},
    );
  }
}
