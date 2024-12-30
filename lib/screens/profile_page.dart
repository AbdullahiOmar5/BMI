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
