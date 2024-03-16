import 'package:flutter/material.dart';

void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context, 
    builder:(context) => const LoadingDialog(),
  );
}

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
              blurRadius: 7,
              offset: const Offset(1, 3), // Cambia el offset si deseas
          ),
        ],
      ),
      height: 60,
      width: 60,
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: CircularProgressIndicator(
          strokeWidth: 3,
        ),
      ),
    );
  }
}