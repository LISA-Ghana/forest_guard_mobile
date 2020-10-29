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

  void _showDialog(BuildContext context, Map<String, dynamic> message,
      PolylineProvider provider) {
    AppDialogs.showDialog(
      context,
      isLoading: false,
      isActivity: true,
      provider: provider,
      title: message['notification']['title'] ?? message['data']['title'],
      message: message['notification']['body'] ?? message['data']['body'],
    );
  }

  Future<void> configureFCM(
      BuildContext context, PolylineProvider provider) async {
    await subscribeToTopic();

    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async =>
          _showDialog(context, message, provider),
      onLaunch: (Map<String, dynamic> message) async =>
          _showDialog(context, message, provider),
      onResume: (Map<String, dynamic> message) async =>
          _showDialog(context, message, provider),
    );
  }
}
