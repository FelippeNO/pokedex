class CoreException implements Exception {
  final String msg;
  const CoreException(this.msg);
  @override
  String toString() => 'Exception: $msg';

  void printException() {
    // ignore: avoid_print
    print(msg.toString());
  }
}
