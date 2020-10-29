import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forest_guard/services/auth_service.dart';
import 'package:forest_guard/services/location_service.dart';
import 'package:forest_guard/ui/pages/homepage.dart';
import 'package:forest_guard/ui/widgets/dialogs.dart';
import 'package:forest_guard/ui/widgets/input_field.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final agentIdController = TextEditingController();
  final forestIdController = TextEditingController();

  final forestFocus = FocusNode();

  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  Future<void> performLogin() async {
    FocusScope.of(context).unfocus();

    _formKey.currentState.save();

    if (_formKey.currentState.validate()) {
      setState(() {
        isLoading = !isLoading;
      });

      final user = await AuthService.instance.login(
        agentIdController.text.trim(),
        forestIdController.text.trim(),
      );

      if (user != null) {
        Navigator.of(context).pushAndRemoveUntil(
          CupertinoPageRoute(
            builder: (_) => ChangeNotifierProvider(
              create: (_) => PolylineProvider(),
              child: Homepage(),
            ),
          ),
          (route) => false,
        );
      } else {
        setState(() {
          isLoading = !isLoading;
        });

        AppDialogs.showDialog(
          context,
          isLoading: false,
          title: 'Error',
          titleStyle: TextStyle(color: Colors.red),
          message:
              'No agent record found for ID: ${agentIdController.text.trim()}',
        );
      }
    }
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
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Spacer(),
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
                margin:
                    const EdgeInsets.symmetric(horizontal: 100, vertical: 16),
                textInputAction: TextInputAction.next,
                onEditingComplete: () => forestFocus.requestFocus(),
                validator: (value) {
                  if (value.trim().isEmpty) {
                    return 'Please enter your Agent ID';
                  } else if (value.trim().length != 4) {
                    return 'Agent ID should be 4 characters long';
                  }

                  return null;
                },
              ),
              InputField(
                enabled: !isLoading,
                focusNode: forestFocus,
                controller: forestIdController,
                hintText: 'Forest ID',
                keyboardType: TextInputType.number,
                margin:
                    const EdgeInsets.symmetric(horizontal: 100, vertical: 16),
                textInputAction: TextInputAction.go,
                onEditingComplete: () async => performLogin(),
                validator: (value) {
                  if (value.trim().isEmpty) {
                    return 'Forest ID cannot be empty';
                  }

                  return null;
                },
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
      ),
    );
  }
}
