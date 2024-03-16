import '../../domain/domain.dart';

class ServiceHelper {
  
  static Future<void> handleServiceCall<T>({
    required Future<T> Function() serviceCall,
    required Function(ErrorData errorData) returnException
  }) async {
    try {
      await serviceCall();
    } on NetworkException {
      returnException(ErrorData(errorType: ErrorType.notConnection));
    } on ApiFailureException catch (e) {
      returnException(
        ErrorData(
          errorType: ErrorType.api,
          errorTitle: 'Error code: ${e.statusCode}',
          errorMessage: e.message
        )
      );
    } on UnknownFailureException {
      returnException(
        ErrorData(
          errorType: ErrorType.otherError,
          errorTitle: 'Error no encontrado',
          errorMessage: 'Ups algo falló por favor intenta mas tarde'
        )
      );
    } on BadRequestException catch (e) {
      returnException(
        ErrorData(
          errorType: ErrorType.otherError,
          errorMessage: e.message,
          errorTitle: e.title
        )
      );
    }
  }
}