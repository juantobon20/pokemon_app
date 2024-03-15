import 'package:flutter/material.dart';

import 'container_text_field.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController? controller;
  final double width;
  final TextInputType keyboardType;
  final EdgeInsetsGeometry padding;
  final Icon? icon;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;

  const CustomTextFormField({
    super.key,
    this.labelText = '',
    this.hintText = '',
    this.width = double.infinity,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.padding = const EdgeInsets.all(10),
    this.icon,
    this.errorText,
    this.onChanged,
    this.onFieldSubmitted,
    this.validator
  });

  @override
  Widget build(BuildContext context) {
    var textField = TextFormField(
      controller: controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: labelText,
          hintText: hintText.isEmpty && labelText.isNotEmpty ? labelText : hintText,
          prefixIcon: icon,
          errorText: errorText
        ),
        keyboardType: keyboardType,
        onChanged: onChanged,
        validator: validator,
        onFieldSubmitted: onFieldSubmitted,
    );

    return containerTextFieldBuild(
        padding: padding,
        width: width,
        textField: textField
    );
  }
}