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
        backgroundColor: const Color(0xFF4A8BDF),
        title: const Text('Order Taken', style: TextStyle(color: Colors.white)),
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
                  markerId: const MarkerId('location1'),
                  position: _center,
                ),
              },
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              color: const Color(0xFF4A8BDF),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage('assets/profile.jpg'), 
                      ),
                      const SizedBox(width: 26),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Srinivasan',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: const [
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
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: const [
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
                  const SizedBox(height: 36),
                  Row(
                    children: const [
                      Icon(Icons.location_pin, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        'Puduvayol',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      Spacer(),
                      Text(
                        '8:10 Pm',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: const [
                      Icon(Icons.location_pin, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        'R.M.K',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      Spacer(),
                      Text(
                        '8:20 Pm',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
Card(
  color: Colors.grey[300],  // Light gray color for the card
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),  // Rounded corners
  ),
  elevation: 2,  // Slight shadow for depth
  child: Padding(
    padding: const EdgeInsets.all(12.0),  // Add some padding inside the card
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Problem:',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Puncture',
          style: TextStyle(
            color: Colors.black54,
            fontSize: 16,
          ),
        ),
        Divider(color: Colors.black26),  // A thin line to separate
        SizedBox(height: 4),
        Text(
          'Estimated Amount:',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4),
        Text(
          '₹300',
          style: TextStyle(
            color: Colors.black54,
            fontSize: 16,
          ),
        ),
      ],
    ),
  ),
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
