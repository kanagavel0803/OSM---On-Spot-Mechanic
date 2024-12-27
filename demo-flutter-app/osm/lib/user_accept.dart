import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserAcceptPage extends StatefulWidget {
  @override
  _UserAcceptPageState createState() => _UserAcceptPageState();
}

class _UserAcceptPageState extends State<UserAcceptPage> {
  GoogleMapController? mapController;
  final LatLng _center = const LatLng(40.2033, -8.4103); // Coimbra coordinates

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 31, 157, 161),
        title: Text('Order Taken'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
              target: _center,
                zoom: 14.0,
              ),
              markers: {
                Marker(
                  markerId: MarkerId('location1'),
                  position: _center,
                ),
              },
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              color: Color.fromARGB(255, 31, 157, 161),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage('assets/profile.jpg'), // Example image, replace with network image if needed
                      ),
                      SizedBox(width: 26),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'SAM CUF',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.yellow, size: 16),
                              SizedBox(width: 4),
                              Text(
                                '4.9',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'ARRIVE IN',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '12 Mins',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 36),
                  Row(
                    children: [
                      Icon(Icons.location_pin, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        'Main road',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      Spacer(),
                      Text(
                        '8:10 Pm',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.location_pin, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        'Dharmapuri',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      Spacer(),
                      Text(
                        '8:20 Pm',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
