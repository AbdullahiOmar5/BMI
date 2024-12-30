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
  DateTime? _startDate;
  DateTime? _endDate;
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

  // Function to pick a start date
  void _pickStartDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        _startDate = pickedDate;
      });
    }
  }

// Function to pick an end date
  void _pickEndDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: _startDate ?? DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        _endDate = pickedDate;
      });
    }
  }

// Function to filter history by date range
  void _filterByDateRange() {
    if (_startDate == null || _endDate == null) return;

    setState(() {
      _filteredHistory = _bmiHistory.where((record) {
        final String dateString = record['date'] ?? '';
        try {
          DateTime recordDate = DateTime.parse(dateString);
          return recordDate.isAfter(_startDate!.subtract(Duration(days: 1))) &&
              recordDate.isBefore(_endDate!.add(Duration(days: 1)));
        } catch (e) {
          return false;
        }
      }).toList();
    });
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
            // Date Range Filter UI
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Start Date Picker
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _pickStartDate,
                      icon: Icon(Icons.calendar_today, size: 18),
                      label: Text(
                        _startDate != null
                            ? "${_startDate!.toLocal()}".split(' ')[0]
                            : "Start Date",
                        style: TextStyle(fontSize: 12),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kBottomContainerColour,
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                  SizedBox(width: 8), // Space between buttons

                  // End Date Picker
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _pickEndDate,
                      icon: Icon(Icons.calendar_today, size: 18),
                      label: Text(
                        _endDate != null
                            ? "${_endDate!.toLocal()}".split(' ')[0]
                            : "End Date",
                        style: TextStyle(fontSize: 12),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kBottomContainerColour,
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                  SizedBox(width: 8), // Space between buttons

                  // Filter Button
                  ElevatedButton(
                    onPressed: _filterByDateRange,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kResultColour,
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      "Filter",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),

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
                            (bmi - 10) / (35 - 10); // Normalize BMI
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
