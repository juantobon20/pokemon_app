import 'package:flutter/material.dart';

import 'container_text_field.dart';

class PasswordTextFormField extends StatefulWidget {
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

  const PasswordTextFormField({
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
  State<PasswordTextFormField> createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {

  bool _isHidden = true;

  @override
  Widget build(BuildContext context) {
    var textField = TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: widget.labelText,
          hintText: widget.hintText.isEmpty && widget.labelText.isNotEmpty ? widget.labelText : widget.hintText,
          suffix: InkWell(
            onTap: _togglePasswordView,
            child: Icon(_isHidden ? Icons.visibility : Icons.visibility_off)
          ),
          prefixIcon: widget.icon,
          errorText: widget.errorText
      ),
      keyboardType: widget.keyboardType,
      obscureText: _isHidden,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onFieldSubmitted,
      validator: widget.validator,
    );

    return containerTextFieldBuild(
        padding: widget.padding,
        width: widget.width,
        textField: textField
    );
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}