import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart' show BuildContext;
import 'package:forest_guard/services/location_service.dart';
import 'package:forest_guard/ui/widgets/dialogs.dart';

class NotificationService {
  NotificationService._internal();
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;

  static NotificationService get instance => _instance;

  final _fcm = FirebaseMessaging();

  Future<void> subscribeToTopic() async {
    await _fcm.subscribeToTopic('activities');
    print('Subscribed to topic: activities');
  }

  Future<void> configureFCM(
      BuildContext context, PolylineProvider provider) async {
    await subscribeToTopic();

    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        AppDialogs.showDialog(
          context,
          isLoading: false,
          isActivity: true,
          provider: provider,
          title: message['notification']['title'] ?? message['data']['title'],
          message: message['notification']['body'] ?? message['data']['body'],
        );
      },
      onLaunch: (Map<String, dynamic> message) async {
        // Callback fired when app is closed but still in the background.
        AppDialogs.showDialog(
          context,
          isLoading: false,
          isActivity: true,
          provider: provider,
          title: message['notification']['title'] ?? message['data']['title'],
          message: message['notification']['body'] ?? message['data']['body'],
        );
      },
      onResume: (Map<String, dynamic> message) async {
        // Callback fired when app is fully terminated.
        AppDialogs.showDialog(
          context,
          isLoading: false,
          isActivity: true,
          provider: provider,
          title: message['notification']['title'] ?? message['data']['title'],
          message: message['notification']['body'] ?? message['data']['body'],
        );
      },
    );
  }
}
