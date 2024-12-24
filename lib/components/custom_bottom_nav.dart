// import 'package:flutter/material.dart';
// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:bmi_calculator/constants.dart'; // Import the colors
//
// class CustomBottomNav extends StatelessWidget {
//   final int selectedIndex;
//   final Function(int) onTap;
//
//   const CustomBottomNav({
//     required this.selectedIndex,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: CurvedNavigationBar(
//         backgroundColor: kInactiveCardColour, // Background color
//         color: kBottomContainerColour, // Color for selected item
//         animationDuration: Duration(milliseconds: 400), // Animation duration
//         animationCurve: Curves.decelerate, // Curve for animation
//         index: selectedIndex, // Selected index
//         items: const [
//           Icon(
//             Icons.home,
//             color: Colors.white,
//           ),
//           Icon(
//             Icons.favorite,
//             color: Colors.white,
//           ),
//           Icon(
//             Icons.history,
//             color: Colors.white,
//           ),
//         ],
//         onTap: onTap, // Handle onTap event
//       ),
//     );
//   }
// }
//
// import 'package:bmi_calculator/screens/history_page.dart';
// import 'package:bmi_calculator/screens/input_page.dart';
// import 'package:bmi_calculator/screens/results_page.dart';
// import 'package:flutter/material.dart';
// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:bmi_calculator/constants.dart';
//
// class CustomBottomNav extends StatefulWidget {
//   @override
//   _CustomBottomNavState createState() => _CustomBottomNavState();
// }
//
// class _CustomBottomNavState extends State<CustomBottomNav> {
//   int _selectedIndex = 0; // Track selected index
//
//   // Define the list of pages for navigation
//   final List<Widget> _pages = [
//     InputPage(),
//     const ResultPage(
//         bmiResult: '18.5',
//         textResult: 'Unknown',
//         interpretation: 'No data available'),
//     const HistoryPage(),
//   ];
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index; // Update selected index
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _pages[_selectedIndex], // Display the currently selected page
//       bottomNavigationBar: CurvedNavigationBar(
//         backgroundColor: kInactiveCardColour,
//         color: kBottomContainerColour,
//         animationDuration: Duration(milliseconds: 400),
//         animationCurve: Curves.decelerate,
//         index: _selectedIndex,
//         items: const [
//           Icon(Icons.home, color: Colors.white),
//           Icon(Icons.favorite, color: Colors.white),
//           Icon(Icons.history, color: Colors.white),
//         ],
//         onTap: _onItemTapped, // Handle taps to switch pages
//       ),
//     );
//   }
// } kii sax da ahaa ee hore

// import 'package:flutter/material.dart';
// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import '../constants.dart';
// import '../screens/history_page.dart';
// import '../screens/input_page.dart';
// import '../screens/results_page.dart';
//
// class BottomNav extends StatefulWidget {
//   const BottomNav({super.key});
//
//   @override
//   _BottomNavState createState() => _BottomNavState();
// }
//
// class _BottomNavState extends State<BottomNav> {
//   int _selectedIndex = 0;
//
//   // Add the pages to switch between
//   late List<Widget> _pages;
//
//   @override
//   void initState() {
//     super.initState();
//     _pages = [
//       InputPage(), // Input Page (No parameters required here)
//       const ResultPage(
//           bmiResult: '', textResult: 'normal', interpretation: 'Eat more!'),
//       const HistoryPage(), // History Page
//     ];
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: IndexedStack(
//         index: _selectedIndex,
//         children: _pages,
//       ),
//       bottomNavigationBar: CurvedNavigationBar(
//         backgroundColor: kInactiveCardColour,
//         color: kBottomContainerColour,
//         animationDuration: Duration(milliseconds: 400),
//         animationCurve: Curves.decelerate,
//         index: _selectedIndex,
//         items: const [
//           Icon(Icons.home, color: Colors.white),
//           Icon(Icons.favorite, color: Colors.white),
//           Icon(Icons.history, color: Colors.white),
//         ],
//         onTap: (index) {
//           setState(() {
//             _selectedIndex = index;
//           });
//         },
//       ),
//     );
//   }
// }

import 'package:bmi_calculator/screens/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import '../constants.dart';
import '../screens/history_page.dart';
import '../screens/input_page.dart';
import '../screens/results_page.dart';
import '../screens/profile_page.dart';

class CustomBottomNav extends StatefulWidget {
  @override
  CustomBottomNavState createState() => CustomBottomNavState();
}

class CustomBottomNavState extends State<CustomBottomNav> {
  int _selectedIndex = 0; // Track selected index
  String _bmiResult = '';
  String _textResult = '';
  String _interpretation = '';

  // Function to handle calculation callback
  void _onCalculate(
      int index, String bmiResult, String textResult, String interpretation) {
    setState(() {
      _selectedIndex = index;
      _bmiResult = bmiResult;
      _textResult = textResult;
      _interpretation = interpretation;
    });
  }

  // Function to navigate to HistoryPage
  void _goToHistoryPage() {
    setState(() {
      _selectedIndex = 2; // Switch to HistoryPage
    });
  }

  // Function to switch to History tab from another page
  void switchToHistoryTab() {
    if (mounted) {
      setState(() {
        _selectedIndex = 2; // Index of History tab
      });
    }
  }

  // Function to handle bottom nav item taps
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      InputPage(
        onCalculate: _onCalculate,
        onSavePressed: _goToHistoryPage,
      ), // Pass callback to InputPage
      ResultPage(
        bmiResult: _bmiResult,
        textResult: _textResult,
        interpretation: _interpretation,
        onSavePressed: _goToHistoryPage, // Navigate to HistoryPage
      ),
      const HistoryPage(),
      ProfilePage(),
    ];

    return Scaffold(
      body: _pages[_selectedIndex], // Display the currently selected page
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: kInactiveCardColour,
        color: kBottomContainerColour,
        animationDuration: Duration(milliseconds: 400),
        animationCurve: Curves.decelerate,
        index: _selectedIndex,
        items: const [
          Icon(Icons.home, color: Colors.white),
          Icon(Icons.calculate, color: Colors.white),
          Icon(Icons.history, color: Colors.white),
          Icon(Icons.person, color: Colors.white),
        ],
        onTap: _onItemTapped, // Handle taps to switch pages
      ),
    );
  }
}
