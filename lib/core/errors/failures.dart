import 'package:equatable/equatable.dart';

// Base abstract class for all failures
abstract class Failure extends Equatable {
  final String message;
  final int? statusCode;

  const Failure({required this.message, this.statusCode});

  @override
  List<Object?> get props => [message, statusCode];
}

// Specific failure types
class ServerFailure extends Failure {
  const ServerFailure({required String message, int? statusCode})
    : super(message: message, statusCode: statusCode);
}

class NetworkFailure extends Failure {
  const NetworkFailure({String message = 'No internet connection'})
    : super(message: message);
}
