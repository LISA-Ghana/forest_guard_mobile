import 'package:flutter/material.dart';

class FloatingHomeOptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
        padding: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.all(Radius.circular(4)),
          boxShadow: [
            BoxShadow(
              offset: Offset(1, 1),
              color: Colors.grey[300],
              spreadRadius: 4,
              blurRadius: 4,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              color: Colors.white,
              iconSize: 36,
              icon: Icon(Icons.notifications),
              onPressed: () {},
            ),
            IconButton(
              color: Colors.white,
              iconSize: 36,
              icon: Icon(Icons.account_circle),
              onPressed: () {},
            ),
            IconButton(
              color: Colors.white,
              iconSize: 36,
              icon: Icon(Icons.chat_bubble),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
