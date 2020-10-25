import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String hintText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final TextCapitalization textCapitalization;
  final FocusNode focusNode;
  final EdgeInsetsGeometry margin;
  final VoidCallback onEditingComplete;
  bool enabled;

  InputField({
    this.hintText,
    this.keyboardType,
    @required this.controller,
    this.textInputAction,
    this.focusNode,
    this.enabled = true,
    this.onEditingComplete,
    this.textCapitalization = TextCapitalization.words,
    this.margin = const EdgeInsets.symmetric(horizontal: 25),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.only(left: 20, right: 12),
      margin: margin,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
      ),
      child: TextFormField(
        enabled: enabled,
        controller: controller,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        onEditingComplete: onEditingComplete,
        focusNode: focusNode,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
