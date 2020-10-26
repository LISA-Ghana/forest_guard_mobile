import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:forest_guard/services/auth_service.dart';
import 'package:forest_guard/ui/pages/homepage.dart';
import 'package:forest_guard/ui/pages/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Forest Guard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Builder(
        builder: (_) {
          final user = AuthService.instance.currentUser;

          if (user == null) {
            return LoginPage();
          } else {
            return Homepage();
          }
        },
      ),
    );
  }
}
