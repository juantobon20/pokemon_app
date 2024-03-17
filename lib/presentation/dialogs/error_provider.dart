import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pokemon_app/presentation/widgets/widget.dart';

import '../../domain/domain.dart';

class ErrorProvider {

  final BuildContext context;
  final ErrorData errorData;
  final Function onRetryPressed;

  ErrorProvider({
    required this.context,
    required this.errorData,
    required this.onRetryPressed
  }) {
    switch (errorData.errorType) {
      case ErrorType.notConnection: 
        _showNoConnectionSheetDialog(context, onRetryPressed);
      case ErrorType.api:
        _showAlertDialog(
          context, 
          errorData.errorTitle, 
          errorData.errorMessage
        );
      case ErrorType.otherError:
        _showAlertDialog(
          context, 
          errorData.errorTitle, 
          errorData.errorMessage
        );
    }
  }
}


void _showNoConnectionSheetDialog(BuildContext context, Function onRetryPressed) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    showModalBottomSheet(
      context: context, 
      isScrollControlled: true,
      isDismissible: false,
      builder: (BuildContext _)  {
        return _NoInternetConnectionWidget(onRetryPressed: onRetryPressed);
      }
    );
  });
}

class _NoInternetConnectionWidget extends StatelessWidget {

  final Function _onRetryPressed;
  const _NoInternetConnectionWidget({
    required Function onRetryPressed
  }): _onRetryPressed = onRetryPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Lottie.asset('assets/lottie/no_internet.json'),
          ),
      
          PrimaryButton(
            text: 'Reintentar',
            onPressedCallback: () {
              Navigator.pop(context);
              _onRetryPressed();
            },
          )
        ]
      ),
    );
  }
}

void _showAlertDialog(
  BuildContext context, 
  String title, 
  String message
) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    showDialog(context: context, builder:(context) => 
      AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
            }, 
            child: const Text('Aceptar'))
        ],
      )
    );
  });
}