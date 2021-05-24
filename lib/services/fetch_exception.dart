class FetchDataException implements Exception {
  String message;
  FetchDataException(this.message);

  @override
  String toString() {
    // T0DO: implement toString
    return "Exception: $message";
  }
}
