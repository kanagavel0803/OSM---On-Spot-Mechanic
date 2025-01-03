import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'mech_request.dart';
import 'mech_account.dart';
import 'mech_profile.dart';

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
        title: const Text('Mech Duty'),
        backgroundColor: Color(0xFF4A8BDF),
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
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(0xFF4A8BDF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ElevatedButton.icon(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MechRequestPage()),
                  );
                },
                icon: Icon(Icons.arrow_forward),
                label: Text('View Request'),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(10),
        color: Color(0xFF4A8BDF),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildBottomIcon(Icons.build, 'Duty', Colors.white),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MechAccountPage()),
                );
              },
              child: buildBottomIcon(Icons.account_circle, 'Accounts', Colors.white),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MechProfilePage()),
                );
              },
              child: buildBottomIcon(Icons.person, 'Profile', Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBottomIcon(IconData iconData, String text, Color color) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(iconData, size: 24, color: color),
        SizedBox(height: 5),
        Text(
          text,
          style: TextStyle(fontSize: 12, color: color),
        ),
      ],
    );
  }
}
