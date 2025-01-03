import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:osm/main.dart';

class Navbar1 extends StatelessWidget {
  const Navbar1({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF4A8BDF), Color(0xFF267EDC)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40, // Increased radius for a larger avatar
                    backgroundImage: NetworkImage(
                      'https://thumbs.dreamstime.com/b/anime-boy-avatar-ai-generative-art-man-273239994.jpg',
                    ),
                  ),
                  SizedBox(width: 16), // Spacing between avatar and text
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Kanagavel',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Rohit@gmail.com',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _createDrawerItem(
                  icon: Icons.car_repair,
                  text: 'Your Services',
                  onTap: () {
                    // Add your navigation or onTap logic here
                  },
                ),
                _createDrawerItem(
                  icon: Icons.payment,
                  text: 'Payments',
                  onTap: () {
                    // Add your navigation or onTap logic here
                  },
                ),
                _createDrawerItem(
                  icon: Icons.notifications,
                  text: 'Notifications',
                  onTap: () {
                    // Add your navigation or onTap logic here
                  },
                ),
                _createDrawerItem(
                  icon: Icons.redeem,
                  text: 'Rewards',
                  onTap: () {
                    // Add your navigation or onTap logic here
                  },
                ),
                _createDrawerItem(
                  icon: Icons.help,
                  text: 'Help',
                  onTap: () {
                    // Add your navigation or onTap logic here
                  },
                ),
                _createDrawerItem(
                  icon: Icons.settings,
                  text: 'Settings',
                  onTap: () {
                    // Add your navigation or onTap logic here
                  },
                ),
                Divider(),
                _createDrawerItem(
                  icon: Icons.logout,
                  text: 'Logout',
                  onTap: () async {
                    await FirebaseAuth.instance.signOut(); // Sign out from Firebase
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => LoginScreen()), // Redirect to login screen
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _createDrawerItem({required IconData icon, required String text, GestureTapCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, color: Color(0xFF4A8BDF)),
      title: Text(text, style: TextStyle(color: Colors.black)),
      onTap: onTap,
      trailing: Icon(Icons.chevron_right, color: Color(0xFF4A8BDF)),
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      horizontalTitleGap: 10.0,
    );
  }
}

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Color(0xFF4A8BDF), // Background color for AppBar
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            // Replace with actual Firebase login logic
            try {
              UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => OsmApp()),
              );
            } catch (e) {
              print('Failed to login: $e');
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF4A8BDF), // Background color for the button
          ),
          child: Text('Login', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
