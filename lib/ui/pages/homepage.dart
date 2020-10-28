import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forest_guard/services/location_service.dart';
import 'package:forest_guard/services/notification_service.dart';
import 'package:forest_guard/ui/widgets/floating_home_options.dart';
import 'package:forest_guard/ui/widgets/map_widget.dart';
import 'package:forest_guard/ui/widgets/response_button.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();

    NotificationService.instance.configureFCM(
      context,
      Provider.of<PolylineProvider>(context, listen: false),
    );
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
            left: 100,
            right: 100,
            child: ResponseButton(),
          ),
          Selector<PolylineProvider, bool>(
            selector: (_, provider) => provider.isLoading,
            builder: (_, isLoading, __) {
              if (isLoading) {
                return Align(
                  alignment: Alignment.center,
                  child: Container(
                    color: Colors.black.withOpacity(0.4),
                    child: CupertinoAlertDialog(
                      content: Center(child: CircularProgressIndicator()),
                    ),
                  ),
                );
              } else {
                return Offstage();
              }
            },
          ),
        ],
      ),
    );
  }
}
