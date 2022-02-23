import 'package:digital_card_app/common/util/util.dart';

extension RegexValidator on String {

  bool isEmail() => matchesPattern(this, RegexPatterns.email);

    static bool matchesPattern(String? source, String pattern) {
      return source == null ? false : RegExp(pattern).hasMatch(source);
  }
}