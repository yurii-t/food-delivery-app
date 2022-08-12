import 'dart:math';

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

abstract class RandomString {
  static String getRandomString() => String.fromCharCodes(Iterable.generate(
        15,
        (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length)),
      ));
}
