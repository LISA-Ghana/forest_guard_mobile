import 'package:flutter/material.dart';
import 'package:forest_guard/services/notification_service.dart';
import 'package:forest_guard/ui/widgets/floating_home_options.dart';
import 'package:forest_guard/ui/widgets/map_widget.dart';
import 'package:forest_guard/ui/widgets/response_button.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();

    NotificationService.instance.configureFCM(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MapWidget(),
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
