import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'mech_request.dart';
import 'mech_account.dart';
import 'mech_profile.dart';
import 'loginpage.dart'; // Add the import for LoginScreen
import 'package:firebase_auth/firebase_auth.dart'; // Add the FirebaseAuth import

class MechDutyPage extends StatefulWidget {
  const MechDutyPage({super.key});

  @override
  MechDutyPageState createState() => MechDutyPageState();
}

class MechDutyPageState extends State<MechDutyPage> {
  GoogleMapController? mapController;
  final LatLng _center = const LatLng(11.1271, 78.6569);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mech Duty',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF4A8BDF),
        elevation: 0,
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Color(0xFF4A8BDF)),
              accountName: Text(
                'Mechanic',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              accountEmail: null,
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 50, color: Color(0xFF4A8BDF)),
              ),
            ),
            _createDrawerItem(
              icon: Icons.account_circle,
              text: 'Accounts',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MechAccountPage()),
              ),
            ),
            _createDrawerItem(
              icon: Icons.person,
              text: 'Profile',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MechProfilePage()),
              ),
            ),
            _createDrawerItem(
              icon: Icons.help,
              text: 'Help',
              onTap: () {},
            ),
            _createDrawerItem(
              icon: Icons.logout,
              text: 'Logout',
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4A8BDF),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                  textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MechRequestPage()),
                  );
                },
                icon: Icon(Icons.arrow_forward_ios),
                label: Text('View Requests'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _createDrawerItem({
    required IconData icon,
    required String text,
    required GestureTapCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Color(0xFF4A8BDF)),
      title: Text(
        text,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
      onTap: onTap,
    );
  }
}
