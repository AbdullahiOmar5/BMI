// import 'package:flutter/material.dart';
// import 'package:bmi_calculator/constants.dart';
// import '../components/bottom_button.dart';
// import '../components/reusable_card.dart';
// import 'history_page.dart';
// import 'package:bmi_calculator/main.dart';
//
// class ResultPage extends StatelessWidget {
//   const ResultPage({
//     super.key,
//     required this.bmiResult,
//     required this.textResult,
//     required this.interpretation,
//     required int height,
//     required int weight,
//     required int age,
//     required void Function(int newHeight, int newWeight, int newAge) onCardTap,
//   });
//
//   final String bmiResult;
//   final String textResult;
//   final String interpretation;
//
//   void _saveBMI() {
//     // Save the result to the shared list
//     bmiHistory.add({
//       'bmi': bmiResult,
//       'result': textResult,
//       'interpretation': interpretation,
//       'date': DateTime.now().toString().split(' ')[0], // Save current date
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text(
//           'BMI Calculator',
//           style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.normal),
//         ),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           Expanded(
//             child: Container(
//               child: Text(
//                 'Your Result',
//                 style: kTitleTextStyle,
//               ),
//             ),
//           ),
//           Expanded(
//             flex: 5,
//             child: ReusableCard(
//               colour: kActiveCardColour,
//               cardChild: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Text(
//                     textResult,
//                     style: kResultTextStyle,
//                   ),
//                   Text(
//                     bmiResult,
//                     style: kBMITextStyle,
//                   ),
//                   Text(
//                     interpretation,
//                     style: kBodyTextStyle,
//                     textAlign: TextAlign.center,
//                   ),
//                 ],
//               ),
//               onPress: () {},
//             ),
//           ),
//           BottomButton(
//             onTap: () {
//               _saveBMI();
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => const HistoryPage()),
//               );
//             },
//             buttonTitle: 'Save',
//           ),
//           // BottomButton(
//           //   onTap: () {
//           //     Navigator.pop(context);
//           //   },
//           //   buttonTitle: 'Re-Calculate',
//           // ),
//         ],
//       ),
//     );
//   }
// }

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
        return 'Range: Not available';
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

// import 'package:flutter/material.dart';
// import 'package:bmi_calculator/constants.dart';
// import '../components/bottom_button.dart';
// import '../components/custom_bottom_nav.dart';
// import '../components/reusable_card.dart';
//
// class ResultPage extends StatelessWidget {
//   final String bmiResult;
//   final String textResult;
//   final String interpretation;
//   final VoidCallback onSavePressed; // Callback to navigate to history
//
//   const ResultPage({
//     super.key,
//     required this.bmiResult,
//     required this.textResult,
//     required this.interpretation,
//     required this.onSavePressed,
//   });
//   void _saveBMI(BuildContext context) {
//     // Access the CustomBottomNav's state and update its index
//     final customBottomNavState =
//         context.findAncestorStateOfType<CustomBottomNavState>();
//     if (customBottomNavState != null) {
//       customBottomNavState.switchToHistoryTab(); // Switch to History tab
//       // Navigator.pushReplacement(
//       //   context,
//       //   MaterialPageRoute(builder: (context) => CustomBottomNav()),
//       // );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('BMI Result'),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           Expanded(
//             child: Center(
//               child: Text(
//                 'Your Result',
//                 style: kTitleTextStyle,
//               ),
//             ),
//           ),
//           Expanded(
//             flex: 10,
//             child: ReusableCard(
//               onPress: () {},
//               colour: kActiveCardColour,
//               cardChild: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Text(
//                     textResult,
//                     style: kResultTextStyle,
//                   ),
//                   Text(
//                     bmiResult,
//                     style: kBMITextStyle,
//                   ),
//                   Text(
//                     interpretation,
//                     style: kBodyTextStyle,
//                     textAlign: TextAlign.center,
//                   ),
//                   const SizedBox(height: 0),
//                 ],
//               ),
//             ),
//           ),
//           BottomButton(
//             onTap: () {
//               _saveBMI(context);
//             },
//             buttonTitle: 'Save',
//           ),
//         ],
//       ),
//     );
//   }
// }
