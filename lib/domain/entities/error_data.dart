class ErrorData {

  final ErrorType errorType;
  final String errorTitle;
  final String errorMessage;

  ErrorData(
    { 
      required this.errorType,
      this.errorTitle = '',
      this.errorMessage = ''
    }
  );
}

enum ErrorType {
  notConnection,
  api,
  otherError,
  loginError
}