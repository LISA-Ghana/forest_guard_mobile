import 'package:flutter/material.dart';
import 'package:forest_guard/ui/widgets/response_log_tile.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Response Log'),
        centerTitle: true,
      ),
      backgroundColor: Colors.green[100],
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => ResponseLogTile(),
      ),
    );
  }
}
