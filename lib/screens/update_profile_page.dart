import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _auth = FirebaseAuth.instance;
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isEditing = false;
  bool _isLoading = false;

  Future<void> _updateProfile() async {
    final user = _auth.currentUser;
    final username = _usernameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (username.isEmpty && email.isEmpty && password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in at least one field to update.')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Update username
      if (username.isNotEmpty) {
        await user?.updateDisplayName(username);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user?.uid)
            .update({'username': username});
      }

      // Update email
      if (email.isNotEmpty) {
        await user?.updateEmail(email);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user?.uid)
            .update({'email': email});
      }

      // Update password
      if (password.isNotEmpty) {
        await user?.updatePassword(password);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile updated successfully!')),
      );

      setState(() {
        _isEditing = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display Profile Details
            Text(
              'Username: ${_auth.currentUser?.displayName ?? 'No username'}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Email: ${_auth.currentUser?.email ?? 'No email'}',
              style: TextStyle(fontSize: 18),
            ),

            // Pencil Icon to Edit
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(Icons.edit, color: Colors.blue),
                onPressed: () {
                  setState(() {
                    _isEditing = !_isEditing;
                  });
                },
              ),
            ),

            // Update Form
            Visibility(
              visible: _isEditing,
              child: Column(
                children: [
                  SizedBox(height: 16),
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: 'New Username',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'New Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'New Password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _updateProfile,
                    child: _isLoading
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text('Save Changes'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
