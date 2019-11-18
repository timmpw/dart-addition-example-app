import 'dart:io';
import 'dart:core';
import 'package:ansicolor/ansicolor.dart';

/**
 * Определение максимального количества символов из двух целых чисел
 */
int _maxLen(aLen, bLen) {
  int maxLen = [aLen, bLen][0];
  [aLen, bLen].skip(1).forEach((b) {
    maxLen = maxLen.compareTo(b) >= 0 ? maxLen : b;
  });
  return maxLen;
}

/**
 * ltrim func
 */
String _ltrim(String str, [String chars]) {
  var pattern = chars != null ? new RegExp('^[$chars]+') : new RegExp(r'^\s+');
  return str.replaceAll(pattern, '');
}

/**
 * Определение необходимого типа операции
 */
calculation(a, b) {
  if (a.isEmpty || b.isEmpty) {
    return a + b;
  }

  if (a.substring(0, 1) == "-" && b.substring(0, 1) == "-") {
    return "-" + makeAddition(a.substring(1), b.substring(1));
  }

  if (a.substring(0, 1) == "-") {
    return makeSubtraction(a.substring(1), b);
  }

  if (b.substring(0, 1) == "-") {
    return makeSubtraction(a, b.substring(1));
  }

  return makeAddition(a, b);
}

/**
 * Расчет операции сложения
 */
makeAddition(a, b) {
  var m = 0;
  var aLen = a.length;
  var bLen = b.length;
  var result = "";

  for (int i = 1; i <= _maxLen(aLen, bLen); i++) {
    var d1, d2, sum;

    (i > aLen) ? d1 = '0' : d1 = a.substring(aLen - i, aLen - (i - 1));
    (i > bLen) ? d2 = '0' : d2 = b.substring(bLen - i, bLen - (i - 1));

    sum = (int.parse(d1) + int.parse(d2) + m).toString();
    result = sum.substring(sum.length - 1) + result;

    sum.length > 1 ? m = 1 : m = 0;
  }

  return m > 0 ? "1" + result : result;
}

/**
 * Расчет операции вычитания
 */
makeSubtraction(f, s) {
  var a = '';
  var b = '';

  if (f.length > s.length) {
    a = f;
    b = s;
  } else if (f.length < s.length) {
    a = s;
    b = f;
  } else {
    var fLen = f.length;
    var sLen = s.length;

    for (int i = 1; i <= _maxLen(fLen, sLen); i++) {
      if (int.parse(f.substring(0, 1)) > int.parse(s.substring(0, 1))) {
        a = f;
        b = s;
        break;
      } else if (int.parse(f.substring(0, 1)) < int.parse(s.substring(0, 1))) {
        a = s;
        b = f;
        break;
      }
      f = f.substring(1);
      s = s.substring(1);
    }
  }

  var m = 0;
  var aLen = a.length;
  var bLen = b.length;
  var result = "";

  for (int i = 1; i <= _maxLen(aLen, bLen); i++) {
    var d1, d2;

    (i > aLen) ? d1 = '0' : d1 = a.substring(aLen - i, aLen - (i - 1));
    (i > bLen) ? d2 = '0' : d2 = b.substring(bLen - i, bLen - (i - 1));
    if (int.parse(d1) < int.parse(d2)) {
      var res = ((10 + int.parse(d1)) - int.parse(d2)) - m;
      result = res.toString() + result;
      m = 1;
    } else {
      var res = (int.parse(d1) - int.parse(d2)) - m;
      result = res.toString() + result;
      m = 0;
    }
  }

  return _ltrim(result, "0");
}

void main() {
  stdout.write("Что нужно сложить: ");
  var first_term = stdin.readLineSync();
  stdout.write("С чем складываем: ");
  var second_term = stdin.readLineSync();
  AnsiPen pen = new AnsiPen()..red();
  stdout
      .write(pen("Результат: " + calculation(first_term, second_term)) + "\n");
}
