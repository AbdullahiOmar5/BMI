import 'package:flutter/material.dart';
import 'package:bmi_calculator/constants.dart';

class BottomButton extends StatelessWidget {
  BottomButton({required this.onTap, required this.buttonTitle});

  final Function onTap;
  final String buttonTitle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap as void Function(),
      child: Container(
        alignment: Alignment
            .center, // Ensures the content inside is perfectly centered
        child: Text(
          buttonTitle,
          style: kLargeButtonTextStyle,
        ),
        color: kBottomContainerColour,
        margin: EdgeInsets.only(bottom: 10.0),
        padding: EdgeInsets.all(10.0),
        width: double.infinity,
        height: kBottomContainerHeight,
      ),
    );
  }
}