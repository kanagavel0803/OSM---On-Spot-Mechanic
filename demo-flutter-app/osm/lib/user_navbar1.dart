import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:osm/main.dart';

class Navbar1 extends StatelessWidget {
  const Navbar1({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Kanagavel'),
            accountEmail: Text('Rohit@gmail.com'),
            currentAccountPicture: CircleAvatar(
              child: Image.network(
                'https://thumbs.dreamstime.com/b/anime-boy-avatar-ai-generative-art-man-273239994.jpg',
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                image: NetworkImage(
                  'https://tse1.mm.bing.net/th/id/OIP.0wL9NJJzsFl_ej_cnXqbKgHaEE?rs=1&pid=ImgDetMain',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.car_repair),
            title: Text('Your Services'),
            onTap: () {
              // Add your navigation or onTap logic here
            },
          ),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Payments'),
            onTap: () {
              // Add your navigation or onTap logic here
            },
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notifications'),
            onTap: () {
              // Add your navigation or onTap logic here
            },
          ),
          ListTile(
            leading: Icon(Icons.redeem),
            title: Text('Rewards'),
            onTap: () {
              // Add your navigation or onTap logic here
            },
          ),
          ListTile(
            leading: Icon(Icons.help),
            title: Text('Help'),
            onTap: () {
              // Add your navigation or onTap logic here
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              // Add your navigation or onTap logic here
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () async {
              await FirebaseAuth.instance.signOut(); // Sign out from Firebase
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => LoginScreen()), // Redirect to login screen
              );
            },
          ),
        ],
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
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
          child: Text('Login'),
        ),
      ),
    );
  }
}
