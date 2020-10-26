import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forest_guard/services/auth_service.dart';
import 'package:forest_guard/ui/pages/login.dart';
import 'package:forest_guard/ui/widgets/response_log_tile.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Response Log'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await AuthService.instance.signOut();

              Navigator.of(context).pushAndRemoveUntil(
                CupertinoPageRoute(builder: (_) => LoginPage()),
                (route) => false,
              );
            },
          )
        ],
      ),
      backgroundColor: Colors.green[100],
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => ResponseLogTile(),
      ),
    );
  }
}
