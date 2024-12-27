import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'user_vdetails.dart';

class UserProblem extends StatelessWidget {
  final String vehicleType;
  final String confirmedLocation;

  UserProblem({required this.vehicleType, required this.confirmedLocation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Problem'),
        backgroundColor: Color.fromARGB(255, 31, 157, 161),
      ),
      body: Container(
        color: Color.fromARGB(255, 31, 157, 161),
        child: Column(
          children: [
            Expanded(
              child: GoogleMapWidgetForProblem(confirmedLocation: confirmedLocation),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    vehicleType,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    confirmedLocation,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  SizedBox(height: 6.0),
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 31, 157, 161),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: EdgeInsets.all(6.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Choose the problem',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 12.0),
                        buildProblemButton(context, 'Puncture', Icons.car_repair),
                        SizedBox(height: 12.0),
                        buildProblemButton(context, 'Vehicle starting problem', Icons.warning),
                        SizedBox(height: 12.0),
                        buildProblemButton(context, 'Engine Fuse', Icons.build),
                        SizedBox(height: 12.0),
                        buildProblemButton(context, 'Customization services', Icons.miscellaneous_services),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProblemButton(BuildContext context, String problemType, IconData icon) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      onPressed: () {
        _navigateToUserProblemDetails(context, problemType);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            icon,
            color: Color.fromARGB(255, 31, 157, 161),
          ),
          Text(problemType),
          SizedBox(width: 32.0),
        ],
      ),
    );
  }

  void _navigateToUserProblemDetails(BuildContext context, String problemType) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserProblemDetails(
          problemType: problemType,
          confirmedLocation: confirmedLocation,
        ),
      ),
    );
  }
}

class GoogleMapWidgetForProblem extends StatelessWidget {
  final String confirmedLocation;

  GoogleMapWidgetForProblem({required this.confirmedLocation});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300, // Adjust height as needed
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _parseLatLngFromString(confirmedLocation),
          zoom: 15.0,
        ),
        markers: {
          Marker(
            markerId: MarkerId('problem_marker'),
            position: _parseLatLngFromString(confirmedLocation),
            infoWindow: InfoWindow(
              title: 'Confirmed Location',
            ),
          ),
        },
        onMapCreated: (GoogleMapController controller) {},
      ),
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
