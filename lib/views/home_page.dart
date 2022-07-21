import 'package:calculator/controllers/calculator_controller.dart';
import 'package:calculator/widgets/body_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/theme.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final CalculatorController _controller = Get.put(CalculatorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          width: Get.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Obx(() {
                      final userInput = _controller.input.value;
                      final result = _controller.result.value;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(userInput, style: kTextStyle(30)),
                          Text(result, style: kTextStyle(50)),
                        ],
                      );
                    }),
                  ],
                ),
              ),
              BodyContainer(),
            ],
          ),
        ),
      ),
    );
  }
}
