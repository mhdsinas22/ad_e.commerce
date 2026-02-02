class Failure {
  final String message;
  const Failure([this.message = 'An unexpected error occurred']);
}

class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Server Failure']);
}
