// // import 'package:bmi_calculator/screens/input_page.dart';
// // import 'package:flutter/material.dart';
// // import 'package:bmi_calculator/constants.dart';
// //
// // import '../main.dart';
// //
// // class HistoryPage extends StatelessWidget {
// //   const HistoryPage({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('History & Stats'),
// //         backgroundColor: kActiveCardColour,
// //       ),
// //       body: Container(
// //         decoration: BoxDecoration(
// //           gradient: LinearGradient(
// //             colors: [kActiveCardColour, kInactiveCardColour],
// //             begin: Alignment.topLeft,
// //             end: Alignment.bottomRight,
// //           ),
// //         ),
// //         padding: const EdgeInsets.all(20.0),
// //         child: bmiHistory.isEmpty
// //             ? Center(
// //                 child: Text(
// //                   'No BMI Records Saved Yet.',
// //                   style: TextStyle(
// //                     fontSize: 24,
// //                     color: kLabelColour,
// //                   ),
// //                 ),
// //               )
// //             : ListView.builder(
// //                 itemCount: bmiHistory.length,
// //                 itemBuilder: (context, index) {
// //                   final record = bmiHistory[index];
// //                   double bmi = double.parse(record['bmi']!);
// //                   double progress =
// //                       (bmi - 18.5) / (24.9 - 18.5); // Normalize between 0 and 1
// //
// //                   return Padding(
// //                     padding: const EdgeInsets.symmetric(vertical: 10.0),
// //                     child: Card(
// //                       color: kInactiveCardColour,
// //                       elevation: 5,
// //                       shape: RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.circular(15),
// //                       ),
// //                       child: ListTile(
// //                         contentPadding: EdgeInsets.all(15),
// //                         leading: Icon(
// //                           Icons.access_time,
// //                           color: kResultColour,
// //                           size: 30,
// //                         ),
// //                         title: Text(
// //                           'BMI: ${record['bmi']}',
// //                           style: TextStyle(
// //                             color: kLabelColour,
// //                             fontSize: 22,
// //                             fontWeight: FontWeight.bold,
// //                           ),
// //                         ),
// //                         subtitle: Column(
// //                           crossAxisAlignment: CrossAxisAlignment.start,
// //                           children: [
// //                             Text(
// //                               'Result: ${record['result']}',
// //                               style: TextStyle(
// //                                 color: kLabelColour,
// //                                 fontSize: 16,
// //                               ),
// //                             ),
// //                             Text(
// //                               'Date: ${record['date']}',
// //                               style: TextStyle(
// //                                 color: kLabelColour,
// //                                 fontSize: 16,
// //                               ),
// //                             ),
// //                             SizedBox(height: 5),
// //                             LinearProgressIndicator(
// //                               value: progress, // BMI progress status
// //                               backgroundColor: kInactiveCardColour,
// //                               valueColor:
// //                                   AlwaysStoppedAnimation<Color>(kResultColour),
// //                             ),
// //                           ],
// //                         ),
// //                         trailing: Icon(
// //                           Icons.trending_up,
// //                           color: kResultColour,
// //                         ),
// //                       ),
// //                     ),
// //                   );
// //                 },
// //               ),
// //       ),
// //       floatingActionButton: FloatingActionButton(
// //         onPressed: () {
// //           Navigator.push(
// //               context,
// //               MaterialPageRoute(
// //                   builder: (context) =>
// //                       InputPage())); // Navigate back to Input Page
// //         },
// //         backgroundColor: kBottomContainerColour,
// //         child: Icon(Icons.add, color: Colors.white),
// //       ),
// //     );
// //   }
// // }
//
// import 'package:flutter/material.dart';
// import 'package:bmi_calculator/constants.dart';
// import '../main.dart';
// import 'input_page.dart';
//
// class HistoryPage extends StatelessWidget {
//   const HistoryPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('History & Stats'),
//         backgroundColor: kActiveCardColour,
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [kActiveCardColour, kInactiveCardColour],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         padding: const EdgeInsets.all(20.0),
//         child: bmiHistory.isEmpty
//             ? const Center(
//                 child: Text(
//                   'No BMI Records Saved Yet.',
//                   style: TextStyle(
//                     fontSize: 24,
//                     color: kLabelColour,
//                   ),
//                 ),
//               )
//             // : ListView.builder(
//             //
//             //     itemCount: bmiHistory.length,
//             //     itemBuilder: (context, index) {
//             //       final record = bmiHistory[index];
//             //       final double bmi = double.parse(record['bmi']!);
//             //       final String category = record['result']!;
//             //       final String date = record['date']!;
//             //       final String time = record['time']!;
//             //
//             //       return Padding(
//             //         padding: const EdgeInsets.symmetric(vertical: 10.0),
//             //         child: Card(
//             //           color: kInactiveCardColour,
//             //           elevation: 5,
//             //           shape: RoundedRectangleBorder(
//             //             borderRadius: BorderRadius.circular(15),
//             //           ),
//             //           child: ListTile(
//             //             contentPadding: const EdgeInsets.all(15),
//             //             leading: Icon(
//             //               Icons.access_time,
//             //               color: kResultColour,
//             //               size: 30,
//             //             ),
//             //             title: Column(
//             //               crossAxisAlignment: CrossAxisAlignment.start,
//             //               children: [
//             //                 // BMI Result with Icon
//             //                 Row(
//             //                   children: [
//             //                     Icon(
//             //                       Icons.trending_up,
//             //                       color: kResultColour,
//             //                     ),
//             //                     const SizedBox(width: 8),
//             //                     Text(
//             //                       'BMI: $bmi',
//             //                       style: const TextStyle(
//             //                         color: kLabelColour,
//             //                         fontSize: 20,
//             //                         fontWeight: FontWeight.bold,
//             //                       ),
//             //                     ),
//             //                   ],
//             //                 ),
//             //                 Text(
//             //                   'Category: $category',
//             //                   style: const TextStyle(
//             //                     color: kLabelColour,
//             //                     fontSize: 16,
//             //                   ),
//             //                 ),
//             //                 const SizedBox(height: 10),
//             //                 // Date and Time with Icons
//             //                 Row(
//             //                   children: [
//             //                     Icon(
//             //                       Icons.calendar_today,
//             //                       color: kResultColour,
//             //                       size: 20,
//             //                     ),
//             //                     const SizedBox(width: 8),
//             //                     Text(
//             //                       'Date: $date',
//             //                       style: const TextStyle(
//             //                         color: kLabelColour,
//             //                         fontSize: 16,
//             //                       ),
//             //                     ),
//             //                   ],
//             //                 ),
//             //                 Row(
//             //                   children: [
//             //                     Icon(
//             //                       Icons.access_time,
//             //                       color: kResultColour,
//             //                       size: 20,
//             //                     ),
//             //                     const SizedBox(width: 8),
//             //                     Text(
//             //                       'Time: $time',
//             //                       style: const TextStyle(
//             //                         color: kLabelColour,
//             //                         fontSize: 16,
//             //                       ),
//             //                     ),
//             //                   ],
//             //                 ),
//             //               ],
//             //             ),
//             //           ),
//             //         ),
//             //       );
//             //     },
//             //   ),
//             : ListView.builder(
//                 itemCount: bmiHistory.length,
//                 itemBuilder: (context, index) {
//                   final record = bmiHistory[index];
//                   final double bmi = double.parse(record['bmi'] ?? '0');
//                   final String category = record['result'] ?? 'Unknown';
//                   final String date = record['date'] ?? 'No date recorded';
//                   final String time = record['time'] ?? 'No time recorded';
//
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 10.0),
//                     child: Card(
//                       color: kInactiveCardColour,
//                       elevation: 5,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                       child: ListTile(
//                         contentPadding: const EdgeInsets.all(15),
//                         leading: Icon(
//                           Icons.access_time,
//                           color: kResultColour,
//                           size: 30,
//                         ),
//                         title: Row(
//                           mainAxisAlignment:
//                               MainAxisAlignment.spaceBetween, // Space between
//                           children: [
//                             // Left side: BMI Result and Category
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   children: [
//                                     Icon(
//                                       Icons.trending_up,
//                                       color: kResultColour,
//                                     ),
//                                     const SizedBox(width: 8),
//                                     Text(
//                                       'BMI: $bmi',
//                                       style: const TextStyle(
//                                         color: kLabelColour,
//                                         fontSize: 20,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Text(
//                                   'Category: $category',
//                                   style: const TextStyle(
//                                     color: kLabelColour,
//                                     fontSize: 16,
//                                   ),
//                                 ),
//                               ],
//                             ),
//
//                             // Right side: Date and Time
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.end,
//                               children: [
//                                 // Date with Icon
//                                 Row(
//                                   children: [
//                                     Icon(
//                                       Icons.calendar_today,
//                                       color: kResultColour,
//                                       size: 20,
//                                     ),
//                                     const SizedBox(width: 8),
//                                     Text(
//                                       date,
//                                       style: const TextStyle(
//                                         color: kLabelColour,
//                                         fontSize: 16,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 // Time with Icon
//                                 Row(
//                                   children: [
//                                     Icon(
//                                       Icons.access_time,
//                                       color: kResultColour,
//                                       size: 20,
//                                     ),
//                                     const SizedBox(width: 8),
//                                     Text(
//                                       time,
//                                       style: const TextStyle(
//                                         color: kLabelColour,
//                                         fontSize: 16,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => InputPage()),
//           );
//         },
//         backgroundColor: kBottomContainerColour,
//         child: const Icon(Icons.add, color: Colors.white),
//       ),
//     );
//   }
// }
//

// import 'package:bmi_calculator/screens/input_page.dart';
// import 'package:flutter/material.dart';
// import 'package:bmi_calculator/constants.dart';
//
// import '../main.dart';
//
// class HistoryPage extends StatelessWidget {
//   const HistoryPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('History & Stats'),
//         backgroundColor: kActiveCardColour,
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [kActiveCardColour, kInactiveCardColour],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         padding: const EdgeInsets.all(20.0),
//         child: bmiHistory.isEmpty
//             ? const Center(
//                 child: Text(
//                   'No BMI Records Saved Yet.',
//                   style: TextStyle(
//                     fontSize: 24,
//                     color: kLabelColour,
//                   ),
//                 ),
//               )
//             : ListView.builder(
//                 itemCount: bmiHistory.length,
//                 itemBuilder: (context, index) {
//                   final record = bmiHistory[index];
//                   final double bmi = double.parse(record['bmi'] ?? '0');
//                   final String category = record['result'] ?? 'Unknown';
//                   final String date = record['date'] ?? 'No date recorded';
//                   final String time = record['time'] ?? 'No time recorded';
//                   print('Record: $record');
//                   double progress =
//                       (bmi - 18.5) / (24.9 - 18.5); // Normalize between 0 and 1
//
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 10.0),
//                     child: Card(
//                       color: kInactiveCardColour,
//                       elevation: 5,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                       child: ListTile(
//                         contentPadding: const EdgeInsets.all(15),
//                         title: Row(
//                           children: [
//                             // Left side: BMI Result and Category
//                             Expanded(
//                               flex: 2, // Allow this side to take more space
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Row(
//                                     children: [
//                                       Icon(
//                                         Icons.trending_up,
//                                         color: kResultColour,
//                                       ),
//                                       const SizedBox(width: 8),
//                                       Text(
//                                         '$bmi',
//                                         style: const TextStyle(
//                                           color: kLabelColour,
//                                           fontSize: 20,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   Row(
//                                     children: [
//                                       Icon(
//                                         Icons.category,
//                                         color: kResultColour,
//                                       ),
//                                       const SizedBox(width: 8),
//                                       Text(
//                                         category,
//                                         style: const TextStyle(
//                                           color: kLabelColour,
//                                           fontSize: 16,
//                                         ),
//                                       ),
//                                     ],
//                                   )
//                                 ],
//                               ),
//                             ),
//
//                             // Right side: Date and Time
//                             Expanded(
//                               flex: 2, // Right side takes remaining space
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.end,
//                                 children: [
//                                   // Date with Icon
//                                   Row(
//                                     children: [
//                                       Icon(
//                                         Icons.calendar_today,
//                                         color: kResultColour,
//                                         size: 20,
//                                       ),
//                                       const SizedBox(width: 8),
//                                       Text(
//                                         date,
//                                         style: const TextStyle(
//                                           color: kLabelColour,
//                                           fontSize: 16,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   // Time with Icon
//                                   Row(
//                                     children: [
//                                       Icon(
//                                         Icons.access_time,
//                                         color: kResultColour,
//                                         size: 20,
//                                       ),
//                                       const SizedBox(width: 8),
//                                       Text(
//                                         time,
//                                         style: const TextStyle(
//                                           color: kLabelColour,
//                                           fontSize: 16,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                         subtitle: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const SizedBox(height: 5),
//                             LinearProgressIndicator(
//                               value: progress, // BMI progress status
//                               backgroundColor: kInactiveCardColour,
//                               valueColor:
//                                   AlwaysStoppedAnimation<Color>(kResultColour),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) =>
//                     InputPage()), // Navigate back to Input Page
//           );
//         },
//         backgroundColor: kBottomContainerColour,
//         child: const Icon(Icons.add, color: Colors.white),
//       ),
//     );
//   }
// }
//
//
// import 'package:bmi_calculator/constants.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import '../main.dart';
// import 'input_page.dart';
//
// class HistoryPage extends StatefulWidget {
//   const HistoryPage({super.key});
//
//   @override
//   _HistoryPageState createState() => _HistoryPageState();
// }
//
// class _HistoryPageState extends State<HistoryPage> {
//   List<Map<String, dynamic>> _bmiHistory = []; // To store fetched BMI history
//   bool _showAllResults = false; // State to control whether to show all results
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchUserBMIHistory(); // Fetch BMI history when the page loads
//   }
//
//   // Fetch BMI history data from Firestore
//   void _fetchUserBMIHistory() async {
//     final user = FirebaseAuth.instance.currentUser;
//
//     if (user != null) {
//       try {
//         QuerySnapshot snapshot = await FirebaseFirestore.instance
//             .collection('users') // Users collection
//             .doc(user.uid) // Get the user's document by UID
//             .collection('bmi_history') // BMI history sub-collection
//             .orderBy('date', descending: true)
//             .orderBy('time', descending: true)
//             .get();
//
//         List<Map<String, dynamic>> bmiHistory = snapshot.docs.map((doc) {
//           return doc.data() as Map<String, dynamic>;
//         }).toList();
//
//         setState(() {
//           _bmiHistory = bmiHistory;
//         });
//       } catch (e) {
//         print("Error fetching BMI history: $e");
//       }
//     } else {
//       print("No user is logged in.");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final int itemCount = _showAllResults
//         ? _bmiHistory.length
//         : (_bmiHistory.length > 5 ? 5 : _bmiHistory.length);
//
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [kActiveCardColour, kInactiveCardColour],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         padding: const EdgeInsets.all(20.0),
//         child: _bmiHistory.isEmpty
//             ? const Center()
//             : Column(
//                 children: [
//                   Expanded(
//                     child: ListView.builder(
//                       itemCount: itemCount,
//                       itemBuilder: (context, index) {
//                         final record = _bmiHistory[index];
//                         final double bmi = double.parse(record['bmi'] ?? '0');
//                         final String category = record['result'] ?? 'Unknown';
//                         final String date =
//                             record['date'] ?? 'No date recorded';
//                         final String time =
//                             record['time'] ?? 'No time recorded';
//                         double progress =
//                             (bmi - 18.5) / (24.9 - 18.5); // Normalize BMI
//
//                         return Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 10.0),
//                           child: Card(
//                             color: kInactiveCardColour,
//                             elevation: 5,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(15),
//                             ),
//                             child: ListTile(
//                               contentPadding: const EdgeInsets.all(15),
//                               title: Row(
//                                 children: [
//                                   Expanded(
//                                     flex: 2,
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Row(
//                                           children: [
//                                             Icon(
//                                               Icons.trending_up,
//                                               color: kResultColour,
//                                             ),
//                                             const SizedBox(width: 8),
//                                             Text(
//                                               '$bmi',
//                                               style: const TextStyle(
//                                                 color: kLabelColour,
//                                                 fontSize: 20,
//                                                 fontWeight: FontWeight.bold,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                         Row(
//                                           children: [
//                                             Icon(
//                                               Icons.category,
//                                               color: kResultColour,
//                                             ),
//                                             const SizedBox(width: 8),
//                                             Text(
//                                               category,
//                                               style: const TextStyle(
//                                                 color: kLabelColour,
//                                                 fontSize: 16,
//                                               ),
//                                             ),
//                                           ],
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                   Expanded(
//                                     flex: 2,
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.end,
//                                       children: [
//                                         Row(
//                                           children: [
//                                             Icon(
//                                               Icons.calendar_today,
//                                               color: kResultColour,
//                                               size: 20,
//                                             ),
//                                             const SizedBox(width: 8),
//                                             Text(
//                                               date,
//                                               style: const TextStyle(
//                                                 color: kLabelColour,
//                                                 fontSize: 16,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                         Row(
//                                           children: [
//                                             Icon(
//                                               Icons.access_time,
//                                               color: kResultColour,
//                                               size: 20,
//                                             ),
//                                             const SizedBox(width: 8),
//                                             Text(
//                                               time,
//                                               style: const TextStyle(
//                                                 color: kLabelColour,
//                                                 fontSize: 16,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               subtitle: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   const SizedBox(height: 5),
//                                   LinearProgressIndicator(
//                                     value: progress,
//                                     backgroundColor: kInactiveCardColour,
//                                     valueColor: AlwaysStoppedAnimation<Color>(
//                                         kResultColour),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                   // Show All / Show Less Button
//                   if (_bmiHistory.length > 5)
//                     TextButton(
//                       onPressed: () {
//                         setState(() {
//                           _showAllResults = !_showAllResults;
//                         });
//                       },
//                       child: Text(
//                         _showAllResults ? 'Show Less' : 'Show All',
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                 ],
//               ),
//       ),
//     );
//   }
// }
// ----- halkan ka bilow -----
// import 'package:bmi_calculator/constants.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// class HistoryPage extends StatefulWidget {
//   const HistoryPage({super.key});
//
//   @override
//   _HistoryPageState createState() => _HistoryPageState();
// }
//
// class _HistoryPageState extends State<HistoryPage> {
//   List<Map<String, dynamic>> _bmiHistory = []; // To store fetched BMI history
//   List<Map<String, dynamic>> _filteredHistory =
//       []; // Filtered list based on search
//   bool _showAllResults = false; // State to control whether to show all results
//   TextEditingController _searchController =
//       TextEditingController(); // Controller for the search bar
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchUserBMIHistory(); // Fetch BMI history when the page loads
//     _searchController
//         .addListener(_filterResults); // Listen for search input changes
//   }
//
//   // Fetch BMI history data from Firestore
//   void _fetchUserBMIHistory() async {
//     final user = FirebaseAuth.instance.currentUser;
//
//     if (user != null) {
//       try {
//         QuerySnapshot snapshot = await FirebaseFirestore.instance
//             .collection('users') // Users collection
//             .doc(user.uid) // Get the user's document by UID
//             .collection('bmi_history') // BMI history sub-collection
//             .orderBy('date', descending: true)
//             .orderBy('time', descending: true)
//             .get();
//
//         List<Map<String, dynamic>> bmiHistory = snapshot.docs.map((doc) {
//           return doc.data() as Map<String, dynamic>;
//         }).toList();
//
//         setState(() {
//           _bmiHistory = bmiHistory;
//           _filteredHistory = bmiHistory; // Initially show all records
//         });
//       } catch (e) {
//         print("Error fetching BMI history: $e");
//       }
//     } else {
//       print("No user is logged in.");
//     }
//   }
//
//   // Filter BMI history based on the search input
//   void _filterResults() {
//     final query = _searchController.text.toLowerCase();
//
//     setState(() {
//       _filteredHistory = _bmiHistory.where((record) {
//         final category = record['result']?.toLowerCase() ?? '';
//         final date = record['date']?.toLowerCase() ?? '';
//         return category.contains(query) || date.contains(query);
//       }).toList();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final int itemCount = _showAllResults
//         ? _filteredHistory.length
//         : (_filteredHistory.length > 5 ? 5 : _filteredHistory.length);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('BMI History'),
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [kActiveCardColour, kInactiveCardColour],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         padding: const EdgeInsets.all(20.0),
//         child: _filteredHistory.isEmpty
//             ? const Center(child: Text('No history found'))
//             : Column(
//                 children: [
//                   // Search Bar
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: TextField(
//                       controller: _searchController,
//                       decoration: InputDecoration(
//                         filled: true,
//                         fillColor: kInactiveCardColour,
//                         hintText: 'Search BMI records',
//                         hintStyle: TextStyle(color: kLabelColour),
//                         prefixIcon: Icon(Icons.search, color: kLabelColour),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(30),
//                           borderSide: BorderSide.none,
//                         ),
//                         contentPadding:
//                             EdgeInsets.symmetric(vertical: 15, horizontal: 20),
//                       ),
//                     ),
//                   ),
//                   // History List
//                   Expanded(
//                     child: ListView.builder(
//                       itemCount: itemCount,
//                       itemBuilder: (context, index) {
//                         final record = _filteredHistory[index];
//                         final double bmi = double.parse(record['bmi'] ?? '0');
//                         final String category = record['result'] ?? 'Unknown';
//                         final String date =
//                             record['date'] ?? 'No date recorded';
//                         final String time =
//                             record['time'] ?? 'No time recorded';
//                         double progress =
//                             (bmi - 18.5) / (24.9 - 18.5); // Normalize BMI
//
//                         return Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 10.0),
//                           child: Card(
//                             color: kInactiveCardColour,
//                             elevation: 5,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(15),
//                             ),
//                             child: ListTile(
//                               contentPadding: const EdgeInsets.all(15),
//                               title: Row(
//                                 children: [
//                                   Expanded(
//                                     flex: 2,
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Row(
//                                           children: [
//                                             Icon(
//                                               Icons.trending_up,
//                                               color: kResultColour,
//                                             ),
//                                             const SizedBox(width: 8),
//                                             Text(
//                                               '$bmi',
//                                               style: const TextStyle(
//                                                 color: kLabelColour,
//                                                 fontSize: 20,
//                                                 fontWeight: FontWeight.bold,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                         Row(
//                                           children: [
//                                             Icon(
//                                               Icons.category,
//                                               color: kResultColour,
//                                             ),
//                                             const SizedBox(width: 8),
//                                             Text(
//                                               category,
//                                               style: const TextStyle(
//                                                 color: kLabelColour,
//                                                 fontSize: 16,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   Expanded(
//                                     flex: 2,
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.end,
//                                       children: [
//                                         Row(
//                                           children: [
//                                             Icon(
//                                               Icons.calendar_today,
//                                               color: kResultColour,
//                                               size: 20,
//                                             ),
//                                             const SizedBox(width: 8),
//                                             Text(
//                                               date,
//                                               style: const TextStyle(
//                                                 color: kLabelColour,
//                                                 fontSize: 16,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                         Row(
//                                           children: [
//                                             Icon(
//                                               Icons.access_time,
//                                               color: kResultColour,
//                                               size: 20,
//                                             ),
//                                             const SizedBox(width: 8),
//                                             Text(
//                                               time,
//                                               style: const TextStyle(
//                                                 color: kLabelColour,
//                                                 fontSize: 16,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               subtitle: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   const SizedBox(height: 5),
//                                   LinearProgressIndicator(
//                                     value: progress,
//                                     backgroundColor: kInactiveCardColour,
//                                     valueColor: AlwaysStoppedAnimation<Color>(
//                                         kResultColour),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                   // Show All / Show Less Button
//                   if (_filteredHistory.length > 5)
//                     TextButton(
//                       onPressed: () {
//                         setState(() {
//                           _showAllResults = !_showAllResults;
//                         });
//                       },
//                       child: Text(
//                         _showAllResults ? 'Show Less' : 'Show All',
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                 ],
//               ),
//       ),
//     );
//   }
// }

import 'package:bmi_calculator/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<Map<String, dynamic>> _bmiHistory = []; // To store fetched BMI history
  List<Map<String, dynamic>> _filteredHistory =
      []; // Filtered list based on search
  bool _showAllResults = false; // State to control whether to show all results
  TextEditingController _searchController =
      TextEditingController(); // Controller for the search bar

  @override
  void initState() {
    super.initState();
    _fetchUserBMIHistory(); // Fetch BMI history when the page loads
    _searchController
        .addListener(_filterResults); // Listen for search input changes
  }

  // Fetch BMI history data from Firestore
  void _fetchUserBMIHistory() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        QuerySnapshot snapshot = await FirebaseFirestore.instance
            .collection('users') // Users collection
            .doc(user.uid) // Get the user's document by UID
            .collection('bmi_history') // BMI history sub-collection
            .orderBy('date', descending: true)
            .orderBy('time', descending: true)
            .get();

        List<Map<String, dynamic>> bmiHistory = snapshot.docs.map((doc) {
          return doc.data() as Map<String, dynamic>;
        }).toList();

        setState(() {
          _bmiHistory = bmiHistory;
          _filteredHistory = bmiHistory; // Initially show all records
        });
      } catch (e) {
        print("Error fetching BMI history: $e");
      }
    } else {
      print("No user is logged in.");
    }
  }

  // Filter BMI history based on the search input
  void _filterResults() {
    final query = _searchController.text.toLowerCase();

    setState(() {
      _filteredHistory = _bmiHistory.where((record) {
        final category = record['result']?.toLowerCase() ?? '';
        final date = record['date']?.toLowerCase() ?? '';
        return category.contains(query) || date.contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final int itemCount = _showAllResults
        ? _filteredHistory.length
        : (_filteredHistory.length > 5 ? 5 : _filteredHistory.length);

    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI History'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [kActiveCardColour, kInactiveCardColour],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: kInactiveCardColour,
                  hintText: 'Search BMI records',
                  hintStyle: TextStyle(color: kLabelColour),
                  prefixIcon: Icon(Icons.search, color: kLabelColour),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                ),
              ),
            ),
            // History List or No Data Message
            Expanded(
              child: _filteredHistory.isEmpty
                  ? const Center(child: Text('No history found'))
                  : ListView.builder(
                      itemCount: itemCount,
                      itemBuilder: (context, index) {
                        final record = _filteredHistory[index];
                        final double bmi = double.parse(record['bmi'] ?? '0');
                        final String category = record['result'] ?? 'Unknown';
                        final String date =
                            record['date'] ?? 'No date recorded';
                        final String time =
                            record['time'] ?? 'No time recorded';
                        double progress =
                            (bmi - 18.5) / (24.9 - 18.5); // Normalize BMI

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Card(
                            color: kInactiveCardColour,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(15),
                              title: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.trending_up,
                                              color: kResultColour,
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              '$bmi',
                                              style: const TextStyle(
                                                color: kLabelColour,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.category,
                                              color: kResultColour,
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              category,
                                              style: const TextStyle(
                                                color: kLabelColour,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.calendar_today,
                                              color: kResultColour,
                                              size: 20,
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              date,
                                              style: const TextStyle(
                                                color: kLabelColour,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.access_time,
                                              color: kResultColour,
                                              size: 20,
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              time,
                                              style: const TextStyle(
                                                color: kLabelColour,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 5),
                                  LinearProgressIndicator(
                                    value: progress,
                                    backgroundColor: kInactiveCardColour,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        kResultColour),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
            // Show All / Show Less Button
            if (_filteredHistory.length > 5)
              TextButton(
                onPressed: () {
                  setState(() {
                    _showAllResults = !_showAllResults;
                  });
                },
                child: Text(
                  _showAllResults ? 'Show Less' : 'Show All',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
