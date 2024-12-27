import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:osm/user_accept.dart';

class MechRequestPage extends StatefulWidget {
  @override
  _MechRequestPageState createState() => _MechRequestPageState();
}

class _MechRequestPageState extends State<MechRequestPage> {
  GoogleMapController? mapController;
  final LatLng _center = const LatLng(12.1271, 78.1570);
  LatLng _currentPosition = const LatLng(12.1271, 78.1570);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _moveToLocation(LatLng position) {
    mapController?.animateCamera(CameraUpdate.newLatLng(position));
    setState(() {
      _currentPosition = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Ride Request'),
        backgroundColor: Color.fromARGB(255, 31, 157, 161),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2, // Adjust flex value to allocate more space for the map
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 15.0,
              ),
              markers: {
                Marker(
                  markerId: MarkerId('currentLocation'),
                  position: _currentPosition,
                ),
              },
            ),
          ),
          Expanded(
            flex: 3, // Adjust flex value to allocate space for the content
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 31, 157, 161),
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 3,
                      blurRadius: 7,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Color.fromRGBO(154, 157, 160, 1),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Kanagavel',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    InkWell(
                      onTap: () {
                        _moveToLocation(LatLng(12.1271, 78.1570));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.black,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Dharmapuri',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Problem:',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          'Puncture',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                             Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => UserAcceptPage()),
                            );
                            // Handle accept action
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 200, 162, 146),
                          ),
                          child: Text('Accept'),
                        ),
                        ElevatedButton(
                          onPressed: () {
          
                            // Handle reject action
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 200, 162, 146),
                          ),
                          child: Text('Reject'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}