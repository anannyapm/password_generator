import 'dart:math';
import 'dart:developer' as dev;
import 'package:flutter/material.dart';

class PasswordController extends ChangeNotifier {
  TextEditingController passwordTextController = TextEditingController();

  double sliderValue = 8;

  int selectedIndex = 0;

  List<bool> checkbox = List.filled(4, true);

  String lowerCaseLetters = 'abcdefghijklmnopqrstuvwxyz';
  String upperCaseLetters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  String numbers = '0123456789';
  String specialCharacters = '!@#*()_-=+{]}|:?;/>.,<';

  List<String> combinationMakers = [
    'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
    'abcdefghijklmnopqrstuvwxyz',
    '0123456789',
    '!@#*()_-=+{]}|:?;/>.,<'
  ];

  String password = "";

  setSlider(double value) {
    sliderValue = value;
    notifyListeners();
  }

  setOption(bool value) {
    checkbox[selectedIndex] = value;
    notifyListeners();
  }

  bool checkIfGeneratable() {
    dev.log(checkbox.toString());

    int enabledLength = checkbox.where((element) => element == true).length;
    dev.log(enabledLength.toString());

    if (sliderValue < enabledLength) {
      return false;
    }

    return true;
  }

  void generatePassword() {
    final random = Random.secure();
    password = combinationMakers
        .where(
            (element) => checkbox[combinationMakers.indexOf(element)] == true)
        .join();
    List<String> combination = [];
    for (int index = 0; index < combinationMakers.length; index++) {
      if (checkbox[index] == true) {
        combination.add(combinationMakers[index]
            [random.nextInt(combinationMakers[index].length)]);
      }
    }
    combination.shuffle(Random());
    dev.log(combination.toString());
    passwordTextController.text = combination.join() +
        List.generate(sliderValue.toInt() - combination.length,
            (index) => password[random.nextInt(password.length)]).join();
  }
}
