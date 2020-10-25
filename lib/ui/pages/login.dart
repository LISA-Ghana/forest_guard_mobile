import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forest_guard/ui/pages/homepage.dart';
import 'package:forest_guard/ui/widgets/input_field.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final agentIdController = TextEditingController();
  final forestIdController = TextEditingController();

  final forestFocus = FocusNode();

  bool isLoading = false;

  Future<void> performLogin() async {
    FocusScope.of(context).unfocus();

    setState(() {
      isLoading = !isLoading;
    });

    await Future.delayed(Duration(seconds: 2));

    Navigator.of(context).push(
      CupertinoPageRoute(builder: (_) => Homepage()),
    );
  }

  @override
  void dispose() {
    agentIdController.dispose();
    forestIdController.dispose();
    forestFocus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 250),
            Text(
              'Forest Guard',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  BoxShadow(
                    offset: Offset(2, 2),
                    color: Colors.black54,
                    spreadRadius: 4,
                    blurRadius: 2,
                  ),
                ],
              ),
            ),
            Spacer(),
            InputField(
              enabled: !isLoading,
              controller: agentIdController,
              hintText: 'Agent ID',
              margin: const EdgeInsets.symmetric(horizontal: 100, vertical: 16),
              textInputAction: TextInputAction.next,
              onEditingComplete: () => forestFocus.requestFocus(),
            ),
            InputField(
              enabled: !isLoading,
              focusNode: forestFocus,
              controller: forestIdController,
              hintText: 'Forest ID',
              keyboardType: TextInputType.number,
              margin: const EdgeInsets.symmetric(horizontal: 100, vertical: 16),
              textInputAction: TextInputAction.go,
              onEditingComplete: () async => performLogin(),
            ),
            SizedBox(height: 50),
            FloatingActionButton(
              backgroundColor: Colors.green[50],
              child: isLoading
                  ? CircularProgressIndicator()
                  : Icon(Icons.arrow_forward, color: Colors.black),
              onPressed: () async => performLogin(),
            ),
            Spacer(),
            Text(
              'Developed by Team Lisa\nAI4Good',
              style: TextStyle(color: Colors.white, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
