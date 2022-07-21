import 'package:get/get.dart';

class CalculatorController extends GetxController {
  var input = ''.obs;
  var result = '0'.obs;
  double _firstNum = 0;
  double _secondNum = 0;
  String operator = '';
  final List<String> userInput = [];

  void digitValidator(String digit) {
    if (digit != "AC" &&
        digit != "=" &&
        digit != "CRL" &&
        digit != "+/-" &&
        digit != "%") {
      _getUserInput(digit);
    }
    if (digit == "%") {
      _percent();
    }

    if (digit == "+/-") {
      _plusOrMinus();
    }

    if (digit == "CRL") {
      _clearLastInput();
    }

    if (digit == "C") {
      _clearInput();
    }
    if (digit == "=") {
      _operation();
    }
  }

  void _getUserInput(String digit) {
    if (result.value != '0' && digit == '+' ||
        result.value != '0' && digit == '/' ||
        result.value != '0' && digit == 'x' ||
        result.value != '0' && digit == '-') {
      if (result.value.contains('-')) {
        final newV = double.parse(result.value.split('-')[1]);
        _clearInput();
        userInput.insert(0, '-');
        userInput.insert(1, newV.toString());
        _makeNumber();
      }
    }

    if (userInput.contains('+') ||
        userInput.contains('/') ||
        userInput.contains('x')) {
      if (digit == '+' || digit == '/' || digit == 'x' || digit == '-') {
        return;
      } else {
        userInput.add(digit);
        _makeNumber();
      }
    } else if (digit == '.' && userInput.isEmpty) {
      return;
    } else {
      userInput.add(digit);
      _makeNumber();
    }
  }

  void _clearInput() {
    userInput.clear();
    result.value = '0';
    _makeNumber();
  }

  void _clearLastInput() {
    if (userInput.isNotEmpty) {
      userInput.removeAt(userInput.length - 1);
    }
    if (userInput.isEmpty) {
      result.value = '0';
    }
    _makeNumber();
  }

  void _makeNumber() {
    input.value = '';
    for (var num in userInput) {
      input.value += num;
    }
  }

  void _getOperator() {
    if (userInput[0] != '-') {
      if (input.contains('-')) operator = '-';
    } else if (userInput[0] == '-') {
      for (int i = 1; i < userInput.length; i++) {
        if (userInput[i].contains('-')) operator = '-';
      }
    }
    if (input.contains('+')) operator = '+';
    if (input.contains('/')) operator = '/';
    if (input.contains('x')) operator = 'x';
  }

  void _splitInput() {
    _getOperator();
    try {
      if (operator == '-' && userInput[0] == '-') {
        _firstNum = -double.parse(input.split(operator)[1]);
        _secondNum = -double.parse(input.split(operator)[2]);
      } else if (operator != '-' && userInput[0] == '-') {
        _firstNum = double.parse(input.split(operator)[0]);
        _secondNum = double.parse(input.split(operator)[1]);
      } else if (userInput[0] != '-') {
        _firstNum = double.parse(input.split(operator)[0]);
        _secondNum = double.parse(input.split(operator)[1]);
      }
    } catch (e) {
      print('DEBUG: Error trying to split $e');
    }
  }

  void _percent() {
    if (result.value != '0') {
      final double oldResult = double.parse(result.value);
      _clearInput();
      _getUserInput(oldResult.toString());
      result.value = (oldResult / 100).toString();
    } else {
      _firstNum = double.parse(input.value);
      result.value = (_firstNum / 100).toString();
    }
  }

  void _plusOrMinus() {
    if (!userInput.contains('-')) {
      userInput.insert(0, '-');
    } else {
      if (userInput[0] == '-') {
        userInput.removeAt(0);
      }
    }
    _makeNumber();
  }

  void _operation() {
    _splitInput();

    if (result.value != '0') {
      final String newNum = result.value;
      _clearInput();
      _getUserInput(newNum);
    }

    if (input.contains('+')) {
      try {
        result.value = (_firstNum + _secondNum).toString();
      } catch (e) {
        print('DEBUG: Calculation error $e');
      }
    }

    if (input.contains('-') && userInput[0] != '-') {
      try {
        result.value = (_firstNum - _secondNum).toString();
      } catch (e) {
        print('DEBUG: $e');
      }
    }
    if (operator == '-' && userInput[0] == '-') {
      try {
        result.value = (_firstNum + _secondNum).toString();
      } catch (e) {
        print('DEBUG: $e');
      }
    }
    if (input.contains('/')) {
      try {
        if (_secondNum > 0) {
          result.value = (_firstNum / _secondNum).toStringAsFixed(1);
        } else {
          print('DEBUG: second number is less than zero $_secondNum');
        }
      } catch (e) {
        print('DEBUG: Calculation error $e');
      }
    }
    if (input.contains('x')) {
      try {
        result.value = (_firstNum * _secondNum).toString();
      } catch (e) {
        print('DEBUG: Calculation error $e');
      }
    }
  }
}
