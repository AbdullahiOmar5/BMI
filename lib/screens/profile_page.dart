// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../constants.dart';
// import 'login_page.dart';
//
// class ProfilePage extends StatefulWidget {
//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }
//
// class _ProfilePageState extends State<ProfilePage> {
//   // User Data Variables
//   String _username = "Loading...";
//   String _email = "Loading...";
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchUserData();
//   }
//
//   // Fetch user data from Firebase
//   Future<void> _fetchUserData() async {
//     try {
//       // Fetch current user from FirebaseAuth
//       User? user = FirebaseAuth.instance.currentUser;
//
//       if (user != null) {
//         setState(() {
//           _email = user.email ?? "No Email";
//         });
//
//         // Fetch additional user data (like username) from Firestore
//         DocumentSnapshot userDoc = await FirebaseFirestore.instance
//             .collection(
//                 'users') // Change 'users' to your Firestore collection name
//             .doc(user.uid) // Document ID should match the user's UID
//             .get();
//
//         if (userDoc.exists) {
//           setState(() {
//             _username = userDoc['username'] ?? "No Username";
//           });
//         }
//       }
//     } catch (e) {
//       print("Error fetching user data: $e");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
//
//     return Scaffold(
//       backgroundColor: isDarkMode ? kInactiveCardColour : Colors.white,
//       appBar: AppBar(
//         backgroundColor: isDarkMode ? kInactiveCardColour : Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back,
//               color: isDarkMode ? Colors.white : kLabelColour),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           SizedBox(height: 20),
//           CircleAvatar(
//             radius: 60,
//             backgroundImage: AssetImage('assets/user.png'),
//           ),
//           SizedBox(height: 10),
//           Text(
//             _username, // Display fetched username
//             style: kTitleTextStyle.copyWith(
//               fontSize: 22,
//               color: isDarkMode ? Colors.white : kActiveCardColour,
//             ),
//           ),
//           Text(
//             _email, // Display fetched email
//             style: kLabelTextStyle.copyWith(
//               color: isDarkMode ? Colors.white70 : kLabelColour,
//             ),
//           ),
//           SizedBox(height: 20),
//           Expanded(
//             child: ListView(
//               children: [
//                 _buildMenuItem(
//                   icon: Icons.settings,
//                   text: 'Settings',
//                   onTap: () {
//                     // Navigate to Settings Page
//                     print("Navigate to Settings");
//                   },
//                   isDarkMode: isDarkMode,
//                 ),
//                 _buildMenuItem(
//                   icon: Icons.help_outline,
//                   text: 'Help & Support',
//                   onTap: () {
//                     // Navigate to Help & Support
//                     print("Navigate to Help & Support");
//                   },
//                   isDarkMode: isDarkMode,
//                 ),
//                 _buildMenuItem(
//                   icon: Icons.privacy_tip,
//                   text: 'Privacy Policy',
//                   onTap: () {
//                     // Navigate to Privacy Policy
//                     print("Navigate to Privacy Policy");
//                   },
//                   isDarkMode: isDarkMode,
//                 ),
//                 _buildMenuItem(
//                   icon: Icons.logout,
//                   text: 'Logout',
//                   onTap: () {
//                     _logout(context);
//                   },
//                   isDarkMode: isDarkMode,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // Reusable Menu Item Widget
//   Widget _buildMenuItem({
//     required IconData icon,
//     required String text,
//     required VoidCallback onTap,
//     required bool isDarkMode,
//   }) {
//     return ListTile(
//       leading: Icon(icon, color: isDarkMode ? Colors.white : kActiveCardColour),
//       title: Text(
//         text,
//         style: kLabelTextStyle.copyWith(
//           fontSize: 16,
//           color: isDarkMode ? Colors.white : kLabelColour,
//         ),
//       ),
//       trailing: Icon(
//         Icons.arrow_forward_ios, // Arrow icon at the end
//         size: 16,
//         color: isDarkMode ? Colors.white54 : Colors.grey,
//       ),
//       onTap: onTap,
//     );
//   }
//
//   // Logout Function
//   void _logout(BuildContext context) {
//     FirebaseAuth.instance.signOut(); // Sign out the user
//     Navigator.of(context).pushAndRemoveUntil(
//       MaterialPageRoute(builder: (context) => LoginPage()),
//       (Route<dynamic> route) => false,
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../constants.dart';
// import 'login_page.dart';
//
// class ProfilePage extends StatefulWidget {
//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }
//
// class _ProfilePageState extends State<ProfilePage> {
//   String _username = "Loading...";
//   String _email = "Loading...";
//   bool _isEditing = false;
//
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchUserData();
//   }
//
//   Future<void> _fetchUserData() async {
//     try {
//       User? user = FirebaseAuth.instance.currentUser;
//
//       if (user != null) {
//         setState(() {
//           _email = user.email ?? "No Email";
//           _emailController.text = _email;
//         });
//
//         DocumentSnapshot userDoc = await FirebaseFirestore.instance
//             .collection('users')
//             .doc(user.uid)
//             .get();
//
//         if (userDoc.exists) {
//           setState(() {
//             _username = userDoc['username'] ?? "No Username";
//             _usernameController.text = _username;
//           });
//         }
//       }
//     } catch (e) {
//       print("Error fetching user data: $e");
//     }
//   }
//
//   // Future<void> _updateUserProfile() async {
//   //   try {
//   //     User? user = FirebaseAuth.instance.currentUser;
//   //
//   //     if (user != null) {
//   //       await user.updateEmail(_emailController.text);
//   //
//   //       await FirebaseFirestore.instance
//   //           .collection('users')
//   //           .doc(user.uid)
//   //           .update({
//   //         'username': _usernameController.text,
//   //       });
//   //
//   //       setState(() {
//   //         _username = _usernameController.text;
//   //         _email = _emailController.text;
//   //         _isEditing = false;
//   //       });
//   //
//   //       ScaffoldMessenger.of(context).showSnackBar(
//   //         SnackBar(content: Text('Profile updated successfully!')),
//   //       );
//   //     }
//   //   } catch (e) {
//   //     print("Error updating profile: $e");
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       SnackBar(content: Text('Failed to update profile: $e')),
//   //     );
//   //   }
//   // }
//   Future<void> _updateUserProfile() async {
//     try {
//       User? user = FirebaseAuth.instance.currentUser;
//
//       if (user != null) {
//         // If the email is being updated, send a verification email
//         if (_emailController.text != _email) {
//           // Send verification email to the new email
//           await user.verifyBeforeUpdateEmail(_emailController.text);
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text(
//                 'A verification email has been sent to the new email address. Please verify it before updating.',
//               ),
//             ),
//           );
//           return; // Exit here to wait for the verification
//         }
//
//         // Update Firestore (if username was changed)
//         await FirebaseFirestore.instance
//             .collection('users')
//             .doc(user.uid)
//             .update({
//           'username': _usernameController.text,
//         });
//
//         setState(() {
//           _username = _usernameController.text;
//           _email = _emailController.text;
//           _isEditing = false;
//         });
//
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Profile updated successfully!')),
//         );
//       }
//     } catch (e) {
//       print("Error updating profile: $e");
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to update profile: $e')),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
//
//     return Scaffold(
//       backgroundColor: isDarkMode ? kInactiveCardColour : Colors.white,
//       appBar: AppBar(
//         backgroundColor: isDarkMode ? kInactiveCardColour : Colors.white,
//         elevation: 0,
//         title: Text('Profile Page'),
//         // leading: IconButton(
//         //   icon: Icon(Icons.arrow_back,
//         //       color: isDarkMode ? Colors.white : kLabelColour),
//         //   onPressed: () {
//         //     Navigator.pop(context);
//         //   },
//         // ),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           SizedBox(height: 20),
//           Stack(
//             alignment: Alignment.bottomRight,
//             children: [
//               CircleAvatar(
//                 radius: 60,
//                 backgroundImage: AssetImage('assets/user.png'),
//               ),
//               Positioned(
//                 bottom: 5,
//                 right: 5,
//                 child: GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       _isEditing = !_isEditing;
//                     });
//                   },
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: kLabelColour,
//                       shape: BoxShape.circle,
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black26,
//                           blurRadius: 4,
//                           offset: Offset(0, 2),
//                         ),
//                       ],
//                     ),
//                     padding: EdgeInsets.all(8),
//                     child: Icon(
//                       Icons.edit,
//                       color: isDarkMode ? kInactiveCardColour : Colors.white,
//                       size: 20,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 10),
//           Text(
//             _username,
//             style: kTitleTextStyle.copyWith(
//               fontSize: 22,
//               color: isDarkMode ? Colors.white : kActiveCardColour,
//             ),
//           ),
//           Text(
//             _email,
//             style: kLabelTextStyle.copyWith(
//               color: isDarkMode ? Colors.white70 : kLabelColour,
//             ),
//           ),
//           SizedBox(height: 20),
//           if (_isEditing)
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Column(
//                 children: [
//                   TextField(
//                     controller: _usernameController,
//                     decoration: InputDecoration(labelText: 'Username'),
//                   ),
//                   SizedBox(height: 10),
//                   TextField(
//                     controller: _emailController,
//                     decoration: InputDecoration(labelText: 'Email'),
//                   ),
//                   SizedBox(height: 10),
//                   TextField(
//                     controller: _passwordController,
//                     decoration: InputDecoration(labelText: 'New Password'),
//                     obscureText: true,
//                   ),
//                   SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: _updateUserProfile,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: kBottomContainerColour,
//                     ),
//                     child: Text('Save Changes'),
//                   ),
//                   SizedBox(height: 10),
//                   OutlinedButton(
//                     onPressed: () {
//                       setState(() {
//                         _isEditing = false;
//                       });
//                     },
//                     style: OutlinedButton.styleFrom(
//                       foregroundColor: kLabelColour,
//                     ),
//                     child: Text('Cancel'),
//                   ),
//                 ],
//               ),
//             ),
//           if (!_isEditing)
//             Expanded(
//               child: ListView(
//                 children: [
//                   _buildMenuItem(
//                     icon: Icons.settings,
//                     text: 'Settings',
//                     onTap: () {},
//                     isDarkMode: isDarkMode,
//                   ),
//                   _buildMenuItem(
//                     icon: Icons.help_outline,
//                     text: 'Help & Support',
//                     onTap: () {},
//                     isDarkMode: isDarkMode,
//                   ),
//                   _buildMenuItem(
//                     icon: Icons.privacy_tip,
//                     text: 'Privacy Policy',
//                     onTap: () {},
//                     isDarkMode: isDarkMode,
//                   ),
//                   _buildMenuItem(
//                     icon: Icons.logout,
//                     text: 'Logout',
//                     onTap: () {
//                       _logout(context);
//                     },
//                     isDarkMode: isDarkMode,
//                   ),
//                 ],
//               ),
//             ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildMenuItem({
//     required IconData icon,
//     required String text,
//     required VoidCallback onTap,
//     required bool isDarkMode,
//   }) {
//     return ListTile(
//       leading: Icon(icon, color: isDarkMode ? Colors.white : kActiveCardColour),
//       title: Text(
//         text,
//         style: kLabelTextStyle.copyWith(
//           fontSize: 16,
//           color: isDarkMode ? Colors.white : kLabelColour,
//         ),
//       ),
//       trailing: Icon(
//         Icons.arrow_forward_ios,
//         size: 16,
//         color: isDarkMode ? Colors.white54 : Colors.grey,
//       ),
//       onTap: onTap,
//     );
//   }
//
//   void _logout(BuildContext context) {
//     FirebaseAuth.instance.signOut();
//     Navigator.of(context).pushAndRemoveUntil(
//       MaterialPageRoute(builder: (context) => LoginPage()),
//       (Route<dynamic> route) => false,
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../constants.dart';
import 'login_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _username = "Loading...";
  String _email = "Loading...";
  bool _isEditing = false;
  bool _isDarkMode = true; // Default mode is dark

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        setState(() {
          _email = user.email ?? "No Email";
          _emailController.text = _email;
        });

        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (userDoc.exists) {
          setState(() {
            _username = userDoc['username'] ?? "No Username";
            _usernameController.text = _username;
          });
        }
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  Future<void> _updateUserProfile() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        if (_emailController.text != _email) {
          await user.verifyBeforeUpdateEmail(_emailController.text);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  'A verification email has been sent to the new email address. Please verify it before updating.'),
            ),
          );
          return;
        }

        if (_passwordController.text.isNotEmpty) {
          await user.updatePassword(_passwordController.text);
        }

        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({
          'username': _usernameController.text,
        });

        setState(() {
          _username = _usernameController.text;
          _email = _emailController.text;
          _isEditing = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile updated successfully!')),
        );
      }
    } catch (e) {
      print("Error updating profile: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update profile: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _isDarkMode ? kInactiveCardColour : Colors.white,
      appBar: AppBar(
        title: Text("Profile Page"),
        // backgroundColor: _isDarkMode ? kInactiveCardColour : Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              _isDarkMode ? Icons.light_mode : Icons.dark_mode,
              color: _isDarkMode ? Colors.white : Colors.black,
            ),
            onPressed: () {
              setState(() {
                _isDarkMode = !_isDarkMode; // Toggle theme state
              });
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/user.png'),
              ),
              Positioned(
                bottom: 5,
                right: 5,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _isEditing = !_isEditing;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: _isDarkMode ? Colors.white : Colors.black,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(8),
                    child: Icon(
                      Icons.edit,
                      color: _isDarkMode ? kInactiveCardColour : Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            _username,
            style: kTitleTextStyle.copyWith(
              fontSize: 22,
              color: _isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          Text(
            _email,
            style: kLabelTextStyle.copyWith(
              color: _isDarkMode ? Colors.white70 : Colors.black,
            ),
          ),
          SizedBox(height: 20),
          if (_isEditing)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      labelStyle: TextStyle(
                          color: _isDarkMode ? Colors.white : Colors.black),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(
                          color: _isDarkMode ? Colors.white : Colors.black),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'New Password',
                      labelStyle: TextStyle(
                          color: _isDarkMode ? Colors.white : Colors.black),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _updateUserProfile,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kBottomContainerColour,
                    ),
                    child: Text('Save Changes'),
                  ),
                  SizedBox(height: 10),
                  OutlinedButton(
                    onPressed: () {
                      setState(() {
                        _isEditing = false;
                      });
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: kLabelColour,
                    ),
                    child: Text('Cancel'),
                  ),
                ],
              ),
            ),
          if (!_isEditing)
            Expanded(
              child: ListView(
                children: [
                  _buildMenuItem(
                    icon: Icons.settings,
                    text: 'Settings',
                    onTap: () {},
                    isDarkMode: _isDarkMode,
                  ),
                  _buildMenuItem(
                    icon: Icons.help_outline,
                    text: 'Help & Support',
                    onTap: () {},
                    isDarkMode: _isDarkMode,
                  ),
                  _buildMenuItem(
                    icon: Icons.privacy_tip,
                    text: 'Privacy Policy',
                    onTap: () {},
                    isDarkMode: _isDarkMode,
                  ),
                  _buildMenuItem(
                    icon: Icons.logout,
                    text: 'Logout',
                    onTap: () {
                      _logout(context);
                    },
                    isDarkMode: _isDarkMode,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    required bool isDarkMode,
  }) {
    return ListTile(
      leading: Icon(icon, color: isDarkMode ? Colors.white : Colors.black),
      title: Text(
        text,
        style: kLabelTextStyle.copyWith(
          fontSize: 16,
          color: isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: isDarkMode ? Colors.white54 : Colors.grey,
      ),
      onTap: onTap,
    );
  }

  void _logout(BuildContext context) {
    FirebaseAuth.instance.signOut();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => LoginPage()),
      (Route<dynamic> route) => false,
    );
  }
}
