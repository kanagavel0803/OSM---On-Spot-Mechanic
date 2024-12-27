import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'user_problem.dart';

class UserVehicle extends StatelessWidget {
  final String confirmedLocation;

  UserVehicle({required this.confirmedLocation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Vehicle'),
        backgroundColor: Color.fromARGB(255, 31, 157, 161),
      ),
      body: Container(
        color: Colors.transparent,
        child: Column(
          children: [
            Expanded(
              child: GoogleMapWidget(confirmedLocation: confirmedLocation),
            ),
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(26.0),
                topRight: Radius.circular(26.0),
              ),
              child: Container(
                color: Color.fromARGB(255, 31, 157, 161),
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      '',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      '',
                      style: TextStyle(fontSize: 6),
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
                            'Choose Type of Vehicle',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 12.0),
                          buildVehicleButton(context, '2 Wheeler', Icons.motorcycle_outlined),
                          SizedBox(height: 12.0),
                          buildVehicleButton(context, '3 Wheeler', Icons.auto_awesome),
                          SizedBox(height: 12.0),
                          buildVehicleButton(context, '4 Wheeler', Icons.directions_car),
                          SizedBox(height: 12.0),
                          buildVehicleButton(context, 'Heavy Vehicle', Icons.local_shipping),
                        ],
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

  Widget buildVehicleButton(BuildContext context, String vehicleType, IconData icon) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      onPressed: () {
        _navigateToUserProblem(context, vehicleType);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            icon,
            color: Color.fromARGB(255, 31, 157, 161),
          ),
          Text(vehicleType),
          SizedBox(width: 32.0),
        ],
      ),
    );
  }

  void _navigateToUserProblem(BuildContext context, String vehicleType) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UserProblem(vehicleType: vehicleType, confirmedLocation: confirmedLocation)),
    );
  }
}

class GoogleMapWidget extends StatefulWidget {
  final String confirmedLocation;

  GoogleMapWidget({required this.confirmedLocation});

  @override
  _GoogleMapWidgetState createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends State<GoogleMapWidget> {
  GoogleMapController? mapController;
  LatLng? _confirmedLatLng;

  @override
  void initState() {
    super.initState();
    _confirmedLatLng = _parseLatLngFromString(widget.confirmedLocation);
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _confirmedLatLng ?? LatLng(0.0, 0.0),
            zoom: 15.0,
          ),
          markers: _confirmedLatLng != null
              ? {
                  Marker(
                    markerId: MarkerId('confirmed_marker'),
                    position: _confirmedLatLng!,
                    infoWindow: InfoWindow(
                      title: 'Confirmed Location',
                    ),
                  ),
                }
              : {},
        ),
      ],
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
