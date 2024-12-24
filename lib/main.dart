// import 'package:bmi_calculator/screens/history_page.dart';
// import 'package:bmi_calculator/screens/input_page.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'screens/welcome_page.dart';
// import 'components/custom_bottom_nav.dart'; // Import the custom bottom nav file
//
// void main() async {
//   WidgetsFlutterBinding
//       .ensureInitialized(); // Ensure widget binding is initialized
//   await Firebase.initializeApp(); // Initialize Firebase
//
//   runApp(BMICalculator());
// }
//
// List<Map<String, String>> bmiHistory = [];
//
// class MainScreen extends StatefulWidget {
//   const MainScreen({Key? key}) : super(key: key);
//
//   @override
//   _MainScreenState createState() => _MainScreenState();
// }
//
// class _MainScreenState extends State<MainScreen> {
//   int _selectedIndex = 0;
//
//   // Define the pages for navigation
//   final List<Widget> _pages = [
//     InputPage(), // InputPage for the home
//     const HistoryPage(), // HistoryPage for the second item
//   ];
//
//   // Update the selected index on BottomNavigationBar tap
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _pages[_selectedIndex], // Show the selected page
//       bottomNavigationBar: CustomBottomNav(
//         // Use the custom BottomNavigationBar
//         selectedIndex: _selectedIndex, // Pass selectedIndex to CustomBottomNav
//         onTap: _onItemTapped, // Handle onTap event
//       ),
//     );
//   }
// }
//
// class BMICalculator extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData.dark().copyWith(
//         primaryColor: Color(0xFF0A0E21),
//         scaffoldBackgroundColor: Color(0xFF0A0E21),
//       ),
//       home: const WelcomePage(),
//     );
//   }
// }
import 'package:bmi_calculator/screens/login_page.dart';
import 'package:bmi_calculator/screens/profile_page.dart';
import 'package:bmi_calculator/screens/results_page.dart';
import 'package:bmi_calculator/screens/update_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'components/custom_bottom_nav.dart';
import 'screens/welcome_page.dart';
import 'screens/history_page.dart';
import 'screens/input_page.dart'; // Import the pages you want to use
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'constants.dart'; // Import your colors

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(BMICalculator());
}

List<Map<String, String>> bmiHistory = [];

class BMICalculator extends StatefulWidget {
  @override
  _BMICalculatorState createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF0A0E21),
        scaffoldBackgroundColor: Color(0xFF0A0E21),
      ),
      home: const WelcomePage(),
    );
  }
}
