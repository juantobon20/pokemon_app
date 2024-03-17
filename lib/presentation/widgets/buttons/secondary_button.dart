import 'package:flutter/material.dart';

import 'container_button.dart';
import 'label_button.dart';

class SecondaryButton extends StatelessWidget {
  final bool isLoading;
  final String text;
  final Icon? icon;
  final VoidCallback onPressedCallback;
  final double width;
  final double height;
  final EdgeInsetsGeometry padding;
  final double radius;

  const SecondaryButton({
    super.key,
    this.isLoading = false,
    this.icon,
    required this.text,
    required this.onPressedCallback,
    this.width = double.infinity,
    this.height = 50,
    this.padding = const EdgeInsets.all(10),
    this.radius = 10
  });

  @override
  Widget build(BuildContext context) {
    OutlinedButton button;
    var labelBtn = labelButtonBuild(text: text, isLoading: isLoading);

    if (icon != null) {
      button = OutlinedButton.icon(
          onPressed: onPressed(isLoading, onPressedCallback),
          icon: icon!,
          style: setStyle(radius),
          label: labelBtn
      );
    } else {
      button = OutlinedButton(
          onPressed: onPressed(isLoading, onPressedCallback),
          style: setStyle(radius),
          child: labelBtn
      );
    }

    return containerButtonBuild(
      context: context, 
      width: width, 
      height: height, 
      padding: padding, 
      child: button
    );
  }

  ButtonStyle setStyle(double radius) => FilledButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius))
  );
}
