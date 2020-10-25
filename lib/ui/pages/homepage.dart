import 'package:flutter/material.dart';
import 'package:forest_guard/ui/widgets/floating_home_options.dart';
import 'package:forest_guard/ui/widgets/response_button.dart';

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Placeholder(
            color: Colors.green,
            fallbackHeight: MediaQuery.of(context).size.height,
            fallbackWidth: MediaQuery.of(context).size.width,
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: FloatingHomeOptions(),
          ),
          Positioned(
            bottom: 16,
            left: 50,
            right: 50,
            child: ResponseButton(),
          ),
        ],
      ),
    );
  }
}
