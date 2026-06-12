import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  const Failure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class EmptyResultFailure extends Failure {
  const EmptyResultFailure(super.message);
}

class LocalStorageFailure extends Failure {
  const LocalStorageFailure(super.message);
}

class UnknownFailure extends Failure {
  const UnknownFailure(super.message);
}
