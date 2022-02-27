class Util {
  Util._(); // Utility class not meant to be instantiated

  static String checkLength(String email) {
    final int length = email.length;
    if (length > 70) {
      return email.substring(0, 70) + '...';
    } else {
      return email;
    }
  }
}

enum NavigationDir {
  next,
  previous,
}
