import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import '../constants.dart';
import '../screens/results_page.dart';
import '../calculator_brain.dart';
import '../components/reusable_card.dart';
import '../components/icon_content.dart';
import '../components/round_icon_button.dart';
import '../components/bottom_button.dart';

enum Gender {
  male,
  female,
}

class InputPage extends StatefulWidget {
  late final Function(
      int index, String result, String text, String interpretation) onCalculate;
  final VoidCallback onSavePressed;
  InputPage({required this.onCalculate, required this.onSavePressed});

  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Gender? selectedGender;
  int height = 180;
  int weight = 60;
  int age = 20;
  late final VoidCallback onSavePressed;

  // Function to save BMI record to Firestore
  void _calculateBMI() async {
    CalculatorBrain calc = CalculatorBrain(height: height, weight: weight);
    String bmiResult = calc.calculateBMI(height, weight);
    String textResult = calc.getResult();
    String interpretation = calc.getInterpretation();

    // Call the onCalculate function passed from the parent (CustomBottomNav)
    widget.onCalculate(1, bmiResult, textResult,
        interpretation); // Pass to result page index 1

    String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    String time = DateFormat('HH:mm').format(DateTime.now());

    Map<String, dynamic> bmiRecord = {
      'bmi': bmiResult,
      'result': textResult,
      'interpretation': interpretation,
      'height': height,
      'weight': weight,
      'age': age,
      'date': formattedDate,
      'time': time,
    };

    try {
      await saveRecord(bmiRecord);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultPage(
            bmiResult: bmiResult,
            textResult: textResult,
            interpretation: interpretation,
            onSavePressed: onSavePressed, // Pass onSavePressed to ResultPage
            // Pass the callback function
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Error saving BMI record: $e"),
      ));
    }
  }

  Future<void> saveRecord(Map<String, dynamic> record) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        await FirebaseFirestore.instance
            .collection('users') // Root collection
            .doc(user.uid) // Document for the logged-in user
            .collection('bmi_history') // Sub-collection for BMI records
            .add(record);
        print("BMI record saved successfully!");
      } catch (e) {
        print("Error saving BMI record: $e");
      }
    } else {
      print("No user is currently signed in.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BMI Calculator"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Gender Selection
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ReusableCard(
                    onPress: () {
                      setState(() {
                        selectedGender = Gender.male;
                      });
                    },
                    colour: selectedGender == Gender.male
                        ? kActiveCardColour
                        : kInactiveCardColour,
                    cardChild: IconContent(
                      icon: FontAwesomeIcons.mars,
                      label: 'MALE',
                    ),
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    onPress: () {
                      setState(() {
                        selectedGender = Gender.female;
                      });
                    },
                    colour: selectedGender == Gender.female
                        ? kActiveCardColour
                        : kInactiveCardColour,
                    cardChild: IconContent(
                      icon: FontAwesomeIcons.venus,
                      label: 'FEMALE',
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Height Selection
          Expanded(
            child: ReusableCard(
              onPress: () {},
              colour: kActiveCardColour,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'HEIGHT',
                    style: kLabelTextStyle,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: <Widget>[
                      Text(
                        height.toString(),
                        style: kNumberTextStyle,
                      ),
                      Text(
                        'cm',
                        style: kLabelTextStyle,
                      ),
                    ],
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      inactiveTrackColor: Color(0xFF8D8E98),
                      activeTrackColor: Colors.white,
                      thumbColor: Color(0xFFEB1555),
                      overlayColor: Color(0x29EB1555),
                      thumbShape:
                          RoundSliderThumbShape(enabledThumbRadius: 15.0),
                      overlayShape:
                          RoundSliderOverlayShape(overlayRadius: 30.0),
                    ),
                    child: Slider(
                      value: height.toDouble(),
                      min: 120.0,
                      max: 220.0,
                      onChanged: (double newValue) {
                        setState(() {
                          height = newValue.round();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Weight and Age Selection
          Expanded(
            child: Row(
              children: <Widget>[
                // Weight
                Expanded(
                  child: ReusableCard(
                    onPress: () {},
                    colour: kActiveCardColour,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'WEIGHT',
                          style: kLabelTextStyle,
                        ),
                        Text(
                          weight.toString(),
                          style: kNumberTextStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RoundIconButton(
                              icon: FontAwesomeIcons.minus,
                              onPressed: () {
                                setState(() {
                                  weight--;
                                });
                              },
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            RoundIconButton(
                              icon: FontAwesomeIcons.plus,
                              onPressed: () {
                                setState(() {
                                  weight++;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // Age
                Expanded(
                  child: ReusableCard(
                    onPress: () {},
                    colour: kActiveCardColour,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'AGE',
                          style: kLabelTextStyle,
                        ),
                        Text(
                          age.toString(),
                          style: kNumberTextStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RoundIconButton(
                              icon: FontAwesomeIcons.minus,
                              onPressed: () {
                                setState(() {
                                  age--;
                                });
                              },
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            RoundIconButton(
                              icon: FontAwesomeIcons.plus,
                              onPressed: () {
                                setState(() {
                                  age++;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Calculate Button
          BottomButton(
            buttonTitle: 'CALCULATE',
            onTap: _calculateBMI,
          ),
        ],
      ),
    );
  }
}
// ---- halkan ka bilow
//

// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:intl/intl.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import '../constants.dart';
// import '../screens/results_page.dart';
// import '../calculator_brain.dart';
// import '../components/reusable_card.dart';
// import '../components/icon_content.dart';
// import '../components/round_icon_button.dart';
// import '../components/bottom_button.dart';
//
// enum Gender {
//   male,
//   female,
// }
//
// class InputPage extends StatefulWidget {
//   @override
//   _InputPageState createState() => _InputPageState();
// }
//
// class _InputPageState extends State<InputPage> {
//   Gender? selectedGender;
//   int height = 180;
//   int weight = 60;
//   int age = 20;
//   int _currentIndex = 0;
//
//   // Function to calculate BMI and navigate to the results page
//   void _calculateBMI() async {
//     CalculatorBrain calc = CalculatorBrain(height: height, weight: weight);
//     String bmiResult = calc.calculateBMI(height, weight);
//     String textResult = calc.getResult();
//     String interpretation = calc.getInterpretation();
//
//     // Format the current date
//     String formattedDate =
//         DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now());
//     String time = DateFormat('HH:mm').format(DateTime.now());
//
//     // Save the calculated BMI to history, including the 'time' field
//     Map<String, dynamic> bmiRecord = {
//       'bmi': bmiResult,
//       'result': textResult,
//       'interpretation': interpretation,
//       'height': height,
//       'weight': weight,
//       'age': age,
//       'date': formattedDate, // Save formatted date
//       'time': time, // Save formatted time
//     };
//
//     // Save the record to Firestore
//     try {
//       await saveRecord(bmiRecord);
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => ResultPage(
//             bmiResult: bmiResult,
//             textResult: textResult,
//             interpretation: interpretation,
//           ),
//         ),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text("Error saving BMI record: $e"),
//       ));
//     }
//   }
//
//   // Function to save BMI record to Firestore
//   Future<void> saveRecord(Map<String, dynamic> record) async {
//     final user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       try {
//         await FirebaseFirestore.instance
//             .collection('users') // Root collection
//             .doc(user.uid) // Document for the logged-in user
//             .collection('bmi_history') // Sub-collection for BMI records
//             .add(record);
//         print("BMI record saved successfully!");
//       } catch (e) {
//         print("Error saving BMI record: $e");
//       }
//     } else {
//       print("No user is currently signed in.");
//     }
//   }
//
//   void onTapBottomNav(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('BMI CALCULATOR'),
//       ),
//       resizeToAvoidBottomInset:
//           true, // Ensures UI resizes to avoid the keyboard
//       body: SingleChildScrollView(
//         // Wrap the body content in a scroll view
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: <Widget>[
//               // Gender Selection
//               Row(
//                 children: <Widget>[
//                   Expanded(
//                     child: ReusableCard(
//                       onPress: () {
//                         setState(() {
//                           selectedGender = Gender.male;
//                         });
//                       },
//                       colour: selectedGender == Gender.male
//                           ? kActiveCardColour
//                           : kInactiveCardColour,
//                       cardChild: IconContent(
//                         icon: FontAwesomeIcons.mars,
//                         label: 'MALE',
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: ReusableCard(
//                       onPress: () {
//                         setState(() {
//                           selectedGender = Gender.female;
//                         });
//                       },
//                       colour: selectedGender == Gender.female
//                           ? kActiveCardColour
//                           : kInactiveCardColour,
//                       cardChild: IconContent(
//                         icon: FontAwesomeIcons.venus,
//                         label: 'FEMALE',
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               // Height Selection
//               ReusableCard(
//                 onPress: () {},
//                 colour: kActiveCardColour,
//                 cardChild: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     Text(
//                       'HEIGHT',
//                       style: kLabelTextStyle,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.baseline,
//                       textBaseline: TextBaseline.alphabetic,
//                       children: <Widget>[
//                         Text(
//                           height.toString(),
//                           style: kNumberTextStyle,
//                         ),
//                         Text(
//                           'cm',
//                           style: kLabelTextStyle,
//                         ),
//                       ],
//                     ),
//                     SliderTheme(
//                       data: SliderTheme.of(context).copyWith(
//                         inactiveTrackColor: Color(0xFF8D8E98),
//                         activeTrackColor: Colors.white,
//                         thumbColor: Color(0xFFEB1555),
//                         overlayColor: Color(0x29EB1555),
//                         thumbShape:
//                             RoundSliderThumbShape(enabledThumbRadius: 15.0),
//                         overlayShape:
//                             RoundSliderOverlayShape(overlayRadius: 30.0),
//                       ),
//                       child: Slider(
//                         value: height.toDouble(),
//                         min: 120.0,
//                         max: 220.0,
//                         onChanged: (double newValue) {
//                           setState(() {
//                             height = newValue.round();
//                           });
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               // Weight and Age Selection
//               Row(
//                 children: <Widget>[
//                   // Weight
//                   Expanded(
//                     child: ReusableCard(
//                       onPress: () {},
//                       colour: kActiveCardColour,
//                       cardChild: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: <Widget>[
//                           Text(
//                             'WEIGHT',
//                             style: kLabelTextStyle,
//                           ),
//                           Text(
//                             weight.toString(),
//                             style: kNumberTextStyle,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: <Widget>[
//                               RoundIconButton(
//                                 icon: FontAwesomeIcons.minus,
//                                 onPressed: () {
//                                   setState(() {
//                                     weight--;
//                                   });
//                                 },
//                               ),
//                               SizedBox(
//                                 width: 10.0,
//                               ),
//                               RoundIconButton(
//                                 icon: FontAwesomeIcons.plus,
//                                 onPressed: () {
//                                   setState(() {
//                                     weight++;
//                                   });
//                                 },
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   // Age
//                   Expanded(
//                     child: ReusableCard(
//                       onPress: () {},
//                       colour: kActiveCardColour,
//                       cardChild: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: <Widget>[
//                           Text(
//                             'AGE',
//                             style: kLabelTextStyle,
//                           ),
//                           Text(
//                             age.toString(),
//                             style: kNumberTextStyle,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: <Widget>[
//                               RoundIconButton(
//                                 icon: FontAwesomeIcons.minus,
//                                 onPressed: () {
//                                   setState(() {
//                                     age--;
//                                   });
//                                 },
//                               ),
//                               SizedBox(
//                                 width: 10.0,
//                               ),
//                               RoundIconButton(
//                                 icon: FontAwesomeIcons.plus,
//                                 onPressed: () {
//                                   setState(() {
//                                     age++;
//                                   });
//                                 },
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               // Calculate Button
//               BottomButton(
//                 buttonTitle: 'CALCULATE',
//                 onTap: _calculateBMI,
//               ),
//             ],
//           ),
//         ),
//       ),
//       // Bottom Navigation Bar
//       // Uncomment and configure bottom navigation as needed
//       // bottomNavigationBar: BottomNavigationBar(
//       //   currentIndex: _currentIndex,
//       //   onTap: onTapBottomNav,
//       //   items: [
//       //     BottomNavigationBarItem(
//       //       icon: Icon(Icons.home),
//       //       label: 'Home',
//       //     ),
//       //     BottomNavigationBarItem(
//       //       icon: Icon(Icons.history),
//       //       label: 'History',
//       //     ),
//       //     BottomNavigationBarItem(
//       //       icon: Icon(Icons.settings),
//       //       label: 'Settings',
//       //     ),
//       //   ],
//       // ),
//     );
//   }
// }
