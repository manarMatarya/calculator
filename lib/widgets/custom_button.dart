import 'package:calculator/constants.dart';
import 'package:calculator/widgets/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: colorGrey,
      ),
      child: Center(
        child: Text(
          _getRightSign(index).toString(),
          style: TextStyle(
            color: _getSignColor(index),
            fontSize: _getSize(index),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  String? _getRightSign(int index) {
    return signAndNumbers[index];
  }

  Color _getSignColor(int index) {
    if (index <= 2) return colorGreen;
    if (index == 3 || index == 7 || index == 11 || index == 15 || index == 19) {
      return colorRed;
    }
    return Get.isDarkMode ? Colors.white : Colors.black;
  }

  double _getSize(int index) {
    if (index >= 0 && index <= 3) return 26;
    if (index == 7 || index == 11 || index == 15 || index == 19) {
      return 26;
    }
    return 22;
  }
}
