import 'package:calculator/constants.dart';
import 'package:calculator/widgets/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/calculator_controller.dart';
import 'custom_button.dart';

class BodyContainer extends StatelessWidget {
  BodyContainer({Key? key}) : super(key: key);

  final CalculatorController _controller = Get.find<CalculatorController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.62,
      width: Get.size.width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
        color: Colors.white,
      ),
      child: _keyboard(),
    );
  }

  Widget _keyboard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: signAndNumbers.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (ctx, index) {
          return InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              _controller.digitValidator(signAndNumbers[index].toString());
            },
            child: CustomButton(index: index),
          );
        },
      ),
    );
  }
}
