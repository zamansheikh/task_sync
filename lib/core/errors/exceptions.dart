class ServerException implements Exception {
  final String message;

  ServerException([this.message = 'An unknown server error occurred']);

  @override
  String toString() => message;
}

class CacheException implements Exception {}
