import 'package:flutter/material.dart';
import 'package:bmi_calculator/constants.dart';
import 'package:bmi_calculator/components/bottom_button.dart'; // Import reusable button
import 'login_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  int currentPage = 0;

  final List<Map<String, String>> skipScreens = [
    {
      "text": "Welcome to BMI Calculator! Learn about your health.",
      "image": "assets/skip1.png",
    },
    {
      "text": "BMI helps you understand your body weight and health.",
      "image": "assets/skip2.png",
    },
    {
      "text": "Start calculating your BMI now with ease!",
      "image": "assets/skip3.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kActiveCardColour,
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: PageView.builder(
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                });
              },
              itemCount: skipScreens.length,
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Ensures content is centered
                  children: [
                    Image.asset(
                      skipScreens[index]["image"]!,
                      height: 250, // Consistent image height
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 20), // Add spacing between image and text
                    Text(
                      skipScreens[index]["text"]!,
                      style: TextStyle(
                        color: kLabelColour,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                );
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                // Add skip dots
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    skipScreens.length,
                    (index) => buildDot(index),
                  ),
                ),
                SizedBox(height: 20), // Add space between dots and Skip button

                // Show Skip button on the first two screens
                if (currentPage != skipScreens.length - 1)
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    },
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        color: kBottomContainerColour,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                Spacer(), // Spacer to push the Get Started button to the bottom
                // Show "Get Started" only on the last page
                if (currentPage == skipScreens.length - 1)
                  BottomButton(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                      );
                    },
                    buttonTitle: 'Get Started',
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDot(int index) {
    return Container(
      margin: EdgeInsets.only(right: 8),
      height: 10,
      width: currentPage == index ? 12 : 8,
      decoration: BoxDecoration(
        color: currentPage == index ? kBottomContainerColour : kLabelColour,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
