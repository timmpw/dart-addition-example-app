import 'dart:io';
import 'dart:core';
import 'package:ansicolor/ansicolor.dart';

int _maxLen(aLen, bLen) {
  int maxLen = [aLen, bLen][0];
  [aLen, bLen].skip(1).forEach((b) {
    maxLen = maxLen.compareTo(b) >= 0 ? maxLen : b;
  });
  return maxLen;
}

MakeAddition(a, b) {
  if (a.isEmpty || b.isEmpty) {
    return a + b;
  }

  var shift = 0;
  var aLen = a.length;
  var bLen = b.length;
  var result = "";

  for (int i = 1; i <= _maxLen(aLen, bLen); i++) {
    var d1, d2, sum;

    (i > aLen) ? d1 = '0' : d1 = a.substring(aLen - i, aLen - (i - 1));
    (i > bLen) ? d2 = '0' : d2 = b.substring(bLen - i, bLen - (i - 1));

    sum = (int.parse(d1) + int.parse(d2) + shift).toString();
    result = sum.substring(sum.length - 1) + result;

    sum.length > 1 ? shift = 1 : shift = 0;
  }

  return shift > 0 ? "1" + result : result;
}

void main() {
  stdout.write("Что нужно сложить: ");
  var first_term = stdin.readLineSync();
  stdout.write("С чем складываем: ");
  var second_term = stdin.readLineSync();
  AnsiPen pen = new AnsiPen()..red();
  stdout
      .write(pen("Результат: " + MakeAddition(first_term, second_term)) + "\n");
}
