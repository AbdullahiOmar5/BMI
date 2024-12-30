import 'package:flutter/material.dart';
import 'package:bmi_calculator/constants.dart';
import '../components/bottom_button.dart';
import '../components/custom_bottom_nav.dart';
import '../components/reusable_card.dart';

class ResultPage extends StatelessWidget {
  final String bmiResult;
  final String textResult;
  final String interpretation;
  final VoidCallback onSavePressed;

  const ResultPage({
    super.key,
    required this.bmiResult,
    required this.textResult,
    required this.interpretation,
    required this.onSavePressed,
  });

  void _saveBMI(BuildContext context) {
    final customBottomNavState =
        context.findAncestorStateOfType<CustomBottomNavState>();
    if (customBottomNavState != null) {
      customBottomNavState.switchToHistoryTab();
    }
  }

  String getBMIRange(String textResult) {
    switch (textResult.toLowerCase()) {
      case 'underweight':
        return 'Underweight Range: Less than 18.5 kg/m²';
      case 'normal':
        return 'Normal Range: 18.5 - 24.9 kg/m²';
      case 'overweight':
        return 'Overweight Range: 25 - 29.9 kg/m²';
      case 'obese':
        return 'Obese Range: 30 or greater kg/m²';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Result'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Center(
              child: Text(
                'Your Result',
                style: kTitleTextStyle,
              ),
            ),
          ),
          Expanded(
            flex: 10,
            child: ReusableCard(
              onPress: () {},
              colour: kActiveCardColour,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    textResult,
                    style: kResultTextStyle,
                  ),
                  Text(
                    bmiResult,
                    style: kBMITextStyle,
                  ),
                  Text(
                    getBMIRange(textResult),
                    style: kResultTextStyle,
                  ),
                  Text(
                    interpretation,
                    style: kBodyTextStyle,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 0),
                ],
              ),
            ),
          ),
          BottomButton(
            onTap: () {
              _saveBMI(context);
            },
            buttonTitle: 'Save',
          ),
        ],
      ),
    );
  }
}
