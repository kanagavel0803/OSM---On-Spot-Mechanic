import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserProblemDetails extends StatelessWidget {
  final String problemType;
  final String confirmedLocation;

  UserProblemDetails({required this.problemType, required this.confirmedLocation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Problem Details'),
        backgroundColor: Color(0xFF4A8BDF),
      ),
      body: Container(
        color: Color(0xFFE3F2FD),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                height: 300,
                child: GoogleMapWidget(confirmedLocation: confirmedLocation),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                color: Color(0xFFE3F2FD),
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 8.0),
                    Text(
                      confirmedLocation,
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Problem Type',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1C1C1C)),
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      problemType,
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    SizedBox(height: 16.0),
                    TextField(
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        labelText: 'Vehicle Name',
                        labelStyle: TextStyle(color: Colors.black),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextField(
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        labelText: 'Vehicle Number',
                        labelStyle: TextStyle(color: Colors.black),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(height: 24.0),
                    ElevatedButton(
                      onPressed: () {
                        _sendRequest(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF4A8BDF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Text(
                          'Send Request',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sendRequest(BuildContext context) {
    print('Send request button pressed');
  }
}

class GoogleMapWidget extends StatelessWidget {
  final String confirmedLocation;

  GoogleMapWidget({required this.confirmedLocation});

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: _parseLatLngFromString(confirmedLocation),
        zoom: 15.0,
      ),
      markers: {
        Marker(
          markerId: MarkerId('confirmed_marker'),
          position: _parseLatLngFromString(confirmedLocation),
          infoWindow: InfoWindow(
            title: 'Confirmed Location',
          ),
        ),
      },
      onMapCreated: (GoogleMapController controller) {},
    );
  }

  LatLng _parseLatLngFromString(String location) {
    try {
      List<String> parts = location.split(',');
      if (parts.length != 2) {
        throw FormatException('Invalid format: Expected "latitude, longitude"');
      }
      double lat = double.parse(parts[0].trim());
      double lng = double.parse(parts[1].trim());
      return LatLng(lat, lng);
    } catch (e) {
      print('Error parsing coordinates: $e');
      return LatLng(0.0, 0.0);
    }
  }
}
